classdef StatViewer < handle
   % Raw data compiled in Stats object. It is exported to the statviewer
   % class to be combined into the desired plots. These plots are then
   % exported to the gui and their presentation (titles, labels, etc) are
   % modified there.
    
    properties
     Casino   
    end
    
    methods
        function out= StatViewer(Casino)
            out.Casino=Casino;
            for i=1:size(Casino.ActivePlayers,2) % generates up to date stats object everytime the viewer is opened.
                out.Casino.ActivePlayers{i}.Statobj;
            end
            
            
            out.StatViewerGUI();
            
        end
%% 
%All the different plots have a lot of different cases, with the lineplot
%method being the most hefty. The GUI and house methods are organized
%seperately in the @StatViewer folder.

function plotslo(SV,P,opt,H)
            AXHAND=axes();
%             
            if opt==0
                if length(P)==1
                plot(1:length(P{1}.Stats.SSlo),P{1}.Stats.SSlo,'LineWidth',2,'color','b','Parent',AXHAND);
                
                elseif length(P)==2
                    length(P)
                plot(1:length(P{1}.Stats.SSlo),P{1}.Stats.SSlo,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SSlo),P{2}.Stats.SSlo,'LineWidth',2,'color','r','Parent',AXHAND);
                hold off
                
                elseif length(P)==3
                plot(1:length(P{1}.Stats.SSlo),P{1}.Stats.SSlo,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SSlo),P{2}.Stats.SSlo,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.SSlo),P{3}.Stats.SSlo,'LineWidth',2,'color','g','Parent',AXHAND);
                hold off
                
                elseif length(P)==4
                    plot(1:length(P{1}.Stats.SSlo),P{1}.Stats.SSlo,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SSlo),P{2}.Stats.SSlo,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.SSlo),P{3}.Stats.SSlo,'LineWidth',2,'color','g','Parent',AXHAND);
                hold on
                plot(1:length(P{4}.Stats.SSlo),P{4}.Stats.SSlo,'LineWidth',2,'color','bl','Parent',AXHAND);
                hold off
                end
                
                    
                
            end
            if opt==1
                if length(P)==1
                plot(1:length(P{1}.Stats.Slo),P{1}.Stats.Slo,'LineWidth',2,'color','b','Parent',AXHAND);
                
                elseif length(P)==2
                plot(1:length(P{1}.Stats.Slo),P{1}.Stats.Slo,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.Slo),P{2}.Stats.Slo,'LineWidth',2,'color','r','Parent',AXHAND);
                hold off
                
                elseif length(P)==3
                plot(1:length(P{1}.Stats.Slo),P{1}.Stats.Slo,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.Slo),P{2}.Stats.Slo,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.Slo),P{3}.Stats.Slo,'LineWidth',2,'color','g','Parent',AXHAND);
                hold off
                
                elseif length(P)==4
                    plot(1:length(P{1}.Stats.Slo),P{1}.Stats.Slo,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.Slo),P{2}.Stats.Slo,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.Slo),P{3}.Stats.Slo,'LineWidth',2,'color','g','Parent',AXHAND);
                hold on
                plot(1:length(P{4}.Stats.Slo),P{4}.Stats.Slo,'LineWidth',2,'color','k','Parent',AXHAND);
                hold off
                end
                
            end
            if H==1
                
                hold on
                    [O,S,R,B]=SV.House(P,opt);
                    plot(1:length(S),S,'color','m','LineWidth',3,'Parent',AXHAND)
                    hold off
            end
                
