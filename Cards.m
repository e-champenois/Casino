classdef Cards < handle
 % Cards is an abstract class that is used to build card objects. This
 % class leaves some properties and methods for AceCards, NumberCards, and
 % FaceCards.
    
    properties
        Suit
    end
    properties (Abstract)
        Value
        ID
    end
    
    methods
        function obj = Cards(suit)
            obj.Suit = suit;
        end
    end
    
end

