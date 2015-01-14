function TableRules(routable)
% This method creates a new figure with the basic set of rules for the
% roulette table

fh = figure('Name','Table Rules',...  % the figure for the table rules to be displayed on
    'Toolbar','none',...
    'NumberTitle','off',...
    'DockControls','off');
set(fh,'Position',[400 313 529 353])
Rulespanel = uipanel('Parent',fh,... % the rules panel
    'Units','normalized',...
    'Position',[0 0 1 1], ...
    'Backgroundcolor',get(fh,'color'));
Rulesaxes = axes('Parent',Rulespanel,...      %rules Axes for the image
    'Visible','on',...
    'Units','normalized',...
    'Position',[0 0 1 1]);
imshow('visualBackground.jpeg','Parent',Rulesaxes)

sth = uicontrol('Parent',Rulespanel,...
    'Style','text',...
    'String','Table Rules for Roulette:',...
    'FontSize',15,...
    'Backgroundcolor', get(fh,'color'),...
    'Units','normalized',...
    'Position',[.1 .85 .8 .1]);
sth = uicontrol('Parent',Rulespanel,...
    'Style','text',...
    'String','(1) All individual number bets payout at 35 to 1.',...
    'FontSize',15,...
    'Backgroundcolor', get(fh,'color'),...
    'HorizontalAlignment','left',...
    'Units','normalized',...
    'Position',[.1 .75 .8 .1]);
sth = uicontrol('Parent',Rulespanel,...
    'Style','text',...
    'String','(2) Each of the column bets and each of the            dozen bets payout at 2 to 1.',...
    'FontSize',15,...
    'Backgroundcolor', get(fh,'color'),...
    'HorizontalAlignment','left',...
    'Units','normalized',...
    'Position',[.1 .6 .8 .15]);
sth = uicontrol('Parent',Rulespanel,...
    'Style','text',...
    'String','(3) Even, Odd, Red, Black, Top Half, and               Bottom Half bets each payout at 1 to 1.',...
    'FontSize',15,...
    'HorizontalAlignment','left',...
    'Backgroundcolor', get(fh,'color'),...
    'Units','normalized',...
    'Position',[.1 .45 .8 .15]);
sth = uicontrol('Parent',Rulespanel,...
    'Style','text',...
    'String','(4) Lowest bet allowed is one dollar.',...
    'FontSize',15,...
    'Backgroundcolor', get(fh,'color'),...
    'HorizontalAlignment','left',...
    'Units','normalized',...
    'Position',[.1 .35 .8 .1]);
ResumeButton = uicontrol('Parent',Rulespanel,...% the resume button
    'Style','pushbutton',...
    'String', 'Resume Game',...
    'FontSize',15,...
    'Units', 'normalized',...
    'Position',[.3 .15 .4 .15],...
    'TooltipString','Continue Playing?',...
    'Callback',@resume_callback);
    function resume_callback(hObject,eventdata)
        close(fh)
    end
end