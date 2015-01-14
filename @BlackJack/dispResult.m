function dispResult(game, nP, nH, result)
%This function will display some results for ra specific player (result
%will be '21', 'BlackJack', 'Busted', or 'Dealer BlackJack').
for i = 1:5
    set(game.UI.ActionButtons{i},'Visible','off');
end
if nP == 0
    n = 1;
else
    for i = 1:length(game.ActivePlayers)
        if strcmp(game.ActivePlayers{i}.Name, game.BettingPlayers{nP}.Name)
            n = 2*i+nH-1;
            break
        end
    end
end
a = axes('Parent',game.UI.HandDispPanels{n},...
    'Units','normalized',...
    'Visible','on');
image_handle = imshow(['BlackJackResults/' result '.jpg']);
set(a,'Position',[0 0 1 1]);
axis normal
transparency = 1;
pause(1.5)
for i = 1:4
    transparency = transparency - 0.05;
    set(image_handle,'AlphaData',transparency);
    pause(0.3);
end
for k = 1:16
    transparency = transparency - 0.05;
    set(image_handle,'AlphaData',transparency);
    pause(0.06);
end
delete(a);
end