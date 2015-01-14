classdef RouletteWheel < handle
    % This class creates the roulette wheel which will be displayed on a
    % figure for the user to see and then it is spun for the user to see
    % the roulette wheel's winning value.
    
    properties
        Roulette  % Roulette class object
        WheelPanel = [];  % panel that the wheel is on
        WheelAxes  % the axes that the pie graph, representing the wheel, is graphed on
        BackPanel = [];  % the panel that is the background for the right side of the figure 
    end
    
    methods
        function obj = RouletteWheel(rou)
            obj.Roulette = rou;
        end
        function disp(rouwheel)  % displays the roulette wheel on the left side of the figure and the back panel on the right 
            wtemp = [];
            btemp = [];
            if ~isempty(rouwheel.WheelPanel)
                wtemp = rouwheel.WheelPanel;
            end
            if ~isempty(rouwheel.BackPanel)
                btemp = rouwheel.BackPanel;
            end
            Wheelpanel = uipanel('Parent',rouwheel.Roulette.Casino.Figure,... % the wheel panel
                'Units', 'normalized',...
                'Position',[0 0 .5 1], ...
                'Backgroundcolor', get(rouwheel.Roulette.Casino.Figure,'color'));
            WheelAxes2 = axes('Parent',Wheelpanel,...      %wheel2 Axes for image
                              'Visible','on',...
                              'Units','normalized',...
                              'Position',[0 0 1 1]);
            imshow('rouBackground.jpeg','Parent',WheelAxes2)
            Backpanel = uipanel('Parent',rouwheel.Roulette.Casino.Figure,... % the wheel panel
                'Units', 'normalized',...
                'Position',[.5 0 .5 1], ...
                'Backgroundcolor', get(rouwheel.Roulette.Casino.Figure,'color'));
            Backaxes = axes('Parent',Backpanel,...      % backAxes for the image
                              'Visible','on',...
                              'Units','normalized',...
                              'Position',[0 0 1 1]);
            imshow('rouBackground.jpeg','Parent',Backaxes)
            rouwheel.BackPanel = Backpanel;
            rouwheel.WheelPanel = Wheelpanel;
            Wheelaxes = axes('Parent',Wheelpanel);% the axes for the wheel display
            rouwheel.WheelAxes = Wheelaxes;
            nums = {'0' '28' '9' '26' '30' '11' '7' '20' '32' '17' '5' '22' '34'...
                '15' '3' '24' '36' '13' '1' '00' '27' '10' '25' '29' '12' '8' ...
                '19' '31' '18' '6' '21' '33' '16' '4' '23' '35' '14' '2'};
            pp = pie(Wheelaxes,ones(1,38),nums);
            set(pp(2:2:76),'FontSize',15,'Color','w')
            title(Wheelaxes,'Roulette Wheel','FontSize',15,'Color','w')
            load ('Mycolormap','roucolor')
            colormap(Wheelaxes,roucolor)
            if ~isempty(wtemp)
                set(wtemp,'Visible','off')
            end
            if ~isempty(btemp)
                set(btemp,'Visible','off')
            end
        end
        
    end
end
    
