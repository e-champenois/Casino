function initiateVisual(game)
%This method initates the UI for BlackJack, and asks which people will play
%BlackJack.
figure(game.Casino.Figure);

set(game.UI.Title1, 'String','Who will play BlackJack?',...
    'Position',[.3 .8 .4 .1],...
    'Visible','on');  %title1

y = .7;

for i = 1:length(game.Casino.ActivePlayers)
    fund = game.Casino.ActivePlayers{i}.Funds;
    fundstr = ['$' num2str(fund)];
    if round(fund) == fund
        fundstr = [fundstr '.00'];
    elseif round(fund*10) == fund*10
        fundstr = [fundstr '0'];
    end
    set(game.UI.NameTexts{i},'String',game.Casino.ActivePlayers{i}.Name,...
        'Position',[0.2 y 0.25 0.1],...
        'Visible','on'); %nametext
    set(game.UI.FundTexts{i},'String',fundstr,...
        'Position',[0.45 y 0.25 0.1],...
        'Visible','on'); %fundtext
    set(game.UI.CheckBoxes{i},'Position',[0.7 y 0.1 0.1],...
        'Visible','on');
    y = y - 0.1;
end

set(game.UI.NextButton,'String','Start',...
    'Position',[0.1 0.1 0.25 0.1],...
    'Visible','on',...
    'CallBack', @(h,d) startbutton_callback);
set(game.UI.LeaveButton,'Position',[0.65 0.1 0.25 0.1],...
    'CallBack',@(h,d) leavebutton_callback,...
    'Visible','on');
set(game.UI.RulesButton,'Position', [0.35+0.025 0.1 0.25 0.1],...
    'Visible','on',...
    'CallBack',@(h,d) rulesbutton_callback);
set(game.UI.DeckPanel, 'Visible','on');
axes(game.UI.DeckAxes);
imshow('CardPNG/Back.png');
set(game.UI.DeckAxes,'Position',[0 0 1 1]);
set(game.UI.DealerButton,'Visible','on');
axes(game.UI.DealerButton);
circlehandle = pie(1);
delete(circlehandle(2));
circlehandle = circlehandle(1);
set(circlehandle, 'FaceColor','k');
set(game.UI.DealerD,'Visible','on');

    function startbutton_callback(h,d)
        for j = 1:length(game.Casino.ActivePlayers)
            if get(game.UI.CheckBoxes{j},'Value') == 1
                game.ActivePlayers{length(game.ActivePlayers)+1} = game.Casino.ActivePlayers{j};
                game.ActivePlayers{length(game.ActivePlayers)}.BetB = 0;
            end
        end
        if ~isempty(game.ActivePlayers)
            game.Stage = 'betting';
            set(game.UI.NextButton,'Visible','off');
            set(game.UI.LeaveButton,'Visible','off');
            set(game.UI.RulesButton,'Visible','off');
            for j = 1:length(game.Casino.ActivePlayers)
                set(game.UI.NameTexts{j},'Visible','off');
                set(game.UI.FundTexts{j},'Visible','off');
                set(game.UI.CheckBoxes{j},'Visible','off');
            end
            play(game);
        else
            errordlg('Need at least one player.');
        end
    end
    function rulesbutton_callback(h,d)
        set(game.UI.RulesFigure,'Visible','on');
    end
    function leavebutton_callback(h,d)
        game.Stage = 'close';
        set(game.UI.NextButton,'Visible','off');
        set(game.UI.LeaveButton,'Visible','off');
        set(game.UI.RulesButton,'Visible','off');
        for j = 1:length(game.Casino.ActivePlayers)
            set(game.UI.NameTexts{j},'Visible','off');
            set(game.UI.FundTexts{j},'Visible','off');
            set(game.UI.CheckBoxes{j},'Visible','off');
        end
        play(game);
    end

end