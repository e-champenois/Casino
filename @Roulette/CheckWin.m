function CheckWin(rou,Showpanel,t)
% This method checks to see if any of the players playing roulette have
% money any money based on the winning value.

LeaveButton = uicontrol('Parent',rou.Wheel.WheelPanel,...% the Leave button
    'Style','pushbutton',...
    'String', 'Leave Roulette.',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.35 .03 .3 .05],...
    'Callback',@leave_callback);
PlayButton = uicontrol('Parent',Showpanel,...% the Play Again button
    'Style','pushbutton',...
    'String', 'Play Again',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.7 .2 .27 .1],...
    'Callback',@play_callback);
ChangeButton = uicontrol('Parent',Showpanel,...% the Change players button
    'Style','pushbutton',...
    'String', 'Change Players',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.7 .05 .27 .1],...
    'Callback',@change_callback);
top = {'1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15'...
    '16' '17' '18'};
bot = {'19' '20' '21' '22' '23' '24' '25' '26' '27' '28' '29' '30' '31'...
    '32' '33' '34' '35' '36'};
doz1 = {'1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11' '12'};
doz2 = {'13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' '24'};
doz3 = {'25' '26' '27' '28' '29' '30' '31' '32' '33' '34' '35' '36'};
odd = {'1' '3' '5' '7' '9' '11' '13' '15' '17' '19' '21' '23' '25' '27'...
    '29' '31' '33' '35'};
even = {'2' '4' '6' '8' '10' '12' '14' '16' '18' '20' '22' '24' '26' '28'...
    '30' '32' '34' '36'};
red = {'1' '3' '5' '7' '9' '12' '14' '16' '18' '19' '21' '23' '25' '27'...
    '30' '32' '34' '36'};
black = {'2' '4' '6' '8' '10' '11' '13' '15' '17' '20' '22' '24' '26'...
    '28' '29' '31' '33' '35'};
