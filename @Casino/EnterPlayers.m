function EnterPlayers(casino)       
% Creates panel with ability to add players and to enter the casino once
% all players have been entered into the casino.

Playerpanel = uipanel('Parent',casino.Figure,...  % The panel that the UI is built on
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 0 .65 1]);
sth = uicontrol('Parent',Playerpanel,...
    'Style','text',...
    'String','Enter next player''s name.',...
    'FontSize',15,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[.35 .85 .3 .035]);
nameEdit = uicontrol('Parent',Playerpanel,...  % The name edit box
    'Style','edit',...
    'Units', 'normalized',...
    'FontSize',15,...
    'Position',[.35 .8 .3 .05]);
submitButton = uicontrol('Parent',Playerpanel,...% the submit button
    'Style','pushbutton',...
    'String', 'Player Enters Casino.',...
    'Units', 'normalized',...
    'FontSize',15,...
    'Position',[.35 .7 .3 .075],...
    'Callback',@submit_callback);
enterButton = uicontrol('Parent',Playerpanel,...% the enter button
    'Style','pushbutton',...
    'String', 'Go to Casino floor.',...
    'Units', 'normalized',...
    'FontSize',15,...
    'Position',[.35 .6 .3 .075],...
    'Callback',@enter_callback);
removeButton = uicontrol('Parent',Playerpanel,...% the remove button
    'Style','pushbutton',...
    'String', 'Remove Player',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.35 .5 .3 .075],...
    'Callback',@remove_callback);
    function submit_callback(hObject,eventdata)
        name = get(nameEdit,'String');
        [inuse,temp] = Checklist(casino,name);
        l = length(casino.ActivePlayers);
        if isempty(name)         % Checks to see if player entered is valid
            h = errordlg('Player must have a name!','Error','modal');
        elseif inuse
            h = errordlg('That name is already in use!','Error','modal');
        elseif l == 4
            h = errordlg('There can only be 4 players at once!','Error','modal');
        else
            temp2 = exist(['savednames/' name '.mat']);
            if temp2 == 0
                pl = Players(name,1000);
            else
                f = load(['savednames/' name '.mat']);
                pl = Players(name,f.fun);
                pl.LoadRes(f.res);
            end
            addlistener(pl,'NoMoney',@(pl,eventData)Nomoney(casino,pl,eventData));
            casino.ActivePlayers{end+1} = pl;
            casino.Playerslist
        end
    end
    function enter_callback(hObject,eventdata)
        if isempty(casino.ActivePlayers)
            h = errordlg('Must have at least one player to enter Casino!','Error','modal');
        else
            set(Playerpanel,'Visible','off')
            set(casino.Listpanel,'Visible','off')
            drawnow
            casino.ChooseGame;
        end
    end
    function remove_callback(hObject,eventdata)
        set(Playerpanel,'Visible','off')
        casino.RemovePlayers
    end
end