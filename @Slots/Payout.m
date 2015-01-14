function out=Payout(slotobj,outcome,cashin)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
combolist={'Triple7' 1500 
    'Double7' 22 
    'Triplebar' 190
    'Doublebar' 6
    'Triplebell' 100
    'Doublebell' 4
    'TripleG' 60
    'DoubleG' 3
    'TripleO' 40
    'DoubleO' 2.4
    'TripleC' 30
    'DoubleC' 1.9
    'Fruit' 2.4
    'Blank' 1.5
    'None' 0};
combo=[];
LOOP=0;
x=zeros(3,1);
while LOOP~=1
    
for a=1:3
    x(a)=strcmp(outcome(a),'seven');
end
if sum(x)==3
    combo=combolist(1,1:2);
    break
elseif sum(x)==2
    combo=combolist(2,1:2);
    break
end

for b=1:3
    x(b)=strcmp(outcome(b),'bar');
end
if sum(x)==3
    combo=combolist(3,1:2);
    break
elseif sum(x)==2
    combo=combolist(4,1:2);
    break
end


for c=1:3
    x(c)=strcmp(outcome(c),'bell');
end
if sum(x)==3
    keyboard
    combo=combolist(5,1:2);
    break
elseif sum(x)==2
    combo=combolist(6,1:2);
    break
end

for d=1:3
    x(d)=strcmp(outcome(d),'grape');
end
if sum(x)==3
    combo=combolist(7,1:2);
   break
elseif sum(x)==2
    combo=combolist(8,1:2);
    break
end



for e=1:3
    x(e)=strcmp(outcome(e),'orange');
end
if sum(x)==3
    combo=combolist(9,1:2);
    break
elseif sum(x)==2
    combo=combolist(10,1:2);
    break
end

for f=1:3
    x(f)=strcmp(outcome(f),'cherry');
end
if sum(x)==3
    combo=combolist(11,1:2);
    break
elseif sum(x)==2
    combo=combolist(12,1:2);
    break
end

for g=1:3
    if strcmp(outcome(g),'cherry') || strcmp(outcome(g),'orange') || strcmp(outcome(g),'grape')
        x(g)=1;
    else
        x(g)=0;
    end
end
if sum(x)==3
    combo=combolist(13,1:2);
    break
end


for h=1:3
    x(h)=strcmp(outcome(h),'blank');
end
if sum(x)==3
    combo=combolist(14,1:2);
    break
end

combo=combolist(15,1:2);
LOOP=1;
    
    
    
end
 if cashin==1
     x=floor(cashin*combo{2}*100)/100;
     
     AddResult(slotobj.Casino.CurrentPlayers{1},(x-1),'S')
     EditFunds(slotobj.Casino.CurrentPlayers{1},(x-1))
   %slotobj.Casino.CurrentPlayers{1}.Results(end+1,1:2)={(cashin*combo{2}-1) 'S'};
   %slotobj.Casino.CurrentPlayers{1}.Funds=slotobj.Casino.CurrentPlayers{1}.Funds+(cashin*combo{2}-1);
   slotobj.Casino.CurrentPlayers{1}.Pay=x;
 end
 if cashin==.5
     x=floor(.97*cashin*combo{2}*100)/100;
     
     AddResult(slotobj.Casino.CurrentPlayers{1},(x-.5),'S')
     EditFunds(slotobj.Casino.CurrentPlayers{1},(x-.5))
     %slotobj.Casino.CurrentPlayers{1}.Results(end+1,1:2)={(cashin*.97*combo{2}-.5) 'S'};
     %slotobj.Casino.CurrentPlayers{1}.Funds=slotobj.Casino.CurrentPlayers{1}.Funds+(cashin*.97*combo{2}-.5);
     slotobj.Casino.CurrentPlayers{1}.Pay=x;
 end
 if cashin==.25
     x=floor(.95*cashin*combo{2}*100)/100;
     
     AddResult(slotobj.Casino.CurrentPlayers{1},(x-.25),'S')
     EditFunds(slotobj.Casino.CurrentPlayers{1},(x-.25))
     %slotobj.Casino.CurrentPlayers{1}.Results(end+1,1:2)={(cashin*.95*combo{2}-.25) 'S'};
     %slotobj.Casino.CurrentPlayers{1}.Funds=slotobj.Casino.CurrentPlayers{1}.Funds+(cashin*.95*combo{2}-.25);
     slotobj.Casino.CurrentPlayers{1}.Pay=x;
 end
 
 
 
 out=outcome;

    

end

