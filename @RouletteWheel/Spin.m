function Spin(rouwheel)
% This method determines the winning value for this particular spin and
% then spins the roulette wheel so that the ball lands on the winning value
% determined earlier.

Showpanel = uipanel('Parent',rouwheel.Roulette.Casino.Figure,... % the show panel
    'Units', 'normalized',...
    'Position',[.5 0 .5 1], ...
    'Backgroundcolor', get(rouwheel.Roulette.Casino.Figure,'color'));
Showaxes = axes('Parent',Showpanel,...      %show Axes for image
    'Visible','on',...
    'Units','normalized',...
    'Position',[0 0 1 1]);
imshow('rouBackground.jpeg','Parent',Showaxes)
t = cell(1,length(rouwheel.Roulette.Casino.CurrentPlayers));
for i = 1:length(rouwheel.Roulette.Casino.CurrentPlayers)
    columnname = {'Bet'};
    dat1 = rouwheel.Roulette.Casino.CurrentPlayers{i}.Places;
    dat2 = rouwheel.Roulette.Casino.CurrentPlayers{i}.Bet;
    columneditable =  [false];
    columnformat = {'numeric'};
    t{i} = uitable('Parent',Showpanel,...  %The table of bets for player i
        'Units','normalized',...
        'Position',[.03 1.03-.25*i .58 .17],...
        'Data', [dat2; sum(dat2)],...
        'FontSize',15,...
        'ColumnName', columnname,...
        'ColumnFormat', columnformat,...
        'ColumnEditable', columneditable,...
        'RowName',[dat1; {'Total'}]);
    uicontrol('Parent',Showpanel,...   % The name of player i
        'Backgroundcolor', get(rouwheel.Roulette.Casino.Figure,'color'),...
        'Style','text',...
        'String',[rouwheel.Roulette.Casino.CurrentPlayers{i}.Name],...
        'FontSize',15,...
        'Units','normalized',...
        'Position',[.03 1.2-.25*i .5 .05]);
end
num = {'red 18' 'black 6' 'red 21' 'black 33' 'red 16' 'black 4' 'red 23'...
    'black 35' 'red 14' 'black 2' 'green 0' 'black 28' 'red 9' 'black 26'...
    'red 30' 'black 11' 'red 7' 'black 20' 'red 32' 'black 17' 'red 5'...
    'black 22' 'red 34' 'black 15' 'red 3' 'black 24' 'red 36' 'black 13'...
    'red 1' 'green 00' 'red 27' 'black 10' 'red 25' 'black 29' 'red 12' ...
    'black 8' 'red 19' 'black 31'};
num2 = {'18' '6' '21' '33' '16' '4' '23' '35' '14' '2' '0' '28' '9' '26'...
    '30' '11' '7' '20' '32' '17' '5' '22' '34' '15' '3' '24' '36' '13' '1'...
    '00' '27' '10' '25' '29' '12' '8' '19' '31'};
wininds = randperm(length(num));
n = wininds(1);   % winning value
winnum = num(wininds(1));
winnum2 = num2(wininds(1));
j = ceil(2*rand(1,1))+1;
nums = {'0' '28' '9' '26' '30' '11' '7' '20' '32' '17' '5' '22' '34' '15'...
    '3' '24' '36' '13' '1' '00' '27' '10' '25' '29' '12' '8' '19' '31'...
    '18' '6' '21' '33' '16' '4' '23' '35' '14' '2'};
rouwheel.disp
hold on
h = compass(rouwheel.WheelAxes,0,0);
set(h,'Marker','.')
set(h,'MarkerSize',45)
set(h,'Color',[0.4722 0.5295 0.5972])
for i = 0:9.4737:(n*9.4737+360*j)  %spinning the roulette wheel
    set(h,'XData',[.9*cosd(i)],'YData',[.9*sind(i)])
    pause(.001)
    drawnow
end
hold off
uicontrol('Parent',rouwheel.WheelPanel,...
    'Backgroundcolor',get(rouwheel.Roulette.Casino.Figure,'color'),...
    'Style','text',...
    'String',['Winning number is ',winnum{1},'!'],...
    'FontSize',15,...
    'Units','normalized',...
    'Position',[.3 .92 .4 .07]);
drawnow
rouwheel.Roulette.WinningValue(winnum2(1))
rouwheel.Roulette.CheckWin(Showpanel,t)
LeaveButton = uicontrol('Parent',rouwheel.WheelPanel,...% the Leave button
    'Style','pushbutton',...
    'String', 'Leave Roulette.',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.35 .03 .3 .05],...
    'Callback',@leave_callback);
    function leave_callback(hObject,eventdata)
        set(Showpanel,'Visible','off')
        set(rouwheel.WheelPanel,'Visible','off')
        set(rouwheel.BackPanel,'Visible','off')
        drawnow
        rouwheel.Roulette.Casino.ChooseGame
    end
end