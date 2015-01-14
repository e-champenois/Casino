function play(game)
%This is the main method to play BlackJack. It uses a lot of recursion to get the whole game played with one call. It figures out the stage of the game, and acts accordingly.
if isempty(game.Stage) %Initiate game
    game.Deck = Deck(); %create and shuffle a deck
    shuffleDeck(game.Deck);
    shuffleDeck(game.Deck);
    initiateVisual(game);
elseif strcmp(game.Stage, 'close') %Close game
    set(game.UI.VisualPanel,'Visible','off');
    set(game.UI.InteractivePanel,'Visible','off');
    game.Casino.ChooseGame;
elseif strcmp(game.Stage, 'betting') %Betting Stage
    game.BettingPlayers = {};
    askBet(game);
elseif strcmp(game.Stage, 'iniDeal') %Initial Hand Dealing Stage
    for i = 1:length(game.BettingPlayers)
        game.BettingPlayers{i}.Hand = {Hand()};
        game.BettingPlayers{i}.Action = 'start';
        game.BettingPlayers{i}.Insured = 0;
        game.BettingPlayers{i}.Hand{1}.Doubled = 1;
        dealCard(game, i); %deal one card to each player
        dispHand(game, i, 1,'none');
    end
    game.ActionOn = [1 1];
    game.Dealer = Hand();
    dealCard(game, 0); %deal one card to the dealer
    dispHand(game, 0, 1, 'none');
    
    for i = 1:length(game.BettingPlayers)
        dealCard(game, i); %deal a second card to each player
        dispHand(game, i, 1, 'none');
    end
    
    dealCard(game, 0); %deal a second card to the dealer
    dispHand(game, 0, 1, 'none');
    
    if isa(game.Dealer.Cards{1}, 'AceCard') %checks if an Insurance Stage is needed
        game.Stage = 'insurance';
    else
        game.Stage = 'action';
    end
    play(game);
elseif strcmp(game.Stage, 'insurance') %Insurance Stage, if needed
    askInsurance(game);
