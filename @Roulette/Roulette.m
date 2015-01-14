classdef Roulette < handle
% This is the main Roulette class.  It is called by the ChooseGame method
% of the Casino class.  This class creates all of the necesarry components
% needed for the user to have a graphical user interface to play roulette.
    
    properties (SetAccess = private)
        Casino = [];  % Casino object for which roulette is being played in.
        Wheel = [];   % Roulette Wheel object being used in this game
        Table = [];   % Roulette Table object being used in this game
        CurrentPlayer = [];  % Index of the current player
        WinValue = [];      % The winning value for a given spin 
    end
    properties (Dependent = true, SetAccess = private)
        NumberPlayers = [];  % The number of player playing roulette
    end
    
    methods
        function obj = Roulette(casino)         % The Constructor
            obj.Casino = casino;
            obj.ChoosePlayers
        end
        function ChoosePlayers(rou) % Creates the UI used to select who will play roulette
            rou.Casino.Playerslist
            Playerpanel = uipanel('Parent',rou.Casino.Figure,...
                'Backgroundcolor', get(rou.Casino.Figure,'color'),...
                'Units','normalized',...
                'Position',[0 0 .65 1]);
            sth = uicontrol('Parent',Playerpanel,...
                'Style','text',...
                'String','Who will be playing this game?',...
                'FontSize',15,...
                'Backgroundcolor', get(rou.Casino.Figure,'color'),...
                'Units','normalized',...
                'Position',[.3 .85 .4 .035]);
            for i = 1:length(rou.Casino.ActivePlayers)
                Playerbutton{i} = uicontrol('Parent',Playerpanel,...  % Checkbox for each possible player
                    'Style','checkbox',...
                    'Units', 'normalized',...
                    'FontSize',15,...
                    'Backgroundcolor', get(rou.Casino.Figure,'color'),...
                    'String', rou.Casino.ActivePlayers{i}.Name,...
                    'Position',[.35 .85-.05*i .3 .05]);
            end
            
            PlayButton = uicontrol('Parent',Playerpanel,...% the Play button
                'Style','pushbutton',...
                'String', 'Play Roulette.',...
                'Units', 'normalized',...
                'FontSize',15,...
                'Position',[.35 .4 .3 .075],...
                'Callback',@play_callback);
            LeaveButton = uicontrol('Parent',Playerpanel,...% the Leave button
                'Style','pushbutton',...
                'String', 'Leave Roulette.',...
                'FontSize',15,...
                'Units', 'normalized',...
                'Position',[.35 .2 .3 .075],...
                'Callback',@leave_callback);
            function play_callback(hObject,eventdata)
                players = [];
                rou.Casino.CurrentPlayers = {};
                for j = 1:length(Playerbutton)
                    l = Playerbutton{j};
                    if get(l,'Value')== 1
                        players = [players j];
                    end
                end
                if isempty(players)
                    h = errordlg('At least one player must play roulette!','Error','modal');
                else
                    for k = 1:length(players)
                        rou.Casino.CurrentPlayers{k} = rou.Casino.ActivePlayers{players(k)};
                    end
                    rou.CurrentPlayer = 1;
                    set(Playerpanel,'Visible','off')
                    set(rou.Casino.Listpanel,'Visible','off')
                    drawnow
                    rou.PlayRoulette
                end
            end
            function leave_callback(hObject,eventdata)
                set(Playerpanel,'Visible','off')
                set(rou.Casino.Listpanel,'Visible','off')
                drawnow
                rou.Casino.ChooseGame
            end
        end
        function PlayRoulette(rou)   % Start the process of playing roulette
            if rou.CurrentPlayer == 1
                rou.Wheel = RouletteWheel(rou);
                disp(rou.Wheel)
            end
            rou.Table = RouletteTable(rou);
            disp(rou.Table)
        end
        function value = get.NumberPlayers(rou)  % Method for determing NumberPlayers
            value = length(rou.Casino.CurrentPlayers);
        end
        function WinningValue(rou,winval) % Used for other classes to set the winning value
            rou.WinValue = winval;
        end
        function CurrentPlaying(rou)  % Used for other classes to change the CurrentPlayer index
            rou.CurrentPlayer = rou.CurrentPlayer + 1;
        end
    end
end