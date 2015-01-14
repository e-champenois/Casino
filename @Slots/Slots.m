classdef Slots < handle
    % Slots class pretty compartmentalized. The interface gui, payout, and
    % pull methods are kept seperately in the @Slots folder to avoid
    % clutter in the main class file.
    
    properties
        Casino
        Result
        Pay
    end
    
    methods
        function out= Slots(casino) 
            out.Casino=casino;
            out.SlotChoosePlayer
        end
        function SlotChoosePlayer(slotobj)
            slotobj.Casino.Playerslist
            Playerpanel = uipanel('Parent',slotobj.Casino.Figure,...
                'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
                'Units','normalized',...
                'Position',[0 0 .65 1]);
            ST=uicontrol('Parent',Playerpanel,...
                'Style','text',...
                'FontSize',14,...
                'FontWeight','bold',...
                'String','Who will be playing Slots?',...
                'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
                'Units','normalized',...
                'Position',[0 .85 1 .1]);
            bgroup=uibuttongroup('Parent',Playerpanel,'Title','Choose Player',...
                'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
                'Fontsize',14,'Fontweight','bold','Position',[.35 .4 .4 .4]);
            
            for i = 1:length(slotobj.Casino.ActivePlayers)
                Playerbutton{i} = uicontrol('Parent',bgroup,...
                    'Style','Radiobutton',...
                    'Units', 'normalized',...
                    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
                    'String', slotobj.Casino.ActivePlayers{i}.Name,...
                    'Fontsize',14,'Position',[.1 .9-.2*i .7 .1]);
            end
            Play=uicontrol('Parent',Playerpanel,'Style','pushbutton',...
                'String','Play Slots',...
                'Units','normalized','Fontsize',14,'Position',[.1 .1 .4 .1],...
            'Callback',@PlayCB);
        Leave=uicontrol('Parent',Playerpanel,'Style','pushbutton',...
            'String','Return','Units','normalized',...
            'Position',[.55 .1 .4 .1],'Fontsize',14,'Callback',@ReturnCB);
        
        function PlayCB(obj,eventdata)
            for k=1:length(Playerbutton)
                if get(Playerbutton{k},'Value')==1
                    slotobj.Casino.CurrentPlayers{1}=slotobj.Casino.ActivePlayers{k};
                    break
                end
                
            end
            set(Playerpanel,'Visible','off')
            set(slotobj.Casino.Listpanel,'Visible','off')
            slotobj.SlotsInterface();
           
           
        end
        function ReturnCB(obj,eventdata)
            set(Playerpanel,'Visible','off')
            set(slotobj.Casino.Listpanel,'Visible','off')
            slotobj.Casino.ChooseGame
        end
        end
        
        
        
        
        
         
            
        
        
    end
    
end

