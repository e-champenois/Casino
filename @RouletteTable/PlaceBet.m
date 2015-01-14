function PlaceBet(routable,num,evens,odds,col1,col2,doz1,doz2,doz3,top,bot,colm1,colm2,colm3)
% This method creates a uitable that allows the user to enter how much
% money they want to bet on each of their locations that they chose to bet
% on.

Betpanel = uipanel('Parent',routable.Roulette.Casino.Figure,... % the Bet panel
    'Units', 'normalized',...
    'Position',[.5 0 .5 1], ...
    'Backgroundcolor', get(routable.Roulette.Casino.Figure,'color'));
Betaxes = axes('Parent',Betpanel,...      % bet Axes for image
    'Visible','on',...
    'Units','normalized',...
    'Position',[0 0 1 1]);
imshow('rouBackground.jpeg','Parent',Betaxes)
LeaveButton = uicontrol('Parent',routable.Roulette.Wheel.WheelPanel,...% the Leave button
    'Style','pushbutton',...
    'String', 'Leave Roulette.',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.35 .03 .3 .05],...
    'Callback',@leave_callback);
DoneButton = uicontrol('Parent',Betpanel,...% the done button
    'Style','pushbutton',...
    'String', 'Done',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.55 .03 .3 .05],...
    'TooltipString','Finished Placing bets?',...
    'Callback',@done_callback);
ChangeButton = uicontrol('Parent',Betpanel,...% the change bets button
    'Style','pushbutton',...
    'String', 'Go Back',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.15 .03 .3 .05],...
    'Callback',@change_callback);
funds = routable.Roulette.Casino.CurrentPlayers{routable.Roulette.CurrentPlayer}.Funds;
fundss = num2str(funds);
sth1 = uicontrol('Parent',Betpanel,...
    'Style','text',...
    'Backgroundcolor',get(routable.Roulette.Casino.Figure,'color'),...
    'String',[routable.Roulette.Casino.CurrentPlayers{routable.Roulette.CurrentPlayer}.Name ' funds:  $' fundss],...
    'FontSize',15,...
    'Units','normalized',...
    'Position',[.2 .94 .6 .04]);
sth2 = uicontrol('Parent',Betpanel,...
    'Style','text',...
    'Backgroundcolor', get(routable.Roulette.Casino.Figure,'color'),...
    'String','How much would you like to bet?',...
    'FontSize',15,...
    'Units','normalized',...
    'Position',[.2 .84 .6 .07]);
numt = cell(1,1);
for i = 1:length(num)
    if ~isempty(num{i})
        numt = [numt num(i)];
    end
end
columnname = {'Bet'};
dat1 = [numt(2:end) col1 col2 evens odds doz1 doz2 doz3 top bot colm1 colm2 colm3 {'Total'}]';
dat2 = zeros(length(dat1),1);
columneditable =  [true];
columnformat = {'numeric'};
t = uitable('Parent',Betpanel,...
    'Units','normalized',...
    'Position',[0.2 0.1 0.6 0.7],...
    'Data', dat2,...
    'FontSize',15,...
    'ColumnName', columnname,...
    'ColumnFormat', columnformat,...
    'ColumnEditable', columneditable,...
    'RowName',dat1,...
    'CellEditCallback',@edit_callback);

    function leave_callback(hObject,eventdata)
        set(Betpanel,'Visible','off')
        set(routable.Roulette.Wheel.BackPanel,'Visible','off')
        set(routable.Roulette.Wheel.WheelPanel,'Visible','off')
        drawnow
        routable.Roulette.Casino.ChooseGame
    end
    function change_callback(hObject,eventdata)
        set(Betpanel,'Visible','off')
        set(LeaveButton,'Visible','off')
        drawnow
        disp(routable)
    end
    function edit_callback(hObject,eventdata)
        a = eventdata.NewData;
        b = get(t,'Data');
        d = true;
        if length(b) == eventdata.Indices(1)
            h = errordlg(['You can not change that value!'],'Error','modal');
        elseif isnan(a)
            h = errordlg(['You must place a numerical bet on all places!'],'Error','modal');
        elseif ~isreal(a)
            h = errordlg(['You must place a real bet on all places!'],'Error','modal');
        elseif isinf(a)
            h = errordlg(['You must place a finite bet on all places!'],'Error','modal');
        elseif a <= 0
            h = errordlg(['You must place a bet on all places!'],'Error','modal');
        else
            y = floor(a);
            z = a-y;
            w = num2str(z);
            l = length(w);
            if l > 1
                h = errordlg(['Lowest bet increment is one dollar!'],'Error','modal');
            else
                d = false;
            end
        end
        if d
            b(eventdata.Indices(1)) = eventdata.PreviousData;
            b(end) = sum(b(1:end-1));
            set(t,'Data',b)
        else
            b(end) = sum(b(1:end-1));
            set(t,'Data',b)
        end
    end



    function done_callback(hObject,eventdata)
        b = get(t,'Data');
        g = true;
        for j = 1:length(b(1:end-1))
            if b(j) == 0
                g = false;
                h = errordlg(['You must place a bet on all places!'],'Error','modal');
                break
            end
        end
        tot = sum(b(1:end-1));
        if g
            fund = routable.Roulette.Casino.CurrentPlayers{routable.Roulette.CurrentPlayer}.Funds;
            if tot > fund
                set(t,'Data',dat2)
                h = errordlg('You don''t have enough money for those bets!','Error','modal');
            elseif length(routable.Roulette.Casino.CurrentPlayers) == routable.Roulette.CurrentPlayer
                set(Betpanel,'Visible','off')
                set(LeaveButton,'Visible','off')
                routable.Roulette.Casino.CurrentPlayers{routable.Roulette.CurrentPlayer}.Bet = b(1:end-1);
                routable.Roulette.Casino.CurrentPlayers{routable.Roulette.CurrentPlayer}.Places = dat1(1:end-1);
                drawnow
                routable.Roulette.Wheel.Spin
            else
                set(Betpanel,'Visible','off')
                set(LeaveButton,'Visible','off')
                routable.Roulette.Casino.CurrentPlayers{routable.Roulette.CurrentPlayer}.Bet = b(1:end-1);
                routable.Roulette.Casino.CurrentPlayers{routable.Roulette.CurrentPlayer}.Places = dat1(1:end-1);
                routable.Roulette.CurrentPlaying
                drawnow
                disp(routable)
            end
        end
    end
end