elseif strcmp(game.Stage, 'action') %Player Action Stage
    child = get(game.UI.HandStringPanel,'Children');
    for i = 1:length(child)
        delete(child(i));
    end
    if strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'stay') %display hand and hand value on interactive panel
        set(game.UI.Title2,'Visible','on',...
            'Position',[0.1 0.6 0.4 0.1],...
            'String','Your hand:',...
            'HorizontalAlignment','right');
        set(game.UI.HandStringPanel,'Visible','on');
        handstr = {};
        for i = 1:length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards)
            ID = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.ID;
            if strcmp('S',ID(end))  
                suit = 'S';
                col = 'k';
            elseif strcmp('H',ID(end))
                suit = 'H';
                col = 'r';
            elseif strcmp('C',ID(end))
                suit = 'C';
                col = 'k';
            elseif strcmp('D',ID(end))
                suit = 'D';
                col = 'r';
            end
            handstr{length(handstr)+1} = uicontrol('Parent',game.UI.HandStringPanel,...
                'Units','normalized',...
                'Style','text',...
                'String',[ID(1:end-1) suit],...
                'FontSize',15,...
                'FontWeight','bold',...
                'ForegroundColor',col,...
                'Position',[(i-1)*.1 0 0.1 1]);
        end
        set(game.UI.Title3,'Visible','on',...
            'Position',[0.1 0.5 0.4 0.1],...
            'String','Your hand value:',...
            'HorizontalAlignment','right');
        has11Ace = 0;
        for i = 1:length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards)
            if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.Value == 11
                has11Ace = 1;
                break
            end
        end
        val = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value;
        
        if has11Ace
            if val ~= 21
                val = [num2str(val) ' or ' num2str(val - 10)];
            else
                val = num2str(val);
            end
        else
            val = num2str(val);
        end
        set(game.UI.ValueString,'Visible','on',...
            'String', ['    ' val],...
            'HorizontalAlignment','left');
        if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value > 21 %if player has busted
            if length(game.BettingPlayers)+length(game.BettingPlayers{1}.Hand) > 2
                dispResult(game, game.ActionOn(1), game.ActionOn(2), 'Busted!');
            end
        elseif game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value == 21 && length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards) > 2
            dispResult(game, game.ActionOn(1),game.ActionOn(2), '21'); %if player has a non-blackjack 21
        end
        if game.ActionOn(2) < length(game.BettingPlayers{game.ActionOn(1)}.Hand)
            for m = 1:length(game.ActivePlayers) 
                if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
                    nPchange = m;
                    break
                end
            end
            
            set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','none');
            game.ActionOn(2) = game.ActionOn(2) + 1; %go to the next hand
            child = get(game.UI.HandStringPanel,'Children');
            for i = 1:length(child)
                delete(child(i));
            end
            game.BettingPlayers{game.ActionOn(1)}.Action = 'start';
            play(game);
        else
            if game.ActionOn(1) < length(game.BettingPlayers)
                for m = 1:length(game.ActivePlayers)
                    if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
                        nPchange = m;
                        break
                    end
                end
                set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','none');
                game.ActionOn(1) = game.ActionOn(1) + 1; %go to the next player
                game.ActionOn(2) = 1;
                
                play(game);
            else
                for m = 1:length(game.ActivePlayers)
                    if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
                        nPchange = m;
                        break
                    end
                end
                set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','none');
                game.Stage = 'dealer'; %all players have finished their actions
                play(game);
            end
        end
    elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'start')
        for m = 1:length(game.ActivePlayers)
            if strcmp(game.BettingPlayers{game.ActionOn(1)}.Name, game.ActivePlayers{m}.Name)
                nPchange = m;
                break
            end
        end
        set(game.UI.HandDispPanels{2*nPchange+game.ActionOn(2)-1},'BorderType','line'); %highlight hand of current player
        if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value == 21 %if player has a blackjack
            set(game.UI.Title1,'Visible','on',...
                'Position',[0.3 0.9 0.4 0.1],...
                'String',[game.BettingPlayers{game.ActionOn(1)}.Name '''s turn to act ...']);
            game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
            if length(game.BettingPlayers)+length(game.BettingPlayers{1}.Hand) > 2
                set(game.UI.Title2,'Visible','on',...
                    'Position',[0.1 0.6 0.4 0.1],...
                    'String','Your hand:',...
                    'HorizontalAlignment','right');
                set(game.UI.HandStringPanel,'Visible','on');
                handstr = {};
                for i = 1:length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards)
                    ID = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.ID;
                    if strcmp('S',ID(end)) 
                        suit = 'S';
                        col = 'k';
                    elseif strcmp('H',ID(end))
                        suit = 'H';
                        col = 'r';
                    elseif strcmp('C',ID(end))
                        suit = 'C';
                        col = 'k';
                    elseif strcmp('D',ID(end))
                        suit = 'D';
                        col = 'r';
                    end
                    handstr{length(handstr)+1} = uicontrol('Parent',game.UI.HandStringPanel,...
                        'Units','normalized',...
                        'Style','text',...
                        'String',[ID(1:end-1) suit],...
                        'FontSize',15,...
                        'FontWeight','bold',...
                        'ForegroundColor',col,...
                        'Position',[(i-1)*.1 0 0.1 1]);
                end
                set(game.UI.Title3,'Visible','on',...
                    'Position',[0.1 0.5 0.4 0.1],...
                    'String','Your hand value:',...
                    'HorizontalAlignment','right');
                has11Ace = 0;
                for i = 1:length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards)
                    if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.Value == 11
                        has11Ace = 1;
                        break
                    end
                end
                val = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value;
                
                if has11Ace
                    if val ~= 21
                        val = [num2str(val) ' or ' num2str(val - 10)];
                    else
                        val = num2str(val);
                    end
                else
                    val = num2str(val);
                end
                set(game.UI.ValueString,'Visible','on',...
                    'String', ['    ' val],...
                    'HorizontalAlignment','left');
                dispResult(game,game.ActionOn(1),game.ActionOn(2),'BlackJack!');
            end
            play(game);
        else
            if bustedAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)})
                reduceAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)});
            end
            getAction(game); %if player doens't have a blackjack
            
        end
    elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'hit')
        dealCard(game, game.ActionOn(1), game.ActionOn(2)); %hit a card
        dispHand(game, game.ActionOn(1), game.ActionOn(2), 'none');
        if 20 < game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value %if player has 21 or is busted
            if bustedAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)})  %check if busted due to value 11 Ace
                reduceAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)});
                if 21 > game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value
                    getAction(game);
                elseif game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Value == 21
                    dispResult(game,game.ActionOn(1),game.ActionOn(2),'21!');
                    game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
                    play(game);
                else
                    game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
                    play(game);
                end
            else
                game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
                play(game);
            end
        else
            getAction(game);
        end
    elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'split') %only doable from 'start'
        %create second hand
        game.BettingPlayers{game.ActionOn(1)}.Hand{length(game.BettingPlayers{game.ActionOn(1)}.Hand)+1} = Hand();
        %set Doubled = 1 for new hand
        game.BettingPlayers{game.ActionOn(1)}.Hand{length(game.BettingPlayers{game.ActionOn(1)}.Hand)}.Doubled = 1;
        %make first card of second hand, the second card of the first hand
        addCard(game.BettingPlayers{game.ActionOn(1)}.Hand{length(game.BettingPlayers{game.ActionOn(1)}.Hand)}, game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{2});
        %only keep the first card of the first hand (make sure
        %this doesn't mess up everything due to handle class)
        game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards = {game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{1}};
        dispHand(game, game.ActionOn(1), 1, 'none');
        dispHand(game, game.ActionOn(1), 2, 'none');
        %deal card to first hand
        dealCard(game, game.ActionOn(1), game.ActionOn(2));
        dispHand(game, game.ActionOn(1), game.ActionOn(2), 'none');
        %deal card to second hand
        dealCard(game, game.ActionOn(1), length(game.BettingPlayers{game.ActionOn(1)}.Hand));
        dispHand(game, game.ActionOn(1), length(game.BettingPlayers{game.ActionOn(1)}.Hand), 'none');
        game.BettingPlayers{game.ActionOn(1)}.Action = 'start';
        play(game);
    elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'surrender') %only doable from 'start'
        for i = 1:2
            game.UsedDeck.Cards{length(game.UsedDeck.Cards)+1} = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i};
        end
        game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)} = Hand();
        game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        play(game);
    elseif strcmp(game.BettingPlayers{game.ActionOn(1)}.Action, 'double')
        dealCard(game, game.ActionOn(1), game.ActionOn(2));
        dispHand(game, game.ActionOn(1), game.ActionOn(2), 'none');
        game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Doubled = 2;
        game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        if bustedAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)})
            reduceAce(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)});
        end
        play(game);
    end
elseif strcmp(game.Stage, 'dealer') %Dealer Action Stage
    dispHand(game, 0, 1, 'reveal');
    if bustedAce(game.Dealer)
        reduceAce(game.Dealer);
    end
    if game.Dealer.Value < 17 %hit if below 17
        dealCard(game, 0);
        dispHand(game, 0, 1, 'reveal');
    else
        game.Stage = 'results';
    end
    play(game);
elseif strcmp(game.Stage, 'results') %Results Stage
    set(game.UI.Title1,'Visible','off');
    set(game.UI.Title2,'Visible','off');
    set(game.UI.HandStringPanel,'Visible','off');
    set(game.UI.ValueString,'Visible','off');
    set(game.UI.Title3,'Visible','off');
    set(game.UI.Title2, 'HorizontalAlignment','center');
    
    for k = 1:5
        set(game.UI.ActionButtons{k},'Visible','off');
    end
    results = [];
    for i = 1:length(game.BettingPlayers)
        results(i) = 0; %results of players
    end
    if isa(game.Dealer.Cards{1}, 'AceCard') %Insurance Results
        insurance_result = zeros(1,length(game.BettingPlayers));
        if isBlackJack(game.Dealer)
            for i = 1:length(game.BettingPlayers)
                if game.BettingPlayers{i}.Insured
                    game.BettingPlayers{i}.result(1); %insurance bet won
                    results(i) = results(i) + 1 * game.BettingPlayers{i}.BetB;
                    insurance_result(i) = 1;
                end
            end
        else
            for i = 1:length(game.BettingPlayers)
                if game.BettingPlayers{i}.Insured
                    if round(game.BettingPlayers{i}.BetB*100/2) == game.BettingPlayers{i}.BetB*100/2
                        game.BettingPlayers{i}.result(-1/2); %insurance bet lost
                        results(i) = results(i) - 1/2 * game.BettingPlayers{i}.BetB;
                    else
                        game.BettingPlayers{i}.result(-1/2);
                        results(i) = results(i) - ceil(game.BettingPlayers{i}.BetB * 1/2 * 100) / 100;
                    end
                    insurance_result(i) = -1;
                end
            end
        end
        dispResults(game,'insurance', insurance_result);
    end
    result_data = {};
    for i = 1:length(game.BettingPlayers) %Hand Results
        for j = 1:length(game.BettingPlayers{i}.Hand)
            if isempty(game.BettingPlayers{i}.Hand{j}.Cards) %if hand was surrendered
                game.BettingPlayers{i}.result(-1/2);
                results(i) = results(i) - 1/2 * game.BettingPlayers{i}.BetB;
                result_data{length(result_data)+1} = 'Surrender';
            elseif isBlackJack(game.BettingPlayers{i}.Hand{j}) && ~isBlackJack(game.Dealer) %if player wins off blackjack
                game.BettingPlayers{i}.result(3/2);
                results(i) = results(i) + 3/2 * game.BettingPlayers{i}.BetB;
                result_data{length(result_data)+1} = 'BlackJack';
            elseif isBlackJack(game.Dealer) && ~isBlackJack(game.BettingPlayers{i}.Hand{j}) %if player loses from dealer blackjack
                game.BettingPlayers{i}.result(-1*game.BettingPlayers{i}.Hand{j}.Doubled);
                results(i) = results(i) - 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
                result_data{length(result_data)+1} = 'Hand_Loses';
            elseif game.BettingPlayers{i}.Hand{j}.Value > 21 %if player busted
                game.BettingPlayers{i}.result(-1*game.BettingPlayers{i}.Hand{j}.Doubled);
                results(i) = results(i) - 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
                result_data{length(result_data)+1} = 'Busted';
            elseif game.Dealer.Value > 21 %if dealer busted
                game.BettingPlayers{i}.result(1*game.BettingPlayers{i}.Hand{j}.Doubled);
                results(i) = results(i) + 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
                result_data{length(result_data)+1} = 'Hand_Wins';
            elseif game.Dealer.Value > game.BettingPlayers{i}.Hand{j}.Value %if player loses on hand value
                game.BettingPlayers{i}.result(-1*game.BettingPlayers{i}.Hand{j}.Doubled);
                results(i) = results(i) - 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
                result_data{length(result_data)+1} = 'Hand_Loses';
            elseif game.Dealer.Value == game.BettingPlayers{i}.Hand{j}.Value %if player pushes on hand value
                result_data{length(result_data)+1} = 'Push';
            elseif game.Dealer.Value < game.BettingPlayers{i}.Hand{j}.Value %if player wins on hand value
                game.BettingPlayers{i}.result(1*game.BettingPlayers{i}.Hand{j}.Doubled);
                results(i) = results(i) + 1 * game.BettingPlayers{i}.BetB * game.BettingPlayers{i}.Hand{j}.Doubled;
                result_data{length(result_data)+1} = 'Hand_Wins';
            end
            raiseHand(game.BettingPlayers{i}.Hand{j}); %set the AceCard values to 11
            for k = 1:length(game.BettingPlayers{i}.Hand{j}.Cards)
                addCard(game.UsedDeck, game.BettingPlayers{i}.Hand{j}.Cards{k}); %put the cards into UsedDeck
            end
            for q = 1:length(game.ActivePlayers)
                if strcmp(game.ActivePlayers{q}.Name,game.BettingPlayers{i}.Name)
                    pindex = q;
                    break
                end
            end
            set(game.UI.NameTexts{pindex},'Visible','on',... %interactive panel results display
                'Position',[0.1+(q-1)*0.18 0.6 0.18 0.1],...
                'String',game.BettingPlayers{i}.Name);
            fund = game.BettingPlayers{i}.Funds;
            fundstr = ['$' num2str(fund)];
            if round(fund) == fund
                fundstr = [fundstr '.00'];
            elseif round(fund*10) == fund*10
                fundstr = [fundstr '0'];
            end
            set(game.UI.FundTexts{pindex},'Visible','on',...
                'Position',[0.1+(q-1)*0.18 0.5 0.18 0.1],...
                'String',fundstr);
            if results(i) < 0
                signstr = 'Lose ';
            elseif results(i) > 0;
                signstr = 'Win ';
            else
                signstr = 'Push ';
            end
            [a,b] = strread(num2str(results(i)), '%s %s', 'delimiter', '.');
            if isempty(b)
            elseif length(b{1}) < 3
            else
                results(i) = results(i) - 0.005;
            end
            resultstr = ['$' num2str(abs(results(i)))];
            if round(results(i)) == results(i)
                resultstr = [resultstr '.00'];
            elseif round(results(i)*10) == results(i) * 10
                resultstr = [resultstr '0'];
            end
            set(game.UI.ResultTexts{pindex},'Visible','on',...
                'Position',[0.1+(q-1)*0.18 0.4 0.18 0.1],...
                'String',[signstr resultstr]);
            game.BettingPlayers{i}.AddResult(results(i), 'B');
            
            
        end
        
    end
    
    dispResults(game,'hands', result_data); %show final results on visual panel
    
    for i = 1:length(game.Dealer.Cards)
        addCard(game.UsedDeck, game.Dealer.Cards{i}); %add dealer's cards to UsedDeck
    end
    
    shuffleDeck(game.UsedDeck);
    for i = 1:length(game.UsedDeck.Cards)
        addCard(game.Deck, game.UsedDeck.Cards{i}); %add UsedDeck to Deck
    end
    game.UsedDeck = Deck('Used');
    game.Stage = 'betting'; %go back to betting stage
    set(game.UI.NextButton,'Visible','on',...
        'String','Next Hand',...
        'Position', [0.2 0.2 0.3 0.1],...
        'CallBack',@(h,d) nexthand_callback(h,d));
    set(game.UI.LeaveButton,'Visible','on',...
        'Position',[0.5 0.2 0.3 0.1],...
        'CallBack',@(h,d) leave_callback(h,d));
    
    
    
end
    function nexthand_callback(h,d)
        for i = 1:4
            set(game.UI.NameTexts{i},'Visible','off');
            set(game.UI.FundTexts{i},'Visible','off');
            set(game.UI.ResultTexts{i},'Visible','off');
        end
        set(game.UI.NextButton,'Visible','off');
        set(game.UI.LeaveButton,'Visible','off');
        for i = 1:length(game.UI.HandDispPanels)
            set(game.UI.HandDispPanels{i},'Visible','off');
        end
        out = game.Casino.Checkmoney;
        if ~out
            game.Stage = 'betting';
            game.ActionOn = [1 1];
            play(game);
        end
    end

    function leave_callback(h,d)
        out = game.Casino.Checkmoney;
        if ~out
            game.Stage = 'close';
            play(game);
        end
    end
end