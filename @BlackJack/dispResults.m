function dispResults(game, style, data)
%This function displays the results of the round. Style can be 'insurance'
%or 'hands'. Data will be data for each player's insurance or hand result.
pause(1);
for i = 1:9
    a{i} = axes('Parent',game.UI.HandDispPanels{i},...
        'Units','normalized',...
        'Visible','off');
end
image_handles = {};
if game.Dealer.Value > 21
    set(a{1},'Visible','on');
    axes(a{1});
    image_handles{length(image_handles)+1} = imshow('BlackJackResults/Dealer_Busted.jpg'); %Dealer_Busted
    set(a{1},'Position',[0 0 1 1]);
    axis normal
elseif isBlackJack(game.Dealer)
    set(a{1},'Visible','on');
    axes(a{1});
    image_handles{length(image_handles)+1} = imshow('BlackJackResults/Dealer_BlackJack.jpg'); %Dealer_BlackJack
    set(a{1},'Position',[0 0 1 1]);
    axis normal
end
for i = 1:length(game.BettingPlayers)
    if strcmp(style,'hands')
        for j = 1:length(game.BettingPlayers{i}.Hand)
            for m = 1:length(game.ActivePlayers)
                if strcmp(game.BettingPlayers{i}.Name, game.ActivePlayers{m}.Name)
                    nPchange = m;
                    break
                end
            end
            set(a{2*nPchange+j-1},'Visible','on');
            axes(a{2*nPchange+j-1});
            image_handles{length(image_handles)+1} = imshow(['BlackJackResults/' data{1} '.jpg']);   %data{1}
            set(a{2*nPchange+j-1},'Position',[0 0 1 1]);
            axis normal
            data(1) = [];
        end
    elseif strcmp(style,'insurance')
        
        if data(i) == 1
            for m = 1:length(game.ActivePlayers)
                if strcmp(game.BettingPlayers{i}.Name, game.ActivePlayers{m}.Name)
                    nPchange = m;
                    break
                end
            end
            set(a{2*nPchange},'Visible','on');
            axes(a{2*nPchange});
            image_handles{length(image_handles)+1} = imshow('BlackJackResults/Insurance_Win.jpg');  %Insurance_Win
            set(a{2*nPchange},'Position',[0 0 1 1]);
            axis normal
        elseif data(i) == -1
            for m = 1:length(game.ActivePlayers)
                if strcmp(game.BettingPlayers{i}.Name, game.ActivePlayers{m}.Name)
                    nPchange = m;
                    break
                end
            end
            set(a{2*nPchange},'Visible','on');
            axes(a{2*nPchange});
            image_handles{length(image_handles)+1} = imshow('BlackJackResults/Insurance_Lost.jpg');  %Insurance_Loss
            set(a{2*nPchange},'Position',[0 0 1 1]);
            axis normal
        end
    end
    
end
pause(2);
transparency = 1;
for k = 1:4
    transparency = transparency - 0.05;
    for l = 1:length(image_handles)
        set(image_handles{l},'AlphaData',transparency);
    end
    pause(0.3);
end
for k = 1:16
    transparency = transparency - 0.05;
    for l = 1:length(image_handles)
        set(image_handles{l},'AlphaData',transparency);
    end
    pause(0.06);
end
for k = 1:9
    delete(a{k});
end
%ADD DELETE FUNCTIONS?
end