end
function plotrou(SV,P,opt,H)
       AXHAND=axes();
           
            if opt==0
                if length(P)==1
                plot(1:length(P{1}.Stats.SRou),P{1}.Stats.SRou,'LineWidth',2,'color','b','Parent',AXHAND);
                
                elseif length(P)==2
                    length(P)
                plot(1:length(P{1}.Stats.SRou),P{1}.Stats.SRou,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SRou),P{2}.Stats.SRou,'LineWidth',2,'color','r','Parent',AXHAND);
                hold off
                
                elseif length(P)==3
                plot(1:length(P{1}.Stats.SRou),P{1}.Stats.SRou,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SRou),P{2}.Stats.SRou,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.SRou),P{3}.Stats.SRou,'LineWidth',2,'color','g','Parent',AXHAND);
                hold off
                
                elseif length(P)==4
                    plot(1:length(P{1}.Stats.SRou),P{1}.Stats.SRou,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SRou),P{2}.Stats.SRou,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.SRou),P{3}.Stats.SRou,'LineWidth',2,'color','g','Parent',AXHAND);
                hold on
                plot(1:length(P{4}.Stats.SRou),P{4}.Stats.SRou,'LineWidth',2,'color','k','Parent',AXHAND);
                hold off
                end
                
            end
            if opt==1
                if length(P)==1
                plot(1:length(P{1}.Stats.Rou),P{1}.Stats.Rou,'LineWidth',2,'color','b','Parent',AXHAND);
                
                elseif length(P)==2
                plot(1:length(P{1}.Stats.Rou),P{1}.Stats.Rou,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.Rou),P{2}.Stats.Rou,'LineWidth',2,'color','r','Parent',AXHAND);
                hold off
                
                elseif length(P)==3
                plot(1:length(P{1}.Stats.Rou),P{1}.Stats.Rou,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.Rou),P{2}.Stats.Rou,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.Rou),P{3}.Stats.Rou,'LineWidth',2,'color','g','Parent',AXHAND);
                hold off
                
                elseif length(P)==4
                    plot(1:length(P{1}.Stats.Rou),P{1}.Stats.Rou,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.Rou),P{2}.Stats.Rou,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.Rou),P{3}.Stats.Rou,'LineWidth',2,'color','g','Parent',AXHAND);
                hold on
                plot(1:length(P{4}.Stats.Rou),P{4}.Stats.Rou,'LineWidth',2,'color','k','Parent',AXHAND);
                hold off
                end
                
            end
            if H==1
                
                hold on
                    [O,S,R,B]=SV.House(P,opt);
                    plot(1:length(R),R,'color','m','LineWidth',3,'Parent',AXHAND)
                    hold off
            end
                
