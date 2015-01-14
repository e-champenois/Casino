classdef Stats < handle 
    %Only create the stat object when ready to review stats, i.e. call to
    %stat interface. Create it using the function Statobj in player class.
    
    properties
        Player
        Data %Raw overall data
        SData %raw session data
        Cumul %the accumulation of wealth overall
        SCumul %accumulation over the session, rest are broken down by the game
        BJ
        SBJ
        Rou
        SRou
        Slo
        SSlo
    end
 
    
    methods
        function out = Stats(Player) 
            
            out.Player=Player;
                       
            out.Data=Player.Results;
            out.SData=Player.SResults;
            out.Sort; 
            
        end
        
        function Sort(Stats)
            
            Stats.Slo(end+1)=0;
            Stats.BJ(end+1)=0;
            Stats.Rou(end+1)=0;
            Stats.SSlo(end+1)=0;
            Stats.SBJ(end+1)=0;
            Stats.SRou(end+1)=0;
            
            for i=1:size(Stats.Data,1)
                
                if strcmp(Stats.Data{i,2},'S')
                    Stats.Slo(end+1)=Stats.Slo(end)+Stats.Data{i,1};
                elseif strcmp(Stats.Data{i,2},'B')
                    Stats.BJ(end+1)=Stats.BJ(end)+Stats.Data{i,1};
                elseif strcmp(Stats.Data{i,2},'R')
                    Stats.Rou(end+1)=Stats.Rou(end)+Stats.Data{i,1};
                end
                
            end
            %H=[];
            for j=1:size(Stats.Data,1)
                Stats.Cumul(1)=0;
                Stats.Cumul(end+1)=Stats.Cumul(end)+Stats.Data{j,1};
                
            end
            
            for k=1:size(Stats.SData,1)
                if strcmp(Stats.SData{k,2},'S')
                    Stats.SSlo(end+1)=Stats.SSlo(end)+Stats.SData{k,1};
                elseif strcmp(Stats.SData{k,2},'B')
                    Stats.SBJ(end+1)=Stats.SBJ(end)+Stats.SData{k,1};
                elseif strcmp(Stats.SData{k,2},'R')
                    Stats.SRou(end+1)=Stats.SRou(end)+Stats.SData{k,1};
                end
                
            end
            %G=[];
            for l=1:size(Stats.SData,1)
                Stats.SCumul(1)=0;
                Stats.SCumul(end+1)=Stats.SCumul(end)+Stats.SData{l,1};
                
            end
           % Stats.SCumul=G;
        end
        
        
        
        
       
    end
        
            
end
    


