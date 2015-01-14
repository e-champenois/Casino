function askBet(game)
%This function gets the bets for a hand from the ActivePlayers, and adds
%those who have a valid bet to the BettingPlayers array.
set(game.UI.Title1,'Position',[0.3 0.9 0.4 0.1],...
    'Visible','on',...
    'String','Place your bets');

if length(game.ActivePlayers) == 4
    x = 0.05;
else
    x = -(19*length(game.ActivePlayers)-69)/160; %1 = 2*x + 0.1375*n + 0.1*n + 0.1375
end

set(game.UI.Title2, 'Position',[0.4 0.5 0.2 0.1],...
    'Visible','on',...
    'String','Bets:');

for i = 1:length(game.ActivePlayers)
    fund = game.ActivePlayers{i}.Funds;
    fundstr = ['$' num2str(fund)];
    if round(fund) == fund
        fundstr = [fundstr '.00'];
    elseif round(fund*10) == fund*10
        fundstr = [fundstr '0'];
    end
    set(game.UI.NameTexts{i},'Position',[x+(i-1)*(0.1875+0.05) 0.7 0.1875 0.1],...
        'String', game.ActivePlayers{i}.Name,...
        'Visible','on');
    set(game.UI.FundTexts{i},'Position',[x+(i-1)*(0.1875+0.05) 0.6 0.1875 0.1],...
        'String', fundstr,...
        'Visible','on');
    set(game.UI.RemoveButtons{i},'Position',[x+(i-1)*(0.1875+0.05)+0.1875 0.7 0.025 0.1],...
        'CallBack',@(h,d) removePlayer(h,d),...
        'Visible','on');
    set(game.UI.BetBoxes{i},'Position',[x+(i-1)*(0.1875+0.05) 0.4 0.1875 0.1],...
        'Visible','on',...
        'Style','edit',...
        'String',num2str(game.ActivePlayers{i}.BetB));
end
if length(game.ActivePlayers) < 4
    namelist = {};
    playingnamelist = {};
    for i = 1:length(game.ActivePlayers)
        playingnamelist{i} = game.ActivePlayers{i}.Name;
    end
    for i = 1:length(game.Casino.ActivePlayers)
        if ~any(strcmpi(game.Casino.ActivePlayers{i}.Name, playingnamelist))
            namelist{length(namelist)+1} = game.Casino.ActivePlayers{i}.Name;
        end
    end
    if length(game.ActivePlayers) < length(game.Casino.ActivePlayers)
        set(game.UI.AddMenu,'Position',[x+length(game.ActivePlayers)*(0.1875+0.05) 0.7 0.1875 0.1],...
            'String',namelist,...
            'Visible','on');
        
        set(game.UI.AddButton,'Position',[x+length(game.ActivePlayers)*(0.1875+0.05) 0.6 0.1875 0.1],...
            'String','Add Player',...
            'CallBack',@(h,d) addPlayer(h,d),...
            'Visible','on');
    end
end
set(game.UI.NextButton,'Position',[0.3 0.2 0.2 0.1],...
    'String','Deal',...
    'Visible','on',...
    'CallBack',@(h,d) deal_callback);
