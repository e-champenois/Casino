function dispHand(game, nP, nH, style)
%This function will display a specific player's hand (style is 'none' or
%'reveal', depending whether or not the dealer is hiding one of his cards).
if nP > 0
    for i = 1:length(game.ActivePlayers)
        if strcmp(game.ActivePlayers{i}.Name, game.BettingPlayers{nP}.Name)
            nPo = i;
            break
        end
    end
end

if nargin == 3
    style = 'none';
end

if nP > 0
    l = length(game.BettingPlayers{nP}.Hand{nH}.Cards);
    set(game.UI.HandDispPanels{2*nPo+nH-1},'Visible','on')
    child = get(game.UI.HandDispPanels{2*nPo+nH-1},'Children');
elseif nP == 0
    l = length(game.Dealer.Cards);
    set(game.UI.HandDispPanels{1},'Visible','on');
    child = get(game.UI.HandDispPanels{1},'Children');
end
if l > 10
    l = 10;
end
for i = 1:length(child)
    delete(child(i));
end

if l < 6
    x = l;
    y = 1;
    width = 1/l - 0.02;
    height = 1;
else
    x = 5;
    y = 2;
    width = 1/5 - 0.02;
    height = 0.5;
end


for i = 1:l
    if nP > 0
        ID = game.BettingPlayers{nP}.Hand{nH}.Cards{i}.ID;
        plothandle = subplot(y,x,i,'Parent',game.UI.HandDispPanels{2*nPo+nH-1});
    elseif nP == 0
        if strcmp(style,'none') && i == 2
            ID = 'Back';
        else
            ID = game.Dealer.Cards{i}.ID;
        end
        plothandle = subplot(y,x,i,'Parent',game.UI.HandDispPanels{1});
    end
    imshow(['CardPNG/' ID '.png']);
    if i > 5
        ypos = 0;
        xpos = (i-6)*1/5;
    else
        if l > 5
            xpos = (i-1)*1/5;
            ypos = 0.5;
        else
            xpos = (i-1)*1/l;
            ypos = 0;
        end
    end
    set(plothandle,'Position',[xpos ypos width height]);
end
end