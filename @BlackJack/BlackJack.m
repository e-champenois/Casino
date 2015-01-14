classdef BlackJack < handle
    % This class is used to play BlackJack. It determines who wants to
    % play, asks for bets, deals cards to the players who have a bet, ask
    % for player actions, make the dealer act, calculate and display the
    % results, and then go back to the betting stage.

    
    %          CARD JPEG FILES FROM:
    % http://freeware.esoterica.free.fr/html/freecards.html
    
    %           TEXT JPG MAKER:
    % http://www.text2image.com/
    
    
    
    properties
        Casino %Casino object
        Stage %empty = game uninitiated
        ActivePlayers %cell array of blackjack players
        BettingPlayers %cell array of blackjack players who have a current bet
        ActionOn %[nPlayer nHand] awaiting action call
        Dealer %hand class object
        Deck %deck object
        UsedDeck %cell array of used cards
        UI % object with all of the UI components
    end
    
    methods
        function game = BlackJack(casino) %This method initiates the BlackJack object. It takes in a Casino object as an input.
            game.Casino = casino;
            game.UsedDeck = Deck('Used');
            game.Stage = [];
            game.ActionOn = [1 1];
            game.BettingPlayers = {};
            game.UI = BlackJackUI(casino);
            play(game);
        end
        %
        %         function play(game) %play blackjack
        %             if isempty(game.Stage) %initate a game
        %                 game.Deck = Deck();
        %                 shuffleDeck(game.Deck);
        %                 initiateVisual(game);
        %             elseif strcmp(game.Stage, 'close') %back to casino
        %                 set(game.UI.VisualPanel,'Visible','off');
        %                 set(game.UI.InteractivePanel,'Visible','off');
        %                 game.Casino.ChooseGame;
        %             elseif strcmp(game.Stage, 'betting') %betting stage
        %                 game.BettingPlayers = {};
        %                 askBet(game);
        %             elseif strcmp(game.Stage, 'iniDeal') %initial hand dealing stage
        %                 for i = 1:length(game.BettingPlayers)
        %                     game.BettingPlayers{i}.Hand = {Hand()};
        %                     game.BettingPlayers{i}.Action = 'start';
        %                     game.BettingPlayers{i}.Insured = 0;
        %                     game.BettingPlayers{i}.Hand{1}.Doubled = 1;
        %                     dealCard(game, i); %deal one card to each player
        %                     dispHand(game, i, 1,'none');
        %                 end
        %                 game.ActionOn = [1 1];
        %                 game.Dealer = Hand();
        %                 dealCard(game, 0);
        %                 dispHand(game, 0, 1, 'none');
        %
        %                 for i = 1:length(game.BettingPlayers)
        %                     dealCard(game, i); %deal a second card to each player
        %                     dispHand(game, i, 1, 'none');
        %                 end
        %
        %                 dealCard(game, 0);
        %                 dispHand(game, 0, 1, 'none');
        %
        %                 if isa(game.Dealer.Cards{1}, 'AceCard')
        %                     game.Stage = 'insurance';
        %                 else
        %                     game.Stage = 'action';
        %                 end
        %                 play(game);
        %             elseif strcmp(game.Stage, 'insurance') %if Dealer is showing an Ace, player insurance stage
        %                 askInsurance(game);
        %             elseif strcmp(game.Stage, 'action') %player hitting, splitting, surrendering, doubling, staying stage
        %
        %                 if strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'stay')
        %                     if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value > 21
        %                         if length(game.BettingPlayers)+length(game.BettingPlayers{1}.Hand) > 2
        %                             dispResult(game, game.ActionOn(1), game.ActionOn(2), 'Busted!');
        %                         end
        %                     elseif game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value == 21 && length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards) > 2
        %                         dispResult(game, game.ActionOn(1),game.ActionOn(2), '21');
        %                     end
        %                     if game.ActionOn(2) < length(game.BettingPlayers{game.ActionOn(1)}.Hand)
        %                         for m = 1:length(game.ActivePlayers)
        %                             if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
        %                                 nPchange = m;
        %                                 break
        %                             end
        %                         end
        %
        %                         set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','none');
        %                         game.ActionOn(2) = game.ActionOn(2) + 1;
        %                         game.BettingPlayers{game.ActionOn(1)}.Action = 'start';
        %                         play(game);
        %                     else
        %                         if game.ActionOn(1) < length(game.BettingPlayers)
        %                             for m = 1:length(game.ActivePlayers)
        %                                 if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
        %                                     nPchange = m;
        %                                     break
        %                                 end
        %                             end
        %                             set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','none');
        %                             game.ActionOn(1) = game.ActionOn(1) + 1;
        %                             game.ActionOn(2) = 1;
        %
        %                             play(game);
        %                         else
        %                             for m = 1:length(game.ActivePlayers)
        %                                 if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
        %                                     nPchange = m;
        %                                     break
        %                                 end
        %                             end
        %                             set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','none');
        %                             game.Stage = 'dealer';
        %                             play(game);
        %                         end
        %                     end
        %                 elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'start')
        %                     for m = 1:length(game.ActivePlayers)
        %                         if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
        %                             nPchange = m;
        %                             break
        %                         end
        %                     end
        %                     set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','line');
        %                     if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value == 21
        %                         game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        %                         if length(game.BettingPlayers)+length(game.BettingPlayers{1}.Hand) > 2
        %                            dispResult(game,game.ActionOn(1),game.ActionOn(2),'BlackJack!');
        %                         end
        %                         play(game);
        %                     else
        %                         getAction(game);
        %
        %                     end
        %                 elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'hit')
        %                     dealCard(game, game.ActionOn(1), game.ActionOn(2));
        %                     dispHand(game, game.ActionOn(1), game.ActionOn(2), 'none');
        %                     if 20 < game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value
        %                         if bustedAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)})
        %                             reduceAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)});
        %                             if 21 > game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value
        %                                 getAction(game);
        %                             elseif game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value == 21
        %                                 dispResult(game,game.ActionOn(1),game.ActionOn(2),'21!');
        %                                 game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        %                                 play(game);
        %                             else
        %                                 game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        %                                 play(game);
        %                             end
        %                         else
        %                             game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        %                             play(game);
        %                         end
        %                     else
        %                         getAction(game);
        %                     end
        %                 elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'split') %only doable from 'start'
        %                     %create second hand
        %                     game.BettingPlayers{game.ActionOn(1)}.Hand{length(game.BettingPlayers{game.ActionOn(1)}.Hand)+1} = Hand();
        %                     %set Doubled = 1 for new hand
        %                     game.BettingPlayers{game.ActionOn(1)}.Hand{length(game.BettingPlayers{game.ActionOn(1)}.Hand)}.Doubled = 1;
        %                     %make first card of second hand, the second card of the first hand
        %                     addCard(game.BettingPlayers{game.ActionOn(1)}.Hand{length(game.BettingPlayers{game.ActionOn(1)}.Hand)}, game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{2});
        %                     %only keep the first card of the first hand (make sure
        %                     %this doesn't mess up everything due to handle class)
        %                     game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards = {game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{1}};
        %                     dispHand(game, game.ActionOn(1), 1, 'none');
        %                     dispHand(game, game.ActionOn(1), 2, 'none');
        %                     %deal card to first hand
        %                     dealCard(game, game.ActionOn(1), game.ActionOn(2));
        %                     dispHand(game, game.ActionOn(1), game.ActionOn(2), 'none');
        %                     %deal card to second hand
        %                     dealCard(game, game.ActionOn(1), length(game.BettingPlayers{game.ActionOn(1)}.Hand));
        %                     dispHand(game, game.ActionOn(1), length(game.BettingPlayers{game.ActionOn(1)}.Hand), 'none');
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'start';
        %                     play(game);
        %                 elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'surrender') %only doable from 'start'
        %                     for i = 1:2
        %                         game.UsedDeck.Cards{length(game.UsedDeck.Cards)+1} = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i};
        %                     end
        %                     game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)} = Hand();
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        %                     play(game);
        %                 elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'double')
        %                     dealCard(game, game.ActionOn(1), game.ActionOn(2));
        %                     dispHand(game, game.ActionOn(1), game.ActionOn(2), 'none');
        %                     game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Doubled = 2;
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        %                     if bustedAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)})
        %                         reduceAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)});
        %                     end
        %                     play(game);
        %                 end
        %             elseif strcmp(game.Stage, 'dealer')
        %                 dispHand(game, 0, 1, 'reveal');
        %                 if bustedAce(game.Dealer)
        %                     reduceAce(game.Dealer);
        %                 end
        %                 if game.Dealer.Value < 17
        %                     dealCard(game, 0);
        %                     dispHand(game, 0, 1, 'reveal');
        %                 else
        %                     game.Stage = 'results';
        %                 end
        %                 play(game);
        %             elseif strcmp(game.Stage, 'results')
        %                 set(game.UI.Title1,'Visible','off');
        %                 set(game.UI.Title2,'Visible','off');
        %                 set(game.UI.HandStringPanel,'Visible','off');
        %                 set(game.UI.ValueString,'Visible','off');
        %                 set(game.UI.Title3,'Visible','off');
        %                 set(game.UI.Title2, 'HorizontalAlignment','center');
        %
        %                 for k = 1:5
        %                     set(game.UI.ActionButtons{k},'Visible','off');
        %                 end
        %                 results = [];
        %                 for i = 1:length(game.BettingPlayers)
        %                     results(i) = 0;
        %                 end
        %                 if isa(game.Dealer.Cards{1}, 'AceCard')
        %                     insurance_result = zeros(1,length(game.BettingPlayers));
        %                     if isBlackJack(game.Dealer)
        %                         for i = 1:length(game.BettingPlayers)
        %                             if game.BettingPlayers{i}.Insured
        %                                 game.BettingPlayers{i}.result(1);
        %                                 results(i) = results(i) + 1 * game.BettingPlayers{i}.BetB;
        %                                 insurance_result(i) = 1;
        %                             end
        %                         end
        %                     else
        %                         for i = 1:length(game.BettingPlayers)
        %                             if game.BettingPlayers{i}.BetB > 0
        %                                 if game.BettingPlayers{i}.Insured
        %                                     if round(game.BettingPlayers{i}.BetB*100/2) == game.BettingPlayers{i}.BetB*100/2
        %                                         game.BettingPlayers{i}.result(-1/2);
        %                                         results(i) = results(i) - 1/2 * game.BettingPlayers{i}.BetB;
        %                                     else
        %                                         game.BettingPlayers{i}.result(-1/2);
        %                                         results(i) = results(i) - roof(game.BettingPlayers{i}.BetB * 1/2 * 100) / 100;
        %                                     end
        %                                     insurance_result(i) = -1;
        %                                 end
        %                             end
        %                         end
        %                     end
        %                     dispResults(game,'insurance', insurance_result);
        %                 end
        %                 x = 0.1;
        %                 result_data = {};
        %                 for i = 1:length(game.BettingPlayers)
        %                     for j = 1:length(game.BettingPlayers{i}.Hand)
        %                         if isempty(game.BettingPlayers{i}.Hand{j}.Cards)
        %                             game.BettingPlayers{i}.result(-1/2);
        %                             results(i) = results(i) - 1/2 * game.BettingPlayers{i}.BetB;
        %                             result_data{length(result_data)+1} = 'Surrender';
        %                         elseif isBlackJack(game.BettingPlayers{i}.Hand{j}) && ~isBlackJack(game.Dealer)
        %                             game.BettingPlayers{i}.result(3/2);
        %                             results(i) = results(i) + 3/2 * game.BettingPlayers{i}.BetB;
        %                             result_data{length(result_data)+1} = 'BlackJack';
        %                         elseif isBlackJack(game.Dealer) && ~isBlackJack(game.BettingPlayers{i}.Hand{j})
        %                             game.BettingPlayers{i}.result(-1*game.BettingPlayers{i}.Hand{j}.Doubled);
        %                             results(i) = results(i) - 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
        %                             result_data{length(result_data)+1} = 'Hand_Loses';
        %                         elseif game.BettingPlayers{i}.Hand{j}.Value > 21
        %                             game.BettingPlayers{i}.result(-1*game.BettingPlayers{i}.Hand{j}.Doubled);
        %                             results(i) = results(i) - 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
        %                             result_data{length(result_data)+1} = 'Busted';
        %                         elseif game.Dealer.Value > 21
        %                             game.BettingPlayers{i}.result(1*game.BettingPlayers{i}.Hand{j}.Doubled);
        %                             results(i) = results(i) + 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
        %                             result_data{length(result_data)+1} = 'Hand_Wins';
        %                         elseif game.Dealer.Value > game.BettingPlayers{i}.Hand{j}.Value
        %                             game.BettingPlayers{i}.result(-1*game.BettingPlayers{i}.Hand{j}.Doubled);
        %                             results(i) = results(i) - 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
        %                             result_data{length(result_data)+1} = 'Hand_Loses';
        %                         elseif game.Dealer.Value == game.BettingPlayers{i}.Hand{j}.Value
        %                             result_data{length(result_data)+1} = 'Push';
        %                         elseif game.Dealer.Value < game.BettingPlayers{i}.Hand{j}.Value
        %                             game.BettingPlayers{i}.result(1*game.BettingPlayers{i}.Hand{j}.Doubled);
        %                             results(i) = results(i) + 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
        %                             result_data{length(result_data)+1} = 'Hand_Wins';
        %                         end
        %                         raiseHand(game.BettingPlayers{i}.Hand{j});
        %                         for k = 1:length(game.BettingPlayers{i}.Hand{j}.Cards)
        %                             addCard(game.UsedDeck, game.BettingPlayers{i}.Hand{j}.Cards{k});
        %                         end
        %
        %                         set(game.UI.NameTexts{i},'Visible','on',...
        %                                                  'Position',[x 0.6 0.18 0.1],...
        %                                                  'String',game.BettingPlayers{i}.Name);
        %                         set(game.UI.FundTexts{i},'Visible','on',...
        %                                                 'Position',[x 0.5 0.18 0.1],...
        %                                                 'String',['$' num2str(game.BettingPlayers{i}.Funds)]);
        %                         if results(i) < 0
        %                             signstr = 'Lose ';
        %                         elseif results(i) > 0;
        %                             signstr = 'Win ';
        %                         else
        %                             signstr = 'Push ';
        %                         end
        %                         set(game.UI.ResultTexts{i},'Visible','on',...
        %                                                    'Position',[x 0.4 0.18 0.1],...
        %                                                    'String',[signstr '$' num2str(abs(round(results(i))))]);
        %                         game.BettingPlayers{i}.AddResult(results(i), 'B');
        %
        %
        %                     end
        %                     x = x + 0.18;
        %
        %                 end
        %
        %                 dispResults(game,'hands', result_data);
        %
        %                 for i = 1:length(game.Dealer.Cards)
        %                     addCard(game.UsedDeck, game.Dealer.Cards{i});
        %                 end
        %
        %                 shuffleDeck(game.UsedDeck);
        %                 for i = 1:length(game.UsedDeck.Cards)
        %                     addCard(game.Deck, game.UsedDeck.Cards{i});
        %                 end
        %                 game.UsedDeck = Deck('Used');
        %                 game.Stage = 'betting';
        %                 set(game.UI.NextButton,'Visible','on',...
        %                                'String','Next Hand',...
        %                                'Position', [0.2 0.2 0.3 0.1],...
        %                                'CallBack',@(h,d) nexthand_callback(h,d));
        %                 set(game.UI.LeaveButton,'Visible','on',...
        %                                'Position',[0.5 0.2 0.3 0.1],...
        %                                'CallBack',@(h,d) leave_callback(h,d));
        %
        %
        %
        %             end
        %             function nexthand_callback(h,d)
        %                 for i = 1:4
        %                     set(game.UI.NameTexts{i},'Visible','off');
        %                     set(game.UI.FundTexts{i},'Visible','off');
        %                     set(game.UI.ResultTexts{i},'Visible','off');
        %                 end
        %                 set(game.UI.NextButton,'Visible','off');
        %                 set(game.UI.LeaveButton,'Visible','off');
        %                 for i = 1:length(game.UI.HandDispPanels)
        %                     set(game.UI.HandDispPanels{i},'Visible','off');
        %                 end
        %                 out = game.Casino.Checkmoney;
        %                 if ~out
        %                    game.Stage = 'betting';
        %                    game.ActionOn = [1 1];
        %                    play(game);
        %                 end
        %             end
        %
        %             function leave_callback(h,d)
        %                 out = game.Casino.Checkmoney;
        %                 if ~out
        %                    game.Stage = 'close';
        %                    play(game);
        %                 end
        %             end
        %         end
        %
        %
        %
        %         function initiateVisual(game)
        %             figure(game.Casino.Figure);
        %
        %             set(game.UI.Title1, 'String','Who will play BlackJack?',...
        %                                 'Position',[.3 .8 .4 .1],...
        %                                 'Visible','on');  %title1
        %
        %             y = .7;
        %
        %             for i = 1:length(game.Casino.ActivePlayers)
        %                 set(game.UI.NameTexts{i},'String',game.Casino.ActivePlayers{i}.Name,...
        %                                          'Position',[0.2 y 0.25 0.1],...
        %                                          'Visible','on'); %nametext
        %                 set(game.UI.FundTexts{i},'String',['$' num2str(game.Casino.ActivePlayers{i}.Funds)],...
        %                                          'Position',[0.45 y 0.25 0.1],...
        %                                          'Visible','on'); %fundtext
        %                 set(game.UI.CheckBoxes{i},'Position',[0.7 y 0.1 0.1],...
        %                                           'Visible','on');
        %                 y = y - 0.1;
        %             end
        %
        %             set(game.UI.NextButton,'String','Start',...
        %                            'Position',[0.15 0.1 0.25 0.1],...
        %                            'Visible','on',...
        %                            'CallBack', @(h,d) startbutton_callback);
        %             set(game.UI.LeaveButton,'Position',[0.7 0.1 0.25 0.1],...
        %                            'CallBack',@(h,d) leavebutton_callback,...
        %                            'Visible','on');
        %
        %             set(game.UI.DeckPanel, 'Visible','on');
        %             axes(game.UI.DeckAxes);
        %             imshow('CardPNG/Back.png');
        %             set(game.UI.DeckAxes,'Position',[0 0 1 1]);
        %             set(game.UI.DealerButton,'Visible','on');
        %             axes(game.UI.DealerButton);
        %             circlehandle = pie(1);
        %             delete(circlehandle(2));
        %             circlehandle = circlehandle(1);
        %             set(circlehandle, 'FaceColor','k');
        %             set(game.UI.DealerD,'Visible','on');
        %
        %             function startbutton_callback(h,d)
        %                 for j = 1:length(game.Casino.ActivePlayers)
        %                     if get(game.UI.CheckBoxes{j},'Value') == 1
        %                         game.ActivePlayers{length(game.ActivePlayers)+1} = game.Casino.ActivePlayers{j};
        %                         game.ActivePlayers{length(game.ActivePlayers)}.BetB = 0;
        %                     end
        %                 end
        %                 if ~isempty(game.ActivePlayers)
        %                     game.Stage = 'betting';
        %                     set(game.UI.NextButton,'Visible','off');
        %                     set(game.UI.LeaveButton,'Visible','off');
        %                     for j = 1:length(game.Casino.ActivePlayers)
        %                         set(game.UI.NameTexts{j},'Visible','off');
        %                         set(game.UI.FundTexts{j},'Visible','off');
        %                         set(game.UI.CheckBoxes{j},'Visible','off');
        %                     end
        %                     play(game);
        %                 else
        %                     errordlg('Need at least one player.');
        %                 end
        %             end
        %             function leavebutton_callback(h,d)
        %                 game.Stage = 'close';
        %                 set(game.UI.NextButton,'Visible','off');
        %                     set(game.UI.LeaveButton,'Visible','off');
        %                     for j = 1:length(game.Casino.ActivePlayers)
        %                         set(game.UI.NameTexts{j},'Visible','off');
        %                         set(game.UI.FundTexts{j},'Visible','off');
        %                         set(game.UI.CheckBoxes{j},'Visible','off');
        %                     end
        %                 play(game);
        %             end
        %
        %         end
        %
        %
        %         function getAction(game)
        %
        %             set(game.UI.Title1,'Visible','on',...
        %                             'Position',[0.3 0.9 0.4 0.1],...
        %                             'String',[game.BettingPlayers{game.ActionOn(1)}.Name '''s turn to act ...']);
        %             set(game.UI.Title2,'Visible','on',...
        %                             'Position',[0.1 0.6 0.4 0.1],...
        %                             'String','Your hand:',...
        %                             'HorizontalAlignment','right');
        %             set(game.UI.HandStringPanel,'Visible','on');
        %             handstr = {};
        %             for i = 1:length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards)
        %                 ID = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.ID;
        %                 if strcmp('S',ID(end))    %can have better symbols?
        %                     suit = 'S';
        %                     col = 'k';
        %                 elseif strcmp('H',ID(end))
        %                     suit = 'H';
        %                     col = 'r';
        %                 elseif strcmp('C',ID(end))
        %                     suit = 'C';
        %                     col = 'k';
        %                 elseif strcmp('D',ID(end))
        %                     suit = 'D';
        %                     col = 'r';
        %                 end
        %                 handstr{length(handstr)+1} = uicontrol('Parent',game.UI.HandStringPanel,...
        %                                                        'Units','normalized',...
        %                                                        'Style','text',...
        %                                                        'String',[ID(1:end-1) suit],...
        %                                                        'FontSize',15,...
        %                                                        'FontWeight','bold',...
        %                                                        'ForegroundColor',col,...
        %                                                        'Position',[(i-1)*.1 0 0.1 1]);
        %             end
        %             set(game.UI.Title3,'Visible','on',...
        %                                'Position',[0.1 0.5 0.4 0.1],...
        %                                'String','Your hand value:',...
        %                                'HorizontalAlignment','right');
        %             has11Ace = 0;
        %             for i = 1:length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards)
        %                 if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.Value == 11
        %                     has11Ace = 1;
        %                     break
        %                 end
        %             end
        %             val = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value;
        %
        %             if has11Ace
        %                 val = [num2str(val) ' or ' num2str(val - 10)];
        %             else
        %                 val = num2str(val);
        %             end
        %             set(game.UI.ValueString,'Visible','on',...
        %                                     'String', ['    ' val],...
        %                                     'HorizontalAlignment','left');
        %             child = get(game.UI.HandShowPanel,'Children');
        %             for i = 1:length(child)
        %                 delete(child(i));
        %             end
        %
        %             l = length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards);
        %             pos = get(game.UI.HandShowPanel,'Position');
        %             set(game.UI.HandShowPanel,'Position',[pos(1:2) 0.1*l pos(4)]);  % Change the 0.1 value here?
        %             for i = 1:l
        %                 subplot(1,l,i,'Parent',game.UI.HandShowPanel)
        %                 ID = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.ID;
        %                 imshow(['CardPNG/' ID '.png']);
        %             end
        %             %  ?
        %
        %
        %
        %
        %
        %
        %             actions = [1, 1, 1, 1, 1];
        %             if length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards) == 2
        %                 if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{1}.Value == game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{2}.Value
        %                     if length(game.BettingPlayers{game.ActionOn(1)}.Hand) > 1
        %                         actions(2) = 0;
        %                     end
        %                 else
        %                     actions(2) = 0;
        %                 end
        %             else
        %                 actions(2:4) = 0;
        %             end
        %             %check if sufficient funds to split or double
        %             f = game.BettingPlayers{game.ActionOn(1)}.Funds;
        %             b = game.BettingPlayers{game.ActionOn(1)}.BetB;
        %             if game.BettingPlayers{game.ActionOn(1)}.Insured
        %                 ins = 1/2;
        %             else
        %                 ins = 0;
        %             end
        %             if length(game.BettingPlayers{game.ActionOn(1)}.Hand) > 1
        %                 if f < b*(3+ins);
        %                     actions(3) = 0;
        %                 end
        %             else
        %                 if f < b*(2+ins);
        %                     actions(2:3) = 0;
        %                 end
        %             end
        %
        %             x = (21-4*dot(actions,[1 1 1 1 1]))/40;
        %             n = 1;
        %             for i = 1:5
        %                 if actions(i)
        %                     set(game.UI.ActionButtons{i},'Visible','on',...
        %                                        'Position',[x+(n-1)*0.2 0.3 0.15 0.1],...
        %                                        'CallBack',@(h,d) actioncallback(h,d));
        %                     n = n+1;
        %                 else
        %                     set(game.UI.ActionButtons{i},'Visible','off');
        %                 end
        %             end
        %             function actioncallback(h,d)
        %                 if strcmp(get(h,'String'),'Hit')
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'hit';
        %                 elseif strcmp(get(h,'String'),'Stay')
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        %                 elseif strcmp(get(h,'String'),'Surrender')
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'surrender';
        %                 elseif strcmp(get(h,'String'),'Split')
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'split';
        %                 elseif strcmp(get(h,'String'),'Double')
        %                     game.BettingPlayers{game.ActionOn(1)}.Action = 'double';
        %                 end
        %                 for i = 1:length(handstr)
        %                     delete(handstr{i});
        %                 end
        %
        %                 play(game);
        %             end
        %
        %
        %         end
        %
        %         function askBet(game) %gets the bets for a hand from the ActivePlayers
        %             set(game.UI.Title1,'Position',[0.3 0.9 0.4 0.1],...
        %                             'Visible','on',...
        %                             'String','Place your bets');
        %
        %             if length(game.ActivePlayers) == 4
        %                 x = 0.05;
        %             else
        %                 x = -(19*length(game.ActivePlayers)-69)/160; %1 = 2*x + 0.1375*n + 0.1*n + 0.1375
        %             end
        %
        %             set(game.UI.Title2, 'Position',[0.4 0.5 0.2 0.1],...
        %                              'Visible','on',...
        %                              'String','Bets:');
        %
        %             for i = 1:length(game.ActivePlayers)
        %                 set(game.UI.NameTexts{i},'Position',[x+(i-1)*(0.1875+0.05) 0.7 0.1875 0.1],...
        %                                   'String', game.ActivePlayers{i}.Name,...
        %                                   'Visible','on');
        %                 set(game.UI.FundTexts{i},'Position',[x+(i-1)*(0.1875+0.05) 0.6 0.1875 0.1],...
        %                                   'String', ['$' num2str(game.ActivePlayers{i}.Funds)],...
        %                                   'Visible','on');
        %                 set(game.UI.RemoveButtons{i},'Position',[x+(i-1)*(0.1875+0.05)+0.1875 0.7 0.025 0.1],...
        %                                    'CallBack',@(h,d) removePlayer(h,d),...
        %                                    'Visible','on');
        %                 set(game.UI.BetBoxes{i},'Position',[x+(i-1)*(0.1875+0.05) 0.4 0.1875 0.1],...
        %                                   'Visible','on',...
        %                                   'Style','edit',...
        %                                   'String',num2str(game.ActivePlayers{i}.BetB));
        %             end
        %             if length(game.ActivePlayers) < 4
        %                 namelist = {};
        %                 playingnamelist = {};
        %                 for i = 1:length(game.ActivePlayers)
        %                     playingnamelist{i} = game.ActivePlayers{i}.Name;
        %                 end
        %                 for i = 1:length(game.Casino.ActivePlayers)
        %                     if ~any(strcmpi(game.Casino.ActivePlayers{i}.Name, playingnamelist))
        %                         namelist{length(namelist)+1} = game.Casino.ActivePlayers{i}.Name;
        %                     end
        %                 end
        %                 if length(game.ActivePlayers) < length(game.Casino.ActivePlayers)
        %                     set(game.UI.AddMenu,'Position',[x+length(game.ActivePlayers)*(0.1875+0.05) 0.7 0.1875 0.1],...
        %                                     'String',namelist,...
        %                                     'Visible','on');
        %
        %                     set(game.UI.AddButton,'Position',[x+length(game.ActivePlayers)*(0.1875+0.05) 0.6 0.1875 0.1],...
        %                                     'String','Add Player',...
        %                                     'CallBack',@(h,d) addPlayer(h,d),...
        %                                     'Visible','on');
        %                 end
        %             end
        %             set(game.UI.NextButton,'Position',[0.3 0.2 0.2 0.1],...
        %                            'String','Deal',...
        %                            'Visible','on',...
        %                            'CallBack',@(h,d) deal_callback);
        %             set(game.UI.LeaveButton,'Position',[0.5 0.2 0.2 0.1],...
        %                            'Visible','on',...
        %                            'CallBack',@(h,d) leave_callback);
        %             function deal_callback(h,d)
        %                 bets = [];
        %                 err = 0;
        %                 for i = 1:length(game.ActivePlayers)
        %                     bet = get(game.UI.BetBoxes{i},'String');
        %                     bet = str2double(bet);
        %                     bets(i) = bet;
        %                     if isa(bet, 'double') && isreal(bet) && floor(bet*100) == bet*100
        %                         if bet >= 0
        %                             if bet <= game.ActivePlayers{i}.Funds
        %                                 game.ActivePlayers{i}.BetB = bet;
        %                             else
        %                                 errordlg([game.ActivePlayers{i}.Name ' has an invalid bet.']);
        %                                 err = 1;
        %                                 break
        %                             end
        %                         else
        %                             errordlg([game.ActivePlayers{i}.Name ' has an invalid bet.']);
        %                             err = 1;
        %                             break
        %                         end
        %                     else
        %                         errordlg([game.ActivePlayers{i}.Name ' has an invalid bet.']);
        %                         err = 1;
        %                         break
        %                     end
        %                 end
        %                 if err == 0
        %                     if any(bets > 0)
        %                         for i = 1:length(game.ActivePlayers)
        %                             if game.ActivePlayers{i}.BetB > 0
        %                                 game.BettingPlayers{length(game.BettingPlayers)+1} = game.ActivePlayers{i};
        %                             end
        %                         end
        %                         game.Stage = 'iniDeal';
        %                         set(game.UI.Title1,'Visible','off');
        %                         set(game.UI.Title2,'Visible','off');
        %                         set(game.UI.AddMenu,'Visible','off');
        %                         set(game.UI.AddButton,'Visible','off');
        %                         set(game.UI.NextButton,'Visible','off');
        %                         set(game.UI.LeaveButton,'Visible','off');
        %                         for k = 1:length(game.ActivePlayers)
        %                             set(game.UI.NameTexts{k},'Visible','off');
        %                             set(game.UI.FundTexts{k},'Visible','off');
        %                             set(game.UI.BetBoxes{k},'Visible','off');
        %                             set(game.UI.RemoveButtons{k},'Visible','off');
        %                         end
        %                         play(game);
        %                     else
        %                         errordlg('Place your bets first.');
        %                     end
        %                 end
        %             end
        %
        %             function leave_callback(h,d)
        %                 game.Stage = 'close';
        %                 set(game.UI.Title1,'Visible','off');
        %                 set(game.UI.Title2,'Visible','off');
        %                 set(game.UI.AddMenu,'Visible','off');
        %                 set(game.UI.AddButton,'Visible','off');
        %                 set(game.UI.NextButton,'Visible','off');
        %                 set(game.UI.LeaveButton,'Visible','off');
        %                 for k = 1:length(game.ActivePlayers)
        %                     set(game.UI.NameTexts{k},'Visible','off');
        %                     set(game.UI.FundTexts{k},'Visible','off')
        %                     set(game.UI.BetBoxes{k},'Visible','off');
        %                     set(game.UI.RemoveButtons{k},'Visible','off');
        %                 end
        %                 play(game);
        %             end
        %
        %             function addPlayer(h,d)
        %                 namelist = get(game.UI.AddMenu,'String');
        %                 val = get(game.UI.AddMenu,'Value');
        %                 addname = namelist{val};
        %                 for k = 1:length(game.Casino.ActivePlayers)
        %                     if strcmp(addname, game.Casino.ActivePlayers{k}.Name)
        %                         game.ActivePlayers{length(game.ActivePlayers)+1} = game.Casino.ActivePlayers{k};
        %                         game.ActivePlayers{length(game.ActivePlayers)}.BetB = 0;
        %                         break
        %                     end
        %                 end
        %                 game.Stage = 'betting';
        %                 set(game.UI.Title1,'Visible','off');
        %                 set(game.UI.Title2,'Visible','off');
        %                 set(game.UI.AddMenu,'Visible','off');
        %                 set(game.UI.AddButton,'Visible','off');
        %                 set(game.UI.NextButton,'Visible','off');
        %                 set(game.UI.LeaveButton,'Visible','off');
        %                 for k = 1:length(game.ActivePlayers)
        %                     set(game.UI.NameTexts{k},'Visible','off');
        %                     set(game.UI.FundTexts{k},'Visible','off')
        %                     set(game.UI.BetBoxes{k},'Visible','off');
        %                     set(game.UI.RemoveButtons{k},'Visible','off');
        %                 end
        %                 set(game.UI.AddMenu,'Value',1);
        %                 play(game);
        %             end
        %             function removePlayer(h,d)
        %                 for k = 1:length(game.ActivePlayers)
        %                     if h == game.UI.RemoveButtons{k}
        %                         n = k;
        %                         break
        %                     end
        %                 end
        %
        %                 game.Stage = 'betting';
        %                 set(game.UI.Title1,'Visible','off');
        %                 set(game.UI.Title2,'Visible','off');
        %                 set(game.UI.AddMenu,'Visible','off');
        %                 set(game.UI.AddButton,'Visible','off');
        %                 set(game.UI.NextButton,'Visible','off');
        %                 set(game.UI.LeaveButton,'Visible','off');
        %                 for k = 1:length(game.ActivePlayers)
        %                     set(game.UI.NameTexts{k},'Visible','off');
        %                     set(game.UI.FundTexts{k},'Visible','off')
        %                     set(game.UI.BetBoxes{k},'Visible','off');
        %                     set(game.UI.RemoveButtons{k},'Visible','off');
        %                 end
        %                 game.ActivePlayers(n) = [];
        %                 play(game);
        %             end
        %         end
        %
        %         function askInsurance(game)
        %             set(game.UI.Title1,'Position',[0.3 0.8 0.4 0.1],...
        %                             'String','Dealer is showing an Ace ...',...
        %                             'Visible','on');
        %             set(game.UI.Title2,'Position',[0.3 0.6 0.4 0.1],...
        %                             'String','Will you purchase Insurance?',...
        %                             'Visible','on');
        %             x = 0.5125 - 0.115625*length(game.BettingPlayers);
        %
        %             for j = 1:length(game.BettingPlayers)
        %                 if game.BettingPlayers{j}.Funds > game.BettingPlayers{j}.BetB * 3/2
        %                     set(game.UI.NameTexts{j},'Visible','on',...
        %                                              'String',game.BettingPlayers{j}.Name,...
        %                                              'Position',[x+(j-1)*(0.18125+0.05) 0.5 0.18125 0.1]);
        %                     set(game.UI.CheckBoxes{j},'Visible','on',...
        %                                               'Value', 0,...
        %                                               'Position',[x+(j-1)*(0.18125+0.05)+0.018125 0.5 0.025 0.1]);
        %                 end
        %             end
        %             set(game.UI.NextButton,'Visible','on',...
        %                            'Position',[0.3 0.2 0.2 0.1],...
        %                            'CallBack',@(h,d) play_callback(h,d),...
        %                            'String','Play');
        % %             set(game.UI.LeaveButton,'Visible','on',...
        % %                            'Position',[0.5 0.2 0.2 0.1],...
        % %                            'CallBack',@(h,d) leave_callback(h,d));
        %
        %             function play_callback(h,d)
        %                 for k = 1:length(game.BettingPlayers)
        %                     if game.BettingPlayers{k}.Funds > game.BettingPlayers{k}.BetB * 3/2 && get(game.UI.CheckBoxes{k},'Value') == 1
        %                         game.BettingPlayers{k}.Insured = true;
        %                     else
        %                         game.BettingPlayers{k}.Insured = false;
        %                     end
        %                 end
        %                 set(game.UI.Title1,'Visible','off');
        %                 set(game.UI.Title2,'Visible','off');
        %                 set(game.UI.NextButton,'Visible','off');
        %                 set(game.UI.LeaveButton,'Visible','off');
        %                 for i = 1:4
        %                     set(game.UI.NameTexts{i},'Visible','off');
        %                     set(game.UI.CheckBoxes{i},'Visible','off');
        %                 end
        %                 if game.Dealer.Value == 21
        %                     game.Stage = 'results';
        %                     dispHand(game, 0, 1, 'reveal');
        %                     dispResult(game, 0, 1, 'Dealer_BlackJack');
        %                 else
        %                     game.Stage = 'action';
        %                 end
        %                 play(game);
        %             end
        %
        %             %function leave_callback(h,d)
        %                 %ARE YOU SURE YOU WANT TO LEAVE DIALOG BOX
        %                 % take away bets
        %                 %clear stuff
        %              %   game.Stage = 'close';
        %               %  play(game);
        %             %end
        %         end
        %
        %
        %         function dealCard(game, nPlayer, nHand)
        %             if nargin == 1
        %                 nPlayer = 0;
        %                 nHand = 1;
        %             elseif nargin == 2
        %                 nHand = 1;
        %             end
        %             if nPlayer > 0
        %                 game.BettingPlayers{nPlayer}.Hand{nHand}.addCard(game.Deck.Cards{1});
        %                 deltCard(game.Deck);
        %             else
        %                 game.Dealer.addCard(game.Deck.Cards{1});
        %                 deltCard(game.Deck);
        %             end
        %
        %         end
        %         function dispResult(game, nP, nH, result)
        %             for i = 1:5
        %                 set(game.UI.ActionButtons{i},'Visible','off');
        %             end
        %             if nP == 0
        %                 n = 1;
        %             else
        %                 for i = 1:length(game.ActivePlayers)
        %                     if strcmp(game.ActivePlayers{i}.Name, game.BettingPlayers{nP}.Name)
        %                         n = 2*i+nH-1;
        %                         break
        %                     end
        %                 end
        %             end
        %             a = axes('Parent',game.UI.HandDispPanels{n},...
        %                      'Units','normalized',...
        %                      'Visible','on');
        %             image_handle = imshow(['BlackJackResults/' result '.jpg']);
        %             set(a,'Position',[0 0 1 1]);
        %             axis normal
        %             transparency = 1;
        %             pause(1.5)
        %             for i = 1:4
        %                 transparency = transparency - 0.05;
        %                 set(image_handle,'AlphaData',transparency);
        %                 pause(0.3);
        %             end
        %             for k = 1:16
        %                 transparency = transparency - 0.05;
        %                 set(image_handle,'AlphaData',transparency);
        %                 pause(0.06);
        %             end
        %             delete(a);
        %         end
        %         function dispResults(game, style, data)
        %             pause(1);
        %             for i = 1:9
        %                 a{i} = axes('Parent',game.UI.HandDispPanels{i},...
        %                             'Units','normalized',...
        %                             'Visible','off');
        %             end
        %             image_handles = {};
        %             if game.Dealer.Value > 21
        %                 set(a{1},'Visible','on');
        %                 axes(a{1});
        %                 image_handles{length(image_handles)+1} = imshow('BlackJackResults/Dealer_Busted.jpg'); %Dealer_Busted
        %                 set(a{1},'Position',[0 0 1 1]);
        %                 axis normal
        %             elseif isBlackJack(game.Dealer)
        %                 set(a{1},'Visible','on');
        %                 axes(a{1});
        %                 image_handles{length(image_handles)+1} = imshow('BlackJackResults/Dealer_BlackJack.jpg'); %Dealer_BlackJack
        %                 set(a{1},'Position',[0 0 1 1]);
        %                 axis normal
        %             end
        %             for i = 1:length(game.BettingPlayers)
        %                     if strcmp(style,'hands')
        %                         for j = 1:length(game.BettingPlayers{i}.Hand)
        %                             for m = 1:length(game.ActivePlayers)
        %                                 if strcmp(game.BettingPlayers{i}.Name, game.ActivePlayers{m}.Name)
        %                                     nPchange = m;
        %                                     break
        %                                 end
        %                             end
        %                             set(a{2*nPchange+j-1},'Visible','on');
        %                             axes(a{2*nPchange+j-1});
        %                             image_handles{length(image_handles)+1} = imshow(['BlackJackResults/' data{1} '.jpg']);   %data{1}
        %                             set(a{2*nPchange+j-1},'Position',[0 0 1 1]);
        %                             axis normal
        %                             data(1) = [];
        %                         end
        %                     elseif strcmp(style,'insurance')
        %
        %                         if data(i) == 1
        %                             for m = 1:length(game.ActivePlayers)
        %                                 if strcmp(game.BettingPlayers{i}.Name, game.ActivePlayers{m}.Name)
        %                                     nPchange = m;
        %                                     break
        %                                 end
        %                             end
        %                             set(a{2*nPchange},'Visible','on');
        %                             axes(a{2*nPchange});
        %                             image_handles{length(image_handles)+1} = imshow('BlackJackResults/Insurance_Win.jpg');  %Insurance_Win
        %                             set(a{2*nPchange},'Position',[0 0 1 1]);
        %                             axis normal
        %                         elseif data(i) == -1
        %                             for m = 1:length(game.ActivePlayers)
        %                                 if strcmp(game.BettingPlayers{i}.Name, game.ActivePlayers{m}.Name)
        %                                     nPchange = m;
        %                                     break
        %                                 end
        %                             end
        %                             set(a{2*nPchange},'Visible','on');
        %                             axes(a{2*nPchange});
        %                             image_handles{length(image_handles)+1} = imshow('BlackJackResults/Insurance_Lost.jpg');  %Insurance_Loss
        %                             set(a{2*nPchange},'Position',[0 0 1 1]);
        %                             axis normal
        %                         end
        %                     end
        %
        %             end
        %             pause(2);
        %             transparency = 1;
        %             for k = 1:4
        %                 transparency = transparency - 0.05;
        %                 for l = 1:length(image_handles)
        %                     set(image_handles{l},'AlphaData',transparency);
        %                 end
        %                 pause(0.3);
        %             end
        %             for k = 1:16
        %                 transparency = transparency - 0.05;
        %                 for l = 1:length(image_handles)
        %                     set(image_handles{l},'AlphaData',transparency);
        %                 end
        %                 pause(0.06);
        %             end
        %             for k = 1:9
        %                 delete(a{k});
        %             end
        %             %ADD DELETE FUNCTIONS?
        %         end
        %
        %
        %         function dispHand(game, nP, nH, style)
        %             %style is 'none' or 'reveal'
        %             if nP > 0
        %                 for i = 1:length(game.ActivePlayers)
        %                     if strcmp(game.ActivePlayers{i}.Name, game.BettingPlayers{nP}.Name)
        %                         nPo = i;
        %                         break
        %                     end
        %                 end
        %             end
        %
        %             if nargin == 3
        %                 style = 'none';
        %             end
        %
        %             if nP > 0
        %                 l = length(game.BettingPlayers{nP}.Hand{nH}.Cards);
        %                 set(game.UI.HandDispPanels{2*nPo+nH-1},'Visible','on')
        %                 child = get(game.UI.HandDispPanels{2*nPo+nH-1},'Children');
        %             elseif nP == 0
        %                 l = length(game.Dealer.Cards);
        %                 set(game.UI.HandDispPanels{1},'Visible','on');
        %                 child = get(game.UI.HandDispPanels{1},'Children');
        %             end
        %             if l > 10
        %                 l = 10;
        %             end
        %             for i = 1:length(child)
        %                 delete(child(i));
        %             end
        %
        %             if l < 6
        %                 x = l;
        %                 y = 1;
        %                 width = 1/l - 0.02;
        %                 height = 1;
        %             else
        %                 x = 5;
        %                 y = 2;
        %                 width = 1/5 - 0.02;
        %                 height = 0.5;
        %             end
        %
        %
        %             for i = 1:l
        %                 if nP > 0
        %                     ID = game.BettingPlayers{nP}.Hand{nH}.Cards{i}.ID;
        %                     plothandle = subplot(y,x,i,'Parent',game.UI.HandDispPanels{2*nPo+nH-1});
        %                 elseif nP == 0
        %                     if strcmp(style,'none') && i == 2
        %                         ID = 'Back';
        %                     else
        %                         ID = game.Dealer.Cards{i}.ID;
        %                     end
        %                     plothandle = subplot(y,x,i,'Parent',game.UI.HandDispPanels{1});
        %                 end
        %                 imshow(['CardPNG/' ID '.png']);
        %                 if i > 5
        %                     ypos = 0;
        %                     xpos = (i-6)*1/5;
        %                 else
        %                     if l > 5
        %                         xpos = (i-1)*1/5;
        %                         ypos = 0.5;
        %                     else
        %                         xpos = (i-1)*1/l;
        %                         ypos = 0;
        %                     end
        %                 end
        %                 set(plothandle,'Position',[xpos ypos width height]);
        %             end
        %         end
    end
end