set(game.UI.LeaveButton,'Position',[0.5 0.2 0.2 0.1],...
    'Visible','on',...
    'CallBack',@(h,d) leave_callback);
    function deal_callback(h,d)
        bets = [];
        err = 0;
        for i = 1:length(game.ActivePlayers)
            bet = get(game.UI.BetBoxes{i},'String');
            [a,b] = strread(bet, '%s %s', 'delimiter', '.');
            if isempty(b)
                errlength = 1;
            elseif length(b{1}) < 3
                errlength = 1;
            else
                errlength = 0;
            end
            bet = str2double(bet);
            bets(i) = bet;
            
            if isa(bet, 'double') && isreal(bet) && errlength
                if bet >= 0
                    if bet <= game.ActivePlayers{i}.Funds
                        game.ActivePlayers{i}.BetB = round(bet*100)/100;
                    else
                        errordlg([game.ActivePlayers{i}.Name ' has an invalid bet.']);
                        err = 1;
                        break
                    end
                else
                    errordlg([game.ActivePlayers{i}.Name ' has an invalid bet.']);
                    err = 1;
                    break
                end
            else
                
                errordlg([game.ActivePlayers{i}.Name ' has an invalid bet.']);
                err = 1;
                break
            end
        end
        if err == 0
            if any(bets > 0)
                for i = 1:length(game.ActivePlayers)
                    if game.ActivePlayers{i}.BetB > 0
                        game.BettingPlayers{length(game.BettingPlayers)+1} = game.ActivePlayers{i};
                    end
                end
                game.Stage = 'iniDeal';
                set(game.UI.Title1,'Visible','off');
                set(game.UI.Title2,'Visible','off');
                set(game.UI.AddMenu,'Visible','off');
                set(game.UI.AddButton,'Visible','off');
                set(game.UI.NextButton,'Visible','off');
                set(game.UI.LeaveButton,'Visible','off');
                for k = 1:length(game.ActivePlayers)
                    set(game.UI.NameTexts{k},'Visible','off');
                    set(game.UI.FundTexts{k},'Visible','off');
                    set(game.UI.BetBoxes{k},'Visible','off');
                    set(game.UI.RemoveButtons{k},'Visible','off');
                end
                play(game);
            else
                errordlg('Place your bets first.');
            end
        end
    end

    function leave_callback(h,d)
        game.Stage = 'close';
        set(game.UI.Title1,'Visible','off');
        set(game.UI.Title2,'Visible','off');
        set(game.UI.AddMenu,'Visible','off');
        set(game.UI.AddButton,'Visible','off');
        set(game.UI.NextButton,'Visible','off');
        set(game.UI.LeaveButton,'Visible','off');
        for k = 1:length(game.ActivePlayers)
            set(game.UI.NameTexts{k},'Visible','off');
            set(game.UI.FundTexts{k},'Visible','off')
            set(game.UI.BetBoxes{k},'Visible','off');
            set(game.UI.RemoveButtons{k},'Visible','off');
        end
        play(game);
    end
    function addPlayer(h,d)
        namelist = get(game.UI.AddMenu,'String');
        val = get(game.UI.AddMenu,'Value');
        addname = namelist{val};
        for k = 1:length(game.Casino.ActivePlayers)
            if strcmp(addname, game.Casino.ActivePlayers{k}.Name)
                game.ActivePlayers{length(game.ActivePlayers)+1} = game.Casino.ActivePlayers{k};
                game.ActivePlayers{length(game.ActivePlayers)}.BetB = 0;
                break
            end
        end
        game.Stage = 'betting';
        set(game.UI.Title1,'Visible','off');
        set(game.UI.Title2,'Visible','off');
        set(game.UI.AddMenu,'Visible','off');
        set(game.UI.AddButton,'Visible','off');
        set(game.UI.NextButton,'Visible','off');
        set(game.UI.LeaveButton,'Visible','off');
        for k = 1:length(game.ActivePlayers)
            set(game.UI.NameTexts{k},'Visible','off');
            set(game.UI.FundTexts{k},'Visible','off')
            set(game.UI.BetBoxes{k},'Visible','off');
            set(game.UI.RemoveButtons{k},'Visible','off');
        end
        set(game.UI.AddMenu,'Value',1);
        play(game);
    end
    function removePlayer(h,d)
        for k = 1:length(game.ActivePlayers)
            if h == game.UI.RemoveButtons{k}
                n = k;
                break
            end
        end
        
        game.Stage = 'betting';
        set(game.UI.Title1,'Visible','off');
        set(game.UI.Title2,'Visible','off');
        set(game.UI.AddMenu,'Visible','off');
        set(game.UI.AddButton,'Visible','off');
        set(game.UI.NextButton,'Visible','off');
        set(game.UI.LeaveButton,'Visible','off');
        for k = 1:length(game.ActivePlayers)
            set(game.UI.NameTexts{k},'Visible','off');
            set(game.UI.FundTexts{k},'Visible','off')
            set(game.UI.BetBoxes{k},'Visible','off');
            set(game.UI.RemoveButtons{k},'Visible','off');
        end
        game.ActivePlayers(n) = [];
        play(game);
    end
end