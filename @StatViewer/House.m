function [O,S,R,B]=House(SV,players,opt)
            n=length(players);
            if opt ==1
                
           if n >=1
               O1=-1.*players{1}.Stats.Cumul;
               S1=-1.*players{1}.Stats.Slo;
               R1=-1.*players{1}.Stats.Rou;
               B1=-1.*players{1}.Stats.BJ;
           end
           
          if n>=2
               
               O2=-1.*players{2}.Stats.Cumul;
               S2=-1.*players{2}.Stats.Slo;
               R2=-1.*players{2}.Stats.Rou;
               B2=-1.*players{2}.Stats.BJ;
               
               if length(O2)>length(O1)
                   
                   O1(length(O1)+1:length(O2))=O1(length(O1));
                   O12=O1+O2;
               else
                  
                   O2(length(O2)+1:length(O1))=O2(length(O2));
                   O12=O1+O2; 
               end
               if length(S2)>length(S1)
                   S1(length(S1)+1:length(S2))=S1(length(S1));
                   S12=S1+S2;
               else
                  S2(length(S2)+1:length(S1))=S2(length(S2));
                   S12=S1+S2; 
               end
               if length(R2)>length(R1)
                   R1(length(R1)+1:length(R2))=R1(length(R1));
                   R12=R1+R2;
               else
                  R2(length(R2)+1:length(R1))=R2(length(R2));
                   R12=R1+R2; 
               end
               if length(B2)>length(B1)
                   B1(length(B1)+1:length(B2))=B1(length(B1));
                   B12=B1+B2;
               else
                  B2(length(B2)+1:length(B1))=B2(length(B2));
                   B12=B1+B2; 
               end
               
               
          end
          if n>=3 
              O3=-1.*players{3}.Stats.Cumul;
               S3=-1.*players{3}.Stats.Slo;
               R3=-1.*players{3}.Stats.Rou;
               B3=-1.*players{3}.Stats.BJ;
              
              if length(O12)>length(O3)
                   
                   O3(length(O3)+1:length(O12))=O3(length(O3));
                   O123=O3+O12;
               else
                  O12(length(O12)+1:length(O3))=O12(length(O12));
                   O123=O3+O12; 
               end
               if length(S12)>length(S3)
                   
                   S3(length(S3)+1:length(S12))=S3(length(S3));
                   S123=S12+S3;
               else
                  S12(length(S12)+1:length(S3))=S12(length(S12));
                   S123=S12+S3; 
               end
               if length(R12)>length(R3)
                   R3(length(R3)+1:length(R12))=R3(length(R3));
                   R123=R3+R12;
               else
                  R12(length(R12)+1:length(R3))=R12(length(R12));
                   R123=R3+R12; 
               end
               if length(B12)>length(B3)
                   B3(length(B3)+1:length(B12))=B3(length(B3));
                   B123=B3+B12;
               else
                  B12(length(B12)+1:length(B3))=B12(length(B12));
                   B123=B3+B12; 
               end
               
               
          end
          if n==4
              O4=-1.*players{4}.Stats.Cumul;
               S4=-1.*players{4}.Stats.Slo;
               R4=-1.*players{4}.Stats.Rou;
               B4=-1.*players{4}.Stats.BJ;
              
              
              if length(O123)>length(O4)
                   O4(length(O4)+1:length(O123))=O4(length(O4));
                   
                   O1234=O4+O123;
               else
                  O123(length(O123)+1:length(O4))=O123(length(O123));
                   
                   O1234=O4+O123; 
               end
               if length(S123)>length(S4)
                   S4(length(S4)+1:length(S123))=S4(length(S4));
                   S1234=S123+S4;
               else
                  S123(length(S123)+1:length(S4))=S123(length(S123));
                   S1234=S123+S4; 
               end
               if length(R123)>length(R4)
                   R4(length(R4)+1:length(R123))=R4(length(R4));
                   R1234=R4+R123;
               else
                 R123(length(R123)+1:length(R4))=R123(length(R123));
                   R1234=R4+R123; 
               end
               if length(B123)>length(B4)
                   B4(length(B4)+1:length(B123))=B4(length(B4));
                   B1234=B4+B123;
               else
                  B123(length(B123)+1:length(B4))=B123(length(B123));
                   B1234=B4+B123; 
               end
          end
          
          if n==1
              O=O1;
              S=S1;
              R=R1;
              B=B1;
          elseif n==2
              O=O12;
              S=S12;
              R=R12;
              B=B12;
          elseif n==3
              O=O123;
              S=S123;
              R=R123;
              B=B123;
          else
             O=O1234;
              S=S1234;
              R=R1234;
              B=B1234; 
          end
            else % For session house stats
           if n >=1
               O1=-1.*players{1}.Stats.SCumul;
               S1=-1.*players{1}.Stats.SSlo;
               R1=-1.*players{1}.Stats.SRou;
               B1=-1.*players{1}.Stats.SBJ;
           
          if n>=2
               
               O2=-1.*players{2}.Stats.SCumul;
               S2=-1.*players{2}.Stats.SSlo;
               R2=-1.*players{2}.Stats.SRou;
               B2=-1.*players{2}.Stats.SBJ;
               
               if length(O2)>length(O1)
                   
                   O1(length(O1)+1:length(O2))=O1(length(O1));
                   O12=O1+O2;
               else
                  
                   O2(length(O2)+1:length(O1))=O2(length(O2));
                   O12=O1+O2; 
               end
               if length(S2)>length(S1)
                   S1(length(S1)+1:length(S2))=S1(length(S1));
                   S12=S1+S2;
               else
                  S2(length(S2)+1:length(S1))=S2(length(S2));
                   S12=S1+S2; 
               end
               if length(R2)>length(R1)
                   R1(length(R1)+1:length(R2))=R1(length(R1));
                   R12=R1+R2;
               else
                  R2(length(R2)+1:length(R1))=R2(length(R2));
                   R12=R1+R2; 
               end
               if length(B2)>length(B1)
                   B1(length(B1)+1:length(B2))=B1(length(B1));
                   B12=B1+B2;
               else
                  B2(length(B2)+1:length(B1))=B2(length(B2));
                   B12=B1+B2; 
               end
               
               
          end
          if n>=3 
              O3=-1.*players{3}.Stats.SCumul;
               S3=-1.*players{3}.Stats.SSlo;
               R3=-1.*players{3}.Stats.SRou;
               B3=-1.*players{3}.Stats.SBJ;
              
              if length(O12)>length(O3)
                   
                   O3(length(O3)+1:length(O12))=O3(length(O3));
                   O123=O3+O12;
               else
                  O12(length(O12)+1:length(O3))=O12(length(O12));
                   O123=O3+O12; 
               end
               if length(S12)>length(S3)
                   
                   S3(length(S3)+1:length(S12))=S3(length(S3));
                   S123=S12+S3;
               else
                  S12(length(S12)+1:length(S3))=S12(length(S12));
                   S123=S12+S3; 
               end
               if length(R12)>length(R3)
                   R3(length(R3)+1:length(R12))=R3(length(R3));
                   R123=R3+R12;
               else
                  R12(length(R12)+1:length(R3))=R12(length(R12));
                   R123=R3+R12; 
               end
               if length(B12)>length(B3)
                   B3(length(B3)+1:length(B12))=B3(length(B3));
                   B123=B3+B12;
               else
                  B12(length(B12)+1:length(B3))=B12(length(B12));
                   B123=B3+B12; 
               end
               
               
          end
          if n==4
              O4=-1.*players{4}.Stats.SCumul;
               S4=-1.*players{4}.Stats.SSlo;
               R4=-1.*players{4}.Stats.SRou;
               B4=-1.*players{4}.Stats.SBJ;
              
              
              if length(O123)>length(O4)
                   O4(length(O4)+1:length(O123))=O4(length(O4));
                   
                   O1234=O4+O123;
               else
                  O123(length(O123)+1:length(O4))=O123(length(O123));
                   
                   O1234=O4+O123; 
               end
               if length(S123)>length(S4)
                   S4(length(S4)+1:length(S123))=S4(length(S4));
                   S1234=S123+S4;
               else
                  S123(length(S123)+1:length(S4))=S123(length(S123));
                   S1234=S123+S4; 
               end
               if length(R123)>length(R4)
                   R4(length(R4)+1:length(R123))=R4(length(R4));
                   R1234=R4+R123;
               else
                 R123(length(R123)+1:length(R4))=R123(length(R123));
                   R1234=R4+R123; 
               end
               if length(B123)>length(B4)
                   B4(length(B4)+1:length(B123))=B4(length(B4));
                   B1234=B4+B123;
               else
                  B123(length(B123)+1:length(B4))=B123(length(B123));
                   B1234=B4+B123; 
               end
          end
          
          if n==1
              O=O1;
              S=S1;
              R=R1;
              B=B1;
          elseif n==2
              O=O12;
              S=S12;
              R=R12;
              B=B12;
          elseif n==3
              O=O123;
              S=S123;
              R=R123;
              B=B123;
          else
             O=O1234;
              S=S1234;
              R=R1234;
              B=B1234; 
          end
            end
          
end

