function SlotsInterface(slotobj)
% images
drawnow
BL=imread('blank.jpg');
CH=imread('cherry.jpg');
OR=imread('orange.jpg');
GR=imread('grape.jpg');
BE=imread('bell.jpg');
BA=imread('bar.jpg');
SE=imread('seven.jpg');
list={BL CH OR GR BE BA SE};
res={'blank' 'cherry' 'orange' 'grape' 'bell' 'bar' 'seven'};

%All the controls, panels, and axes
Int=uipanel('Parent',slotobj.Casino.Figure,...
    'Units','normalized',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'Position',[.7 0 .3 1]);
money= slotobj.Casino.CurrentPlayers{1}.Funds;
moneychar = ['$' num2str(money)];
if round(money) == money
    moneychar = [moneychar '.00'];
elseif round(money*10) == money*10
    moneychar = [moneychar '0'];
end
ft=uicontrol('Parent',Int,'Style','text',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'String',[slotobj.Casino.CurrentPlayers{1}.Name '''s funds:  ' moneychar] ,...
    'Fontsize',14,'Units','normalized','Position',[.15 .9 .6 .07]);

bgroup=uibuttongroup('Parent',Int,'Title','Insert','Fontsize',14,...
    'Fontweight','bold','Units','normalized',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'Position',[.1 .55 .6 .333333]);
op1=uicontrol('Parent',bgroup,'Style','radiobutton',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'String','25 cents','Fontsize',14,'Units','normalized',...
    'position',[.2 .8 .6 .15]);
op2=uicontrol('Parent',bgroup,'Style','radiobutton',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'String','50 cents','Fontsize',14,'Units','normalized',...
    'position',[.2 .5 .6 .15]);

op3=uicontrol('Parent',bgroup,'Style','radiobutton',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'String','1 dollar','Fontsize',14,'Units','normalized',...
    'position',[.2 .2 .6 .15]);
pullbut=uicontrol('Parent',Int,'Style','pushbutton',...
    'String','Pull','Fontsize',14,'Units','normalized',...
    'Position',[.2 .45 .3 .05],'Callback',@initiate);

LB = uicontrol('Parent',Int,...
    'Style','pushbutton',...
    'String', 'Exit Slots',...
    'Fontsize',14,'Units', 'normalized',...
    'Position',[.2 .05 .3 .05],...
    'Callback',@Leave);

OKbut=uicontrol('Parent',Int,...
    'Style','pushbutton',...
    'String','Okay','Fontsize',14,'Units','normalized',...
    'Position',[.2 .15 .3 .05],'Visible','off','Callback',@reset);
resSTR=uicontrol('Parent',Int,'Style','text',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'String',[slotobj.Casino.CurrentPlayers{1}.Name ' won $' num2str(slotobj.Casino.CurrentPlayers{1}.Pay)] ,...
    'Fontsize',14,'Units','normalized','Position',[.1 .2 .6 .04],'Visible','off');



SView=uipanel('Parent',slotobj.Casino.Figure,...
    'Units','normalized',...
    'Backgroundcolor', get(slotobj.Casino.Figure,'color'),...
    'Position',[0 0 .7 1]);
bg=imread('slot-machine.png');
h=axes('Parent',SView,'Units','normalized',...
    'Position',[0 0 1 1],'Color',[0 0 0],'Visible','on');
image(bg,'Parent',h)

R1=uipanel('Parent',SView,'Units','normalized',...
    'Position',[.194 .365 .155 .24]);
R2=uipanel('Parent',SView,'Units','normalized',...
    'Position',[.408 .365 .155 .24]);
R3=uipanel('Parent',SView,'Units','normalized',...
    'Position',[.622 .365 .155 .24]);
r1=axes('Parent',R1,'Visible','off','Position',[0 0 1 1]);
       r2=axes('Parent',R2,'visible','off','Position',[0 0 1 1]);
       r3=axes('Parent',R3,'visible','off','Position',[0 0 1 1]);

%call backs
    function initiate(obj,eventdata)
        set(pullbut,'Visible','off')
        set(LB,'Visible','off')
        ip=cell(3);
        if get(op1,'Value')==1
            cashin=.25;
        elseif get(op2,'Value')==1
            cashin=.5;
        else 
            cashin=1;
        end
       result=Pull(slotobj,cashin); % Computing the result and correlating it with the visuals
       for i=1:3
           if strcmp(result(i),'seven')
               ip{i}=SE;
           elseif strcmp(result(i),'bar')
               ip{i}=BA;
           elseif strcmp(result(i),'bell')
               ip{i}=BE;
           elseif strcmp(result(i),'grape')
               ip{i}=GR;
           elseif strcmp(result(i),'orange')
               ip{i}=OR;
           elseif strcmp(result(i),'cherry')
               ip{i}=CH;
           elseif strcmp(result(i),'blank')
               ip{i}=BL;
           end
           
           
       end
       
% The following is the display mechanism for flashing through the icons,
% then ending on the final result.
for p1=1:8
    if p1==8
      p1=image(ip{1},'Parent',r1);  
    elseif strcmp(result(1),res{p1})
        continue
    else
        p1=image(list{p1},'Parent',r1);
        pause(.2)
    end
end
for p2=1:8
    if p2==8
      p2=image(ip{2},'Parent',r2);  
    elseif strcmp(result(2),res{p2})
        continue
    else
        p2=image(list{p2},'Parent',r2);
        pause(.2)
    end
end
for p3=1:8
    if p3==8
      p3=image(ip{3},'Parent',r3);  
    elseif strcmp(result(3),res{p3})
        continue
    else
        p3=image(list{p3},'Parent',r3);
        pause(.2)
    end
end

        
money= slotobj.Casino.CurrentPlayers{1}.Funds;
moneychar = ['$' num2str(money)];
if round(money) == money
    moneychar = [moneychar '.00'];
elseif round(money*10) == money*10
    moneychar = [moneychar '0'];
end
set(ft,'String',[slotobj.Casino.CurrentPlayers{1}.Name '''s funds:  ' moneychar]);
set(resSTR,'String',[slotobj.Casino.CurrentPlayers{1}.Name ' won $' num2str(slotobj.Casino.CurrentPlayers{1}.Pay)],...
    'Visible','on')

set(OKbut,'Visible','on')
set(LB,'Visible','on')
    end
function reset(obj,eventdata)
    out=slotobj.Casino.Checkmoney;
if ~out
    
    set(OKbut,'Visible','off')
    set(pullbut,'Visible','on')
    p1=image(BL,'Parent',r1);
    p2=image(BL,'Parent',r2);
    p3=image(BL,'Parent',r3);
    set(resSTR,'Visible','off')
end
        end

    function Leave(obj,eventdata)
        set(Int,'Visible','off');
        set(SView,'Visible','off');
        slotobj.Casino.CurrentPlayers{1}={};
        
       out=slotobj.Casino.Checkmoney;
if ~out
       slotobj.Casino.ChooseGame
end
        
    end
    







    


end