colm1 = {'1' '4' '7' '10' '13' '16' '19' '22' '25' '28' '31' '34'};
colm2 = {'2' '5' '8' '11' '14' '17' '20' '23' '26' '29' '32' '35'};
colm3 = {'3' '6' '9' '12' '15' '18' '21' '24' '27' '30' '33' '36'};
for i = 1:length(rou.Casino.CurrentPlayers)
    loss = 0;
    dat = get(t{i},'Data');
    loss = sum(dat(1:end-1));
    set(t{i},'ColumnName',{'Bet','Win','Gain','Loss','Overall Change'})
    set(t{i},'ColumnFormat',{'numeric' 'logical' 'numeric','numeric','numeric'})
    set(t{i},'ColumnEditable',[false false false false false])
    play1 = rou.Casino.CurrentPlayers{i};
    win = false(length(play1.Places),1);
    w = 0; s = 0; gain = zeros(length(play1.Places),1); lossb = zeros(length(play1.Places),1);
    for j = 1:length(play1.Places)
        switch play1.Places{j}  %checks to see if any place won for player i
            case 'Black'
                if any(strcmpi(black,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 2*play1.Bet(j)+s;
                    gain(j) = play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case 'Red'
                if any(strcmpi(red,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 2*play1.Bet(j)+s;
                    gain(j) = play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case '1-12'
                if any(strcmpi(doz1,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 3*play1.Bet(j)+s;
                    gain(j) = 2*play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case '13-24'
                if any(strcmpi(doz2,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 3*play1.Bet(j)+s;
                    gain(j) = 2*play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case '25-36'
                if any(strcmpi(doz3,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 3*play1.Bet(j)+s;
                    gain(j) = 2*play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case 'Odd'
                if any(strcmpi(odd,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 2*play1.Bet(j)+s;
                    gain(j) = play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case 'Even'
                if any(strcmpi(even,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 2*play1.Bet(j)+s;
                    gain(j) = play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case '1-18'
                if any(strcmpi(top,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 2*play1.Bet(j)+s;
                    gain(j) = play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case '19-36'
                if any(strcmpi(bot,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 2*play1.Bet(j)+s;
                    gain(j) = play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case 'Column1'
                if any(strcmpi(colm1,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 3*play1.Bet(j)+s;
                    gain(j) = 2*play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case 'Column2'
                if any(strcmpi(colm2,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 3*play1.Bet(j)+s;
                    gain(j) = 2*play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            case 'Column3'
                if any(strcmpi(colm3,rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 3*play1.Bet(j)+s;
                    gain(j) = 2*play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
            otherwise
                if any(strcmpi(play1.Places{j},rou.WinValue))
                    win(j) = true;
                    w = 1;
                    s = 36*play1.Bet(j)+s;
                    gain(j) = 35*play1.Bet(j);
                else
                    lossb(j) = play1.Bet(j);
                end
        end
    end
    if w == 1
        funds = rou.Casino.CurrentPlayers{i}.Funds;
        funds = funds + s - loss;
        fundss = mat2str(funds);
        rou.Casino.CurrentPlayers{i}.EditFunds(s-loss);
        rou.Casino.CurrentPlayers{i}.AddResult(s-loss,'R');
        uicontrol('Parent',Showpanel,...  %Display's player i's name and won
            'Backgroundcolor',get(rou.Casino.Figure,'color'),...
            'Style','text',...
            'String',[rou.Casino.CurrentPlayers{i}.Name ' won!'],...
            'FontSize',15,...
            'Units','normalized',...
            'Position',[.7 1.05-.15*i .27 .05]);
        uicontrol('Parent',Showpanel,...  %Display's player i's money
            'Backgroundcolor', get(rou.Casino.Figure,'color'),...
            'Style','text',...
            'String',['Your money: ' fundss],...
            'FontSize',15,...
            'Units','normalized',...
            'Position',[.7 .99-.15*i .27 .07]);
    else
        funds = rou.Casino.CurrentPlayers{i}.Funds;
        fundss = mat2str(funds-loss);
        rou.Casino.CurrentPlayers{i}.EditFunds(0-loss);
        rou.Casino.CurrentPlayers{i}.AddResult(0-loss,'R');
        uicontrol('Parent',Showpanel,...  %Display's player i's name and lost
            'Backgroundcolor', get(rou.Casino.Figure,'color'),...
            'Style','text',...
            'String',[rou.Casino.CurrentPlayers{i}.Name ' lost!'],...
            'FontSize',15,...
            'Units','normalized',...
            'Position',[.7 1.05-.15*i .27 .05]);
        uicontrol('Parent',Showpanel,...   %Display's player i's money
            'Backgroundcolor', get(rou.Casino.Figure,'color'),...
            'Style','text',...
            'String',['Your money: ' fundss],...
            'FontSize',15,...
            'Units','normalized',...
            'Position',[.7 .99-.15*i .27 .07]);
    end
    gaint = sum(gain);
    losst = sum(lossb);
    ochange = cell(length(win)+1,1);
    ochange{end} = gaint-losst;
    winc = mat2cell(win,ones(length(win),1),1);
    datc = mat2cell(dat,ones(length(win)+1,1),1);
    gainc = mat2cell([gain; gaint],ones(length(win)+1,1),1);
    lossc = mat2cell([lossb; losst],ones(length(win)+1,1),1);
    dat1 = [datc [winc; {[]}] gainc lossc ochange];
    set(t{i},'Data',dat1)
end
    function leave_callback(hObject,eventdata)
        set(Showpanel,'Visible','off')
        set(rou.Wheel.WheelPanel,'Visible','off')
        set(rou.Wheel.BackPanel,'Visible','off')
        out = rou.Casino.Checkmoney;
        if ~out
            drawnow
            rou.Casino.ChooseGame
        end
    end
    function play_callback(hObject,eventdata)
        set(Showpanel,'Visible','off')
        rou.CurrentPlayer = 1;
        out = rou.Casino.Checkmoney;
        rou1 = rou.Wheel.WheelPanel;
        rou2 = rou.Wheel.BackPanel;
        if ~out
            drawnow
            rou.PlayRoulette;
            set(rou1,'Visible','off')
            set(rou2,'Visible','off')
            drawnow
        end
    end
    function change_callback(hObject,eventdata)
        set(Showpanel,'Visible','off')
        set(rou.Wheel.WheelPanel,'Visible','off')
        set(rou.Wheel.BackPanel,'Visible','off')
        rou.CurrentPlayer = 1;
        out = rou.Casino.Checkmoney;
        if ~out
            drawnow
            rou.ChoosePlayers;
        end
    end
end