function askInsurance(game)
%This function asks the players (if they can afford it) if they want to
%purchase insurance if the dealer is showing an Ace.
set(game.UI.Title1,'Position',[0.3 0.8 0.4 0.1],...
    'String','Dealer is showing an Ace ...',...
    'Visible','on');
set(game.UI.Title2,'Position',[0.3 0.6 0.4 0.1],...
    'String','Will you purchase Insurance?',...
    'Visible','on');
x = 0.5125 - 0.115625*length(game.BettingPlayers);

for j = 1:length(game.BettingPlayers)
    if game.BettingPlayers{j}.Funds > game.BettingPlayers{j}.BetB * 3/2
        set(game.UI.NameTexts{j},'Visible','on',...
            'String',game.BettingPlayers{j}.Name,...
            'Position',[x+(j-1)*(0.18125+0.05) 0.43 0.18125 0.1]);
        set(game.UI.CheckBoxes{j},'Visible','on',...
            'Value', 0,...
            'Position',[x+(j-1)*(0.18125+0.05)+0.018125 0.45 0.025 0.1]);
    end
end
set(game.UI.NextButton,'Visible','on',...
    'Position',[0.4 0.2 0.2 0.1],...
    'CallBack',@(h,d) play_callback(h,d),...
    'String','Play');
%             set(game.UI.LeaveButton,'Visible','on',...
%                            'Position',[0.5 0.2 0.2 0.1],...
%                            'CallBack',@(h,d) leave_callback(h,d));

    function play_callback(h,d)
        for k = 1:length(game.BettingPlayers)
            if game.BettingPlayers{k}.Funds > game.BettingPlayers{k}.BetB * 3/2 && get(game.UI.CheckBoxes{k},'Value') == 1
                game.BettingPlayers{k}.Insured = true;
            else
                game.BettingPlayers{k}.Insured = false;
            end
        end
        set(game.UI.Title1,'Visible','off');
        set(game.UI.Title2,'Visible','off');
        set(game.UI.NextButton,'Visible','off');
        set(game.UI.LeaveButton,'Visible','off');
        for i = 1:4
            set(game.UI.NameTexts{i},'Visible','off');
            set(game.UI.CheckBoxes{i},'Visible','off');
        end
        if game.Dealer.Value == 21
            game.Stage = 'results';
            dispHand(game, 0, 1, 'reveal');
            dispResult(game, 0, 1, 'Dealer_BlackJack');
        else
            game.Stage = 'action';
        end
        play(game);
    end

%function leave_callback(h,d)
%ARE YOU SURE YOU WANT TO LEAVE DIALOG BOX
% take away bets
%clear stuff
%   game.Stage = 'close';
%  play(game);
%end
end
