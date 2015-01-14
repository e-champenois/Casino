classdef Players < handle
   %The Players class holds the player's Name and Funds, as well as his or
   %her results for various games, and some data specific to the current
   %game.
    
    properties
        Name = [];
        Funds = 0;
        Results={};
        SResults={};
        Stats
    end
    properties %roulette
        Bet = [];
        Places = [];
    end
    
    properties % blackjack
        Hand
        BetB
        Action
        Insured
    end
    
    properties %slots
        Pay
    end
    
    methods
        function obj = Players(name,cash)
            obj.Name = name;
            obj.Funds=cash;
        end
        function EditFunds(person,cashchange) % cash is just the result of a round/hand/pull
            person.Funds=person.Funds+cashchange;
        end
        function AddResult(person,cashchange,game) %game is just a symbol
            person.Results{end+1,1}=cashchange;
            person.Results{end,2}=game;
            person.SResults{end+1,1}=cashchange;
            person.SResults{end,2}=game;
            person.Store;
            
            
            
        end
        function Statobj(player)
            player.Stats=Stats(player);
        end
        
        function Store(player)
            res=player.Results;
            fun=player.Funds;
            save(['Undergrad/Casino/savednames/' player.Name '.mat'],'res','fun')
        end
        function LoadRes(player,res)
           player.Results=res;
        end
        
        
            
        end
   
    
    
    methods % blackjack stuff
        function result(name, n)   
            cashchange = n*name.BetB;
            [a,b] = strread(num2str(cashchange), '%s %s', 'delimiter', '.');
            if isempty(b)
            elseif length(b{1}) < 3
            else
                cashchange = cashchange - 0.005;
            end
            EditFunds(name,cashchange);
        end
    end
    events
        NoMoney
    end
    
end


