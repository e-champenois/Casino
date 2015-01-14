function out =CheckData(SV,Players,opt,Game)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if opt==1
    if strcmp(Game,'S')
        for i=1:length(Players)
        if length(Players{i}.Stats.Slo)==1
            out=[i 1];
            return
        else
            out=[];
        end
        
    end
    elseif strcmp(Game,'R')
        for i=1:length(Players)
        if length(Players{i}.Stats.Rou)==1
            out=[i 1];
            return
        else
            out=[];
        end
        
    end
    elseif strcmp(Game,'B')
        for i=1:length(Players)
        if length(Players{i}.Stats.BJ)==1
            out=[i 1];
            return
        else
            out=[];
        end
        
    end
    else
    for i=1:length(Players)
        if isempty(Players{i}.Stats.Data)
            out=[i 1];
            return
        else
            out=[];
        end
        
    end
    end
else
    if strcmp(Game,'S')
        for i=1:length(Players)
        if length(Players{i}.Stats.SSlo)==1
            out=[i 2];
            return
        else
            out=[];
        end
        
    end
    elseif strcmp(Game,'R')
        for i=1:length(Players)
        if length(Players{i}.Stats.SRou)==1
            out=[i 2];
            return
        else
            out=[];
        end
        
    end
    elseif strcmp(Game,'B')
        for i=1:length(Players)
        if length(Players{i}.Stats.SBJ)==1
            out=[i 2];
            return
        else
            out=[];
        end
        
    end
    else
    for i=1:length(Players)
        if isempty(Players{i}.Stats.SData)
            out=[i 2];
            return
        else
            out=[];
        end
        
    end
    end
    

end

