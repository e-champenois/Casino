function ChooseGame(casino)
% Method that creates a user interface that allows for the user to select
% one of the three games in the casino.


BlackJackpanel = uipanel('Parent',casino.Figure,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 .3 .33 .5]);
Roulettepanel = uipanel('Parent',casino.Figure,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[.33 .3 .33 .5]);
Slotspanel = uipanel('Parent',casino.Figure,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[.66 .3 .34 .5]);
Changepanel = uipanel('Parent',casino.Figure,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 0 1 .3]);
Choosepanel = uipanel('Parent',casino.Figure,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 .8 1 .2]);
sth = uicontrol('Parent',Choosepanel,...
    'Style','text',...
    'String','Choose a game to play.',...
    'FontSize',15,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 0 1 1]);
bjh = uicontrol('Parent',BlackJackpanel,...
    'Style','text',...
    'String','BlackJack',...
    'FontSize',15,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 .8 1 .2]);
rh = uicontrol('Parent',Roulettepanel,...
    'Style','text',...
    'String','Roulette',...
    'FontSize',15,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 .8 1 .2]);
sh = uicontrol('Parent',Slotspanel,...
    'Style','text',...
    'String','Slots',...
    'FontSize',15,...
    'Backgroundcolor', get(casino.Figure,'color'),...
    'Units','normalized',...
    'Position',[0 .8 1 .2]);
BlackJackButton = uicontrol('Parent',BlackJackpanel,...% the play BlackJack button
    'Style','pushbutton',...
    'String', 'Play BlackJack',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.2 .5 .6 .1],...
    'Callback',@blackjack_callback);
RouletteButton = uicontrol('Parent',Roulettepanel,...% the play Roulette button
    'Style','pushbutton',...
    'String', 'Play Roulette',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.2 .5 .6 .1],...
    'Callback',@roulette_callback);
SlotsButton = uicontrol('Parent',Slotspanel,...% the play Slots button
    'Style','pushbutton',...
    'String', 'Play Slots',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.2 .5 .6 .1],...
    'Callback',@slots_callback);
ChangeButton = uicontrol('Parent',Changepanel,...% the change players button
    'Style','pushbutton',...
    'String', 'Change Players',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.4 .5 .2 .15],...
    'Callback',@change_callback);
    function blackjack_callback(hObject,eventdata)
        set(Choosepanel,'Visible','off')
        set(BlackJackpanel,'Visible','off')
        set(Roulettepanel,'Visible','off')
        set(Slotspanel,'Visible','off')
        set(Changepanel,'Visible','off')
        drawnow
        BlackJack(casino);
    end
    function roulette_callback(hObject,eventdata)
        set(Choosepanel,'Visible','off')
        set(BlackJackpanel,'Visible','off')
        set(Roulettepanel,'Visible','off')
        set(Slotspanel,'Visible','off')
        set(Changepanel,'Visible','off')
        drawnow
        Roulette(casino);
    end
    function slots_callback(hObject,eventdata)
        set(Choosepanel,'Visible','off')
        set(BlackJackpanel,'Visible','off')
        set(Roulettepanel,'Visible','off')
        set(Slotspanel,'Visible','off')
        set(Changepanel,'Visible','off')
        drawnow
        Slots(casino);
    end
    function change_callback(hObject,eventdata)
        set(Choosepanel,'Visible','off')
        set(BlackJackpanel,'Visible','off')
        set(Roulettepanel,'Visible','off')
        set(Slotspanel,'Visible','off')
        set(Changepanel,'Visible','off')
        drawnow
        casino.EnterPlayers
        casino.Playerslist
    end
end