end
        function plotBJ(SV,P,opt,H)
       AXHAND=axes();
            if opt==0
                if length(P)==1
                plot(1:length(P{1}.Stats.SBJ),P{1}.Stats.SBJ,'LineWidth',2,'color','b','Parent',AXHAND);
                
                elseif length(P)==2
                    length(P)
                plot(1:length(P{1}.Stats.SBJ),P{1}.Stats.SBJ,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SBJ),P{2}.Stats.SBJ,'LineWidth',2,'color','r','Parent',AXHAND);
                hold off
                
                elseif length(P)==3
                plot(1:length(P{1}.Stats.SBJ),P{1}.Stats.SBJ,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SBJ),P{2}.Stats.SBJ,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.SBJ),P{3}.Stats.SBJ,'LineWidth',2,'color','g','Parent',AXHAND);
                hold off
                
                elseif length(P)==4
                    plot(1:length(P{1}.Stats.SBJ),P{1}.Stats.SBJ,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.SBJ),P{2}.Stats.SBJ,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.SBJ),P{3}.Stats.SBJ,'LineWidth',2,'color','g','Parent',AXHAND);
                hold on
                plot(1:length(P{4}.Stats.SBJ),P{4}.Stats.SBJ,'LineWidth',2,'color','k','Parent',AXHAND);
                hold off
                end
                
            end
            if opt==1
                if length(P)==1
                plot(1:length(P{1}.Stats.BJ),P{1}.Stats.BJ,'LineWidth',2,'color','b','Parent',AXHAND);
                
                elseif length(P)==2
                plot(1:length(P{1}.Stats.BJ),P{1}.Stats.BJ,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.BJ),P{2}.Stats.BJ,'LineWidth',2,'color','r','Parent',AXHAND);
                hold off
                
                elseif length(P)==3
                plot(1:length(P{1}.Stats.BJ),P{1}.Stats.BJ,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.BJ),P{2}.Stats.BJ,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.BJ),P{3}.Stats.BJ,'LineWidth',2,'color','g','Parent',AXHAND);
                hold off
                
                elseif length(P)==4
                    plot(1:length(P{1}.Stats.BJ),P{1}.Stats.BJ,'LineWidth',2,'color','b','Parent',AXHAND)
                hold on
                plot(1:length(P{2}.Stats.BJ),P{2}.Stats.BJ,'LineWidth',2,'color','r','Parent',AXHAND);
                hold on
                plot(1:length(P{3}.Stats.BJ),P{3}.Stats.BJ,'LineWidth',2,'color','g','Parent',AXHAND);
                hold on
                plot(1:length(P{4}.Stats.BJ),P{4}.Stats.BJ,'LineWidth',2,'color','k','Parent',AXHAND);
                hold off
                end
                
            end
            if H==1
                
                hold on
                    [O,S,R,B]=SV.House(P,opt);
                    plot(1:length(B),B,'color','m','LineWidth',3,'Parent',AXHAND)
                    hold off
            end    
        end
        function out= lineplot(SV,P,opt,H) % this is the multi colored plot where the line color correlates with the game of the next point.
            AXHAND=axes();
            h1=hggroup;
            h2=hggroup;
            h3=hggroup;
            h4=hggroup;
            h5=hggroup;
            h6=hggroup;
            h7=hggroup;
            h8=hggroup;
            set(h1,'Parent',AXHAND)
            set(h2,'Parent',AXHAND)
            set(h3,'Parent',AXHAND)
            set(h4,'Parent',AXHAND)
            set(h5,'Parent',AXHAND)
            set(h6,'Parent',AXHAND)
            set(h7,'Parent',AXHAND)
            set(h8,'Parent',AXHAND)
            set(get(get(h1,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')
set(get(get(h2,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')
set(get(get(h3,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')
set(get(get(h4,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')
set(get(get(h5,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')
set(get(get(h6,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')
set(get(get(h7,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')
set(get(get(h8,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on')

            if opt==1
                if length(P)==1 % 1 player
                L1=size(P{1}.Stats.Data,1);
                H1=cell(L1,1);
                
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.Cumul(k) P{1}.Stats.Cumul(k+1)]);
                    if strcmp(P{1}.Stats.Data{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    end
                    
                    
                end
                elseif length(P)==2 % 2 player
                    
                L1=size(P{1}.Stats.Data,1);
                L2=size(P{2}.Stats.Data,1);
                H1=cell(L1,1);
                H2=cell(L2,1);
                
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.Cumul(k) P{1}.Stats.Cumul(k+1)]);
                    if strcmp(P{1}.Stats.Data{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    end
                    
                end
                hold on
                for p=1:L2
                    H2{p}=line([p p+1],[P{2}.Stats.Cumul(p) P{2}.Stats.Cumul(p+1)]);
                    if strcmp(P{2}.Stats.Data{p,2},'S')
                        set(H2{p},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.Data{p,2},'R')
                        set(H2{p},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.Data{p,2},'B')
                        set(H2{p},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    end
                end
                hold off
                
                elseif length(P)==3 % 3 player
                   
                L1=size(P{1}.Stats.Data,1);
                L2=size(P{2}.Stats.Data,1);
                L3=size(P{3}.Stats.Data,1);
                H1=cell(L1,1);
                H2=cell(L2,1);
                H3=cell(L3,1);
                
                
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.Cumul(k) P{1}.Stats.Cumul(k+1)]);
                    if strcmp(P{1}.Stats.Data{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','MarkerFaceColor','b','LineWidth',2,'Parent',h1)
                    end
                    
                end
                hold on
                for p=1:L2
                    H2{p}=line([p p+1],[P{2}.Stats.Cumul(p) P{2}.Stats.Cumul(p+1)]);
                    if strcmp(P{2}.Stats.Data{p,2},'S')
                        set(H2{p},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.Data{p,2},'R')
                        set(H2{p},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.Data{p,2},'B')
                        set(H2{p},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    end
                end
                hold on
                for l=1:L3
                    H3{l}=line([l l+1],[P{3}.Stats.Cumul(l) P{3}.Stats.Cumul(l+1)]);
                    if strcmp(P{3}.Stats.Data{l,2},'S')
                        set(H3{l},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.Data{l,2},'R')
                        set(H3{l},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.Data{l,2},'B')
                        set(H3{l},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    end
                    
                end
                hold off
                
                elseif length(P)==4 % 4 player
                L1=size(P{1}.Stats.Data,1);
                L2=size(P{2}.Stats.Data,1);
                L3=size(P{3}.Stats.Data,1);
                L4=size(P{4}.Stats.Data,1);
                H1=cell(L1,1);
                H2=cell(L2,1);
                H3=cell(L3,1);
                H4=cell(L4,1);
                
                
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.Cumul(k) P{1}.Stats.Cumul(k+1)]);
                    if strcmp(P{1}.Stats.Data{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.Data{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    end
                    
                end
                hold on
                for p=1:L2
                    H2{p}=line([p p+1],[P{2}.Stats.Cumul(p) P{2}.Stats.Cumul(p+1)]);
                    if strcmp(P{2}.Stats.Data{p,2},'S')
                        set(H2{p},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.Data{p,2},'R')
                        set(H2{p},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.Data{p,2},'B')
                        set(H2{p},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    end
                end
                hold on
                for l=1:L3
                    H3{l}=line([l l+1],[P{3}.Stats.Cumul(l) P{3}.Stats.Cumul(l+1)]);
                    if strcmp(P{3}.Stats.Data{l,2},'S')
                        set(H3{l},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.Data{l,2},'R')
                        set(H3{l},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.Data{l,2},'B')
                        set(H3{l},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    end
                    
                end
                hold on
                
                for q=1:L4
                    H4{q}=line([q q+1],[P{4}.Stats.Cumul(q) P{4}.Stats.Cumul(q+1)]);
                    if strcmp(P{4}.Stats.Data{q,2},'S')
                        set(H4{q},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','k','Parent',h4)
                    elseif strcmp(P{4}.Stats.Data{q,2},'R')
                        set(H4{q},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','k','Parent',h4)
                    elseif strcmp(P{4}.Stats.Data{q,2},'B')
                        set(H4{q},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','k','Parent',h4)
                    end
                    
                end
                hold off
                end
                
                       
                    
            end
            if opt==0
                if length(P)==1 % 1 player
                L1=size(P{1}.Stats.SData,1);
                H1=cell(L1,1);
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.SCumul(k) P{1}.Stats.SCumul(k+1)]);
                    if strcmp(P{1}.Stats.SData{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    end
                    
                end
                elseif length(P)==2 % 2 player
                    
                L1=size(P{1}.Stats.SData,1);
                L2=size(P{2}.Stats.SData,1);
                H1=cell(L1,1);
                H2=cell(L2,1);
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.SCumul(k) P{1}.Stats.SCumul(k+1)]);
                    if strcmp(P{1}.Stats.SData{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    end
                    
                end
                hold on
                for p=1:L2
                    H2{p}=line([p p+1],[P{2}.Stats.SCumul(p) P{2}.Stats.SCumul(p+1)]);
                    if strcmp(P{2}.Stats.SData{p,2},'S')
                        set(H2{p},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.SData{p,2},'R')
                        set(H2{p},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.SData{p,2},'B')
                        set(H2{p},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    end
                end
                hold off
                elseif length(P)==3 % 3 player
                   
                L1=size(P{1}.Stats.SData,1);
                L2=size(P{2}.Stats.SData,1);
                L3=size(P{3}.Stats.SData,1);
                H1=cell(L1,1);
                H2=cell(L2,1);
                H3=cell(L3,1);
                
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.SCumul(k) P{1}.Stats.SCumul(k+1)]);
                    if strcmp(P{1}.Stats.SData{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    end
                    
                end
                hold on
                for p=1:L2
                    H2{p}=line([p p+1],[P{2}.Stats.SCumul(p) P{2}.Stats.SCumul(p+1)]);
                    if strcmp(P{2}.Stats.SData{p,2},'S')
                        set(H2{p},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.SData{p,2},'R')
                        set(H2{p},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.SData{p,2},'B')
                        set(H2{p},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    end
                end
                hold on
                for l=1:L3
                    H3{l}=line([l l+1],[P{3}.Stats.SCumul(l) P{3}.Stats.SCumul(l+1)]);
                    if strcmp(P{3}.Stats.SData{l,2},'S')
                        set(H3{l},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.SData{l,2},'R')
                        set(H3{l},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.SData{l,2},'B')
                        set(H3{l},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    end
                    
                end
                hold off
                elseif length(P)==4 % 4 player
                L1=size(P{1}.Stats.SData,1);
                L2=size(P{2}.Stats.SData,1);
                L3=size(P{3}.Stats.SData,1);
                L4=size(P{4}.Stats.SData,1);
                H1=cell(L1,1);
                H2=cell(L2,1);
                H3=cell(L3,1);
                H4=cell(L4,1);
                
                
                for k=1:L1
                    H1{k}=line([k k+1],[P{1}.Stats.SCumul(k) P{1}.Stats.SCumul(k+1)]);
                    if strcmp(P{1}.Stats.SData{k,2},'S')
                        set(H1{k},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'R')
                        set(H1{k},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    elseif strcmp(P{1}.Stats.SData{k,2},'B')
                        set(H1{k},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','b','Parent',h1)
                    end
                    
                end
                hold on
                for p=1:L2
                    H2{p}=line([p p+1],[P{2}.Stats.SCumul(p) P{2}.Stats.SCumul(p+1)]);
                    if strcmp(P{2}.Stats.SData{p,2},'S')
                        set(H2{p},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.SData{p,2},'R')
                        set(H2{p},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    elseif strcmp(P{2}.Stats.SData{p,2},'B')
                        set(H2{p},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','r','Parent',h2)
                    end
                end
                hold on
                for l=1:L3
                    H3{l}=line([l l+1],[P{3}.Stats.SCumul(l) P{3}.Stats.SCumul(l+1)]);
                    if strcmp(P{3}.Stats.SData{l,2},'S')
                        set(H3{l},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.SData{l,2},'R')
                        set(H3{l},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    elseif strcmp(P{3}.Stats.SData{l,2},'B')
                        set(H3{l},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','g','Parent',h3)
                    end
                    
                end
                hold on
                
                for q=1:L4
                    H4{q}=line([q q+1],[P{4}.Stats.SCumul(q) P{4}.Stats.SCumul(q+1)]);
                    if strcmp(P{4}.Stats.SData{q,2},'S')
                        set(H4{q},'color','blue','Marker','o','Markersize',9,'MarkerEdgeColor','b','LineWidth',2,'MarkerFaceColor','k','Parent',h4)
                    elseif strcmp(P{4}.Stats.SData{q,2},'R')
                        set(H4{q},'color','red','Marker','o','Markersize',9,'MarkerEdgeColor','r','LineWidth',2,'MarkerFaceColor','k','Parent',h4)
                    elseif strcmp(P{4}.Stats.SData{q,2},'B')
                        set(H4{q},'color','green','Marker','o','Markersize',9,'MarkerEdgeColor','g','LineWidth',2,'MarkerFaceColor','k','Parent',h4)
                    end
                    
                end
                hold off
                end

                       
                    
            end
            hold on
            H5=line(1,1,'Parent',h5,'color','b','Visible','off');
            H6=line(1,1,'Parent',h6,'color','r','Visible','off');
            H7=line(1,1,'Parent',h7,'color','g','Visible','off');
            if H==1
                
                hold on
                    [O,S,R,B]=SV.House(P,opt);
                    plot(1:length(O),O,'color','m','LineWidth',3,'Parent',h8)
                    hold off
            end
            out=AXHAND;
            
        end
    end
        

end
    


