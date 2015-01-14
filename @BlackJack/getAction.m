function getAction(game)
%This function will ask for the current player's next action.
set(game.UI.Title1,'Visible','on',...
    'Position',[0.3 0.9 0.4 0.1],...
    'String',[game.BettingPlayers{game.ActionOn(1)}.Name '''s turn to act ...']);
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
% child = get(game.UI.HandShowPanel,'Children');
% for i = 1:length(child)
%     delete(child(i));
% end
% 
% l = length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards);
% pos = get(game.UI.HandShowPanel,'Position');
% set(game.UI.HandShowPanel,'Position',[pos(1:2) 0.1*l pos(4)]); 
% for i = 1:l
%     subplot(1,l,i,'Parent',game.UI.HandShowPanel)
%     ID = game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{i}.ID;
%     imshow(['CardPNG/' ID '.png']);
% end






actions = [1, 1, 1, 1, 1];
if length(game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards) == 2
    if game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{1}.Value == game.BettingPlayers{game.ActionOn(1)}.Hand{game.ActionOn(2)}.Cards{2}.Value
        if length(game.BettingPlayers{game.ActionOn(1)}.Hand) > 1
            actions(2) = 0;
        end
    else
        actions(2) = 0;
    end
else
    actions(2:4) = 0;
end
%check if sufficient funds to split or double
f = game.BettingPlayers{game.ActionOn(1)}.Funds;
b = game.BettingPlayers{game.ActionOn(1)}.BetB;
if game.BettingPlayers{game.ActionOn(1)}.Insured
    ins = 1/2;
else
    ins = 0;
end
if length(game.BettingPlayers{game.ActionOn(1)}.Hand) > 1
    if f < b*(3+ins);
        actions(3) = 0;
    end
else
    if f < b*(2+ins);
        actions(2:3) = 0;
    end
end

x = (21-4*dot(actions,[1 1 1 1 1]))/40;
n = 1;
for i = 1:5
    if actions(i)
        set(game.UI.ActionButtons{i},'Visible','on',...
            'Position',[x+(n-1)*0.2 0.3 0.15 0.1],...
            'CallBack',@(h,d) actioncallback(h,d));
        n = n+1;
    else
        set(game.UI.ActionButtons{i},'Visible','off');
    end
end
    function actioncallback(h,d)
        if strcmp(get(h,'String'),'Hit')
            game.BettingPlayers{game.ActionOn(1)}.Action = 'hit';
        elseif strcmp(get(h,'String'),'Stay')
            game.BettingPlayers{game.ActionOn(1)}.Action = 'stay';
        elseif strcmp(get(h,'String'),'Surrender')
            game.BettingPlayers{game.ActionOn(1)}.Action = 'surrender';
        elseif strcmp(get(h,'String'),'Split')
            game.BettingPlayers{game.ActionOn(1)}.Action = 'split';
        elseif strcmp(get(h,'String'),'Double')
            game.BettingPlayers{game.ActionOn(1)}.Action = 'double';
        end
        for i = 1:length(handstr)
            delete(handstr{i});
        end
        
        play(game);
    end


end