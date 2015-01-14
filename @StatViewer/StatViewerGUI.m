function StatViewerGUI(SV)
 Main=figure('Name','Stats Viewer',...
                'Toolbar','none',...
                'NumberTitle','off',...
                'DockControls','off');
            set(Main,'Position',[140 100 1000 600])
Int=uipanel('Parent',Main,...
    'Units','normalized',...
    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
    'Position',[.7 0 .3 1]);
SView=uipanel('Parent',Main,...
    'Units','normalized',...
    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
    'Position',[0 0 .7 1]);
TitleSV=uicontrol('Parent',SView,'Style','text',...
    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
    'String','Plot Viewer' ,...
    'Fontsize',30,'Units','normalized','Position',[.15 .93 .6 .07]);
SP=uicontrol('Parent',Int,'Style','text',...
    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
    'String','Select Players' ,...
    'Fontsize',14,'Units','normalized','Position',[.1 .95 .6 .05]);
plyrs=cell(size(SV.Casino.ActivePlayers,1),1); % make this +1 when we get house functionality.

for i = 1:length(SV.Casino.ActivePlayers)
    if i<=2
                plyrs{i} = uicontrol('Parent',Int,...
                    'Style','checkbox',...
                    'Units', 'normalized',...
                    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
                    'String', SV.Casino.ActivePlayers{i}.Name,...
                    'Position',[.22 .95-.05*i .3 .03]);
                %if i==(length(SV.Casino.ActivePlayers+1)
    elseif i>=3 || i<=4
        plyrs{i} = uicontrol('Parent',Int,...
                    'Style','checkbox',...
                    'Units', 'normalized',...
                    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
                    'String', SV.Casino.ActivePlayers{i}.Name,...
                    'Position',[.46 .95-.05*(i-2) .3 .03]);
    end
        
end
hou=uicontrol('Parent',Int,...
                    'Style','checkbox',...
                    'Units', 'normalized',...
                    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
                    'String', 'House',...
                    'Position',[.33 .81 .3 .03]);
dtit=uicontrol('Parent',Int,'Style','text',...
    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
    'String','Select Data Set' ,...
    'Fontsize',14,'Units','normalized','Position',[.1 .75 .6 .05]);
dset=uicontrol('Parent',Int,'Style','popupmenu','Units','normalized',...
    'String',['Overall' ;'Session'],'Position',[.18 .7 .5 .05]);

gtit=uicontrol('Parent',Int,'Style','text',...
    'Backgroundcolor', get(SV.Casino.Figure,'color'),...
    'String','Select Game' ,...
    'Fontsize',14,'Units','normalized','Position',[.1 .55 .6 .05]);
bgroup=uibuttongroup('Parent',Int,'Units','normalized',...
    'Backgroundcolor',get(SV.Casino.Figure,'color'),...
    'Position',[0 .45 1 .1]);
but1=uicontrol('Parent',bgroup,'Units','normalized','Style',...
    'togglebutton','String','All Games',...
    'Fontweight','bold','Position',[.025 .1 .2 .8]);
but2=uicontrol('Parent',bgroup,'Units','normalized','Style',...
    'togglebutton','String','BlackJack',...
    'Fontweight','bold','Position',[.275 .1 .2 .8]);
but3=uicontrol('Parent',bgroup,'Units','normalized','Style',...
    'togglebutton','String','Roulette',...
    'Fontweight','bold','Position',[.525 .1 .2 .8]);
but4=uicontrol('Parent',bgroup,'Units','normalized','Style',...
    'togglebutton','String','Slots',...
    'Fontweight','bold','Position',[.775 .1 .2 .8]);


genp=uicontrol('Parent',Int,'Units','normalized','Style','pushbutton',...
    'String','Generate Plot','Fontsize',14,'FontWeight','bold',...
    'Position',[.18 .27 .5 .08],'Callback',@Generate);
clearp=uicontrol('Parent',Int,'Units','normalized','Style','pushbutton',...
    'String','Clear Plot','Fontsize',14,'FontWeight','bold',...
    'Position',[.18 .12 .5 .08],'Callback',@ClearPlot);
% Proof of concept, by assigning properties as handles I can break up where
% I modify plots. 

defax=axes('Parent',SView,'xgrid','on','ygrid','on','GridLineStyle',':',...
    'Units','normalized','Position',[.1 .1 .8 .8],'Visible','on');
xlabel('Round','fontsize',12,'fontweight','b')
        ylabel('Net Gain/Loss in $$','fontsize',12,'fontweight','b')
    

%% 
% generate callback is pretty hefty, as it also has a lot of cases it has
% to consider to get the right output.
    function Generate(hobj,eventdata)
        
        ClearPlot();
        P={};
        for j=1:length(plyrs) %selected players, doesn't work when out of order-- make cell array of *correct* players
            if get(plyrs{j},'Value')==1
                P{end+1}=SV.Casino.ActivePlayers{j};
            end
            
        end
        
        if get(dset,'Value')==1 % Data set
            opt=1;
        else
            opt=0;
        end
        if get(hou,'Value')==1 % If house should be included in plots.
            hs=1;
        else 
            hs=0;
        end
        
        if get(but1,'Value')==1
            GAME='O';
        elseif get(but2,'Value')==1
            GAME='B';
        elseif get(but3,'Value')==1
            GAME='R';
           
        elseif get(but4,'Value')==1
            GAME='S';
        end
        GO=SV.CheckData(P,opt,GAME); % Making sure not plotting empty data sets
        
        if isempty(GO)
        set(defax,'Visible','off');
        
        if get(but1,'Value')==1 % generating desired plots
            SV.lineplot(P,opt,hs);
            H=gca;
            set(H,'Parent',SView,'Units','normalized','Position',[.1 .1 .8 .8]);
        set(H,'xgrid','on','ygrid','on','GridLineStyle',':')
        
            
        elseif get(but2,'Value')==1
            SV.plotBJ(P,opt,hs);
            H=gca;
            set(H,'Parent',SView,'Units','normalized','Position',[.1 .1 .8 .8]);
        set(H,'xgrid','on','ygrid','on','GridLineStyle',':')
            
        elseif get(but3,'Value')==1
            SV.plotrou(P,opt,hs);
            H=gca;
            set(H,'Parent',SView,'Units','normalized','Position',[.1 .1 .8 .8]);
        set(H,'xgrid','on','ygrid','on','GridLineStyle',':')
            
        else 
            SV.plotslo(P,opt,hs);
            H=gca;
            set(H,'Parent',SView,'Units','normalized','Position',[.1 .1 .8 .8]);
        set(H,'xgrid','on','ygrid','on','GridLineStyle',':')
            
        end
        if hs==1
            if get(but1,'Value')==1
            if length(P)==1
             
            
        legend(P{1}.Name,'Slots','Roulette','BlackJack','House','Location','NorthWest')
      
            elseif length(P)==2
            legend(P{1}.Name,P{2}.Name,'Slots','Roulette','BlackJack','House','Location','NorthWest')
            elseif length(P)==3
            legend(P{1}.Name,P{2}.Name,P{3}.Name,'Slots','Roulette','BlackJack','House','Location','NorthWest')
            elseif length(P)==4
            legend(P{1}.Name,P{2}.Name,P{3}.Name,P{4}.Name,'Slots','Roulette','BlackJack','House','Location','NorthWest')
            end
            else
            if length(P)==1
             
            
        legend(P{1}.Name,'House','Location','NorthWest')
      
            elseif length(P)==2
            legend(P{1}.Name,P{2}.Name,'House','Location','NorthWest')
            elseif length(P)==3
            legend(P{1}.Name,P{2}.Name,P{3}.Name,'House','Location','NorthWest')
            elseif length(P)==4
            legend(P{1}.Name,P{2}.Name,P{3}.Name,P{4}.Name,'House','Location','NorthWest')
            end    
                
            end
        else
            if get(but1,'Value')==1
            if length(P)==1
        legend(P{1}.Name,'Slots','Roulette','BlackJack','Location','NorthWest')
            elseif length(P)==2
            legend(P{1}.Name,P{2}.Name,'Slots','Roulette','BlackJack','Location','NorthWest')
            elseif length(P)==3
            legend(P{1}.Name,P{2}.Name,P{3}.Name,'Slots','Roulette','BlackJack','Location','NorthWest')
            elseif length(P)==4
            legend(P{1}.Name,P{2}.Name,P{3}.Name,P{4}.Name,'Slots','Roulette','BlackJack','Location','NorthWest')
            end
            else
               if length(P)==1
        legend(P{1}.Name,'Location','NorthWest')
            elseif length(P)==2
            legend(P{1}.Name,P{2}.Name,'Location','NorthWest')
            elseif length(P)==3
            legend(P{1}.Name,P{2}.Name,P{3}.Name,'Location','NorthWest')
            elseif length(P)==4
            legend(P{1}.Name,P{2}.Name,P{3}.Name,P{4}.Name,'Location','NorthWest')
            end  
            end
            
        end
        xlabel('Round','fontsize',12,'fontweight','b')
        ylabel('Net Gain/Loss in $$','fontsize',12,'fontweight','b')
       
        
        else
            opts={'Overall data for that game selection';'Session for that game selection'};
            errordlg([P{GO(1)}.Name ' has no ' opts{GO(2)}])
                
        end
        
        
        
        
    end
    function ClearPlot(hobj,eventdata)
        %cla
        y=gca;
        set(y,'Visible','off')
        cla
        legend(gca,'off')
        set(defax,'Visible','on')
        
    end
end

