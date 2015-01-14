classdef Casino < handle
    % This is the main casino class.  This class is called by typing Casino
    % into the command line.  Once a casino object has been created, it
    % allows for the user to play in the casino using a graphical user
    % interface.
    
    properties (SetAccess = private)
        ActivePlayers = {} %cellarray of active players in the casino
        Figure = [];  %Handle of figure that the casino will be on
        Listpanel = [];  %handle of panel that has a list of all players
        Menu = [];      %Handle to the statistics menu
    end
    properties
        CurrentPlayers = {};  %Cellarray of players who are playing a particular game
    end
    
    methods
        function obj = Casino                        %Constructor for Casino class
            obj.Figure = figure('Name','Casino',...
                'Toolbar','none',...
                'NumberTitle','off',...
                'DockControls','off',...
                'MenuBar','none');
            set(obj.Figure,'Position',[0 0 1280 760])
            obj.CreateStatsMenu
            obj.EnterPlayers
            obj.Playerslist
        end
        function Playerslist(casino)     % Creates panel with list of active players
            if isempty(casino.Listpanel)
                Listpanel = uipanel('Parent',casino.Figure,...
                    'Backgroundcolor', get(casino.Figure,'color'),...
                    'Units','normalized',...
                    'Position',[.65 0 .35 1]);
                casino.Listpanel = Listpanel;
            end
            Listpanel = casino.Listpanel;
            sth = uicontrol('Parent',Listpanel,...
                'Style','text',...
                'String','List of current players.',...
                'FontSize',15,...
                'Backgroundcolor', get(casino.Figure,'color'),...
                'Units','normalized',...
                'Position',[.2 .85 .6 .035]);
            l = length(casino.ActivePlayers);
            for  i = 1:l
                name = casino.ActivePlayers{i}.Name;
                funds = casino.ActivePlayers{i}.Funds;
                sth = uicontrol('Parent',Listpanel,...
                    'Style','text',...
                    'String',name,...
                    'FontSize',15,...
                    'Backgroundcolor', get(casino.Figure,'color'),...
                    'Units','normalized',...
                    'Position',[.2 .8-(i-1)*.1 .6 .035]);
                fundstr = ['$' num2str(funds)];
                if round(funds) == funds
                    fundstr = [fundstr '.00'];
                elseif round(funds*10) == funds*10
                    fundstr = [fundstr '0'];
                end
                sth = uicontrol('Parent',Listpanel,...
                    'Style','text',...
                    'String',[name ' has ' fundstr],...
                    'FontSize',15,...
                    'Backgroundcolor', get(casino.Figure,'color'),...
                    'Units','normalized',...
                    'Position',[.2 .765-(i-1)*.1 .6 .035]);
            end
            set(casino.Listpanel,'Visible','on')
        end
        function [inuse,i] = Checklist(casino,name)  %Checks to see if name is a player.
            inuse = false;
            player = [];
            l = length(casino.ActivePlayers);
            for i = 1:l
                if strcmpi(casino.ActivePlayers{i}.Name,name)
                    inuse = true;
                    player = casino.ActivePlayers{i};
                    break
                end
            end
        end
        function RemovePlayers(casino)                 % Creates UI for removing players manually
            Removepanel = uipanel('Parent',casino.Figure,...
                'Backgroundcolor', get(casino.Figure,'color'),...
                'Units','normalized',...
                'Position',[0 0 .65 1]);
            sth = uicontrol('Parent',Removepanel,...
                'Style','text',...
                'String','Which players do you want to remove?',...
                'Backgroundcolor', get(casino.Figure,'color'),...
                'FontSize',15,...
                'Units','normalized',...
                'Position',[.3 .85 .4 .075]);
            for i = 1:length(casino.ActivePlayers)
                Playerbutton{i} = uicontrol('Parent',Removepanel,...
                    'Style','checkbox',...
                    'Units', 'normalized',...
                    'Backgroundcolor', get(casino.Figure,'color'),...
                    'FontSize',15,...
                    'String', casino.ActivePlayers{i}.Name,...
                    'Position',[.35 .85-.05*i .3 .05]);
            end
            removeButton = uicontrol('Parent',Removepanel,...% the remove button
                'Style','pushbutton',...
                'String', 'Remove Players',...
                'Units', 'normalized',...
                'FontSize',15,...
                'Position',[.35 .3 .3 .075],...
                'Callback',@remove_callback);
            function remove_callback(hObject,eventdata)
                players = [];
                for j = 1:length(Playerbutton)
                    l = Playerbutton{j};
                    if get(l,'Value')== 1
                        players = [players j];
                    end
                end
                for k = length(players):-1:1
                    casino.RemovePlayer(players(k))
                end
                set(Removepanel,'Visible','off')
                set(casino.Listpanel,'Visible','off')
                casino.Listpanel = [];
                casino.EnterPlayers
                casino.Playerslist
            end
            
        end
        function RemovePlayer(casino,i)  % Removes a player from the casino
            casino.ActivePlayers(i) = [];
        end
        function Nomoney(casino,player,eventData)  % Called when a player in the casino runs out of money
            [temp,i] = casino.Checklist(player.Name);
            casino.RemovePlayer(i)
            clf(casino.Figure)
            casino.Listpanel = [];
            delete(['savednames/' player.Name '.mat'])
            casino.CreateStatsMenu
            casino.EnterPlayers
            casino.Playerslist
            h = errordlg([player.Name ' has been removed from the Casino due to lack of funds.'],'Error','modal');
            waitfor(h)
        end
        function out = Checkmoney(casino)  % Checks the money of every player to see if they are out of money
            out = false; 
            l = length(casino.ActivePlayers);
            for i = l:-1:1
                if casino.ActivePlayers{i}.Funds <= 0
                    notify(casino.ActivePlayers{i},'NoMoney')
                    out = true;
                end
            end
        end
        function CreateStatsMenu(casino)  % Creates the menu option for statistics
            casino.Menu = uimenu('Parent',casino.Figure,...
                'Label','File');
            uimenu('Parent',casino.Menu,...
                'Label','Quit',...
                'Callback',@quit_callback);
            function quit_callback(hObject,eventdata)
                close(casino.Figure)
            end
            casino.Menu = uimenu('Parent',casino.Figure,...
                'Label','Statistics');
            uimenu('Parent',casino.Menu,...
                'Label','View Statistics',...
                'Callback',@menu_callback);
            function menu_callback(hObject,eventdata)
                StatViewer(casino);
            end
        end
    end
end