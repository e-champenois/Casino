classdef AceCard < Cards
    %This class creates Ace Card objects. These are characterized by a
    %suit and a value (11 or 1). This class inherits from the Cards class.
    
    properties
        Value
        ID
    end
    
    methods
        function obj = AceCard(suit)
            obj = obj@Cards(suit);
            obj.Value = 11;
            obj.ID = ['A' suit];
            
        end
        function lowerAce(card)
            card.Value = 1;
        end
        function raiseAce(card)
            card.Value = 11;
        end
    end
    
end

