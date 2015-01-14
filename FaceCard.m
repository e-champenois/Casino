classdef FaceCard < Cards
    %This class creates Face Card objects. These are characterized by a
    %suit and an ID ('J' for jack, 'Q' for queen, or 'K' for King). The
    %value will always be 10. This class inherits from the Cards class.
    
    properties
        Value
        ID
    end
    
    methods
        function obj = FaceCard(suit, val)
            obj = obj@Cards(suit);
            obj.Value = 10;
            obj.Suit = suit;
            if val == 11
                vals = 'J';
            elseif val == 12
                vals = 'Q';
            elseif val == 13
                vals = 'K';
            end
            obj.ID = [vals suit];
        end
    end
    
end