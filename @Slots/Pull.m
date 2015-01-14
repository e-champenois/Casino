function out=Pull(slotobj,cashin)
            outcome=cell(3,1);
            reel={'blank' 'cherry' 'orange' 'grape' 'bell' 'bar' 'seven'};
            for i=1:3
                x=randi(512);
                
                if x>=1 && x<=16
                    outcome{i}=reel{7};
                    
                end
                if x>=17 && x<=48
                    outcome{i}=reel{6};
                    
                end
                if x>=49 && x<=88
                    outcome{i}=reel{5};
                    
                end
                if x>=89 && x<=136
                    outcome{i}=reel{4};
                    
                end
                if x>=137 && x<=192
                    outcome{i}=reel{3};
                    
                end
                if x>=193 && x<=256
                    outcome{i}=reel{2};
                    
                end
                if x>=257 && x<=512
                    outcome{i}=reel{1};
                    
                end
            end
            
           out=slotobj.Payout(outcome,cashin);
                
                
        end
