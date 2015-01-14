classdef Hand < handle
    %This class creates Hand objects. A Hand object has a value, which is
    %the sum of the value of its cards, a Cards property, which is a
    %cell array of Card objects representing the cards in the hand, and a
    %Doubled property, checking if a Double Down action was taken on this
    %hand.
    
    properties (Dependent = true, SetAccess = private)
        Value = [];
    end
    properties %(SetAccess = private)
        Cards = {};
        
    end
    properties
        Doubled
    end
    
    methods
        function obj = Hand
        end
        function value = get.Value(hand)
            %This method calculates the value of a hand by looking at the value of the
            %Cards in the hand.
            l = length(hand.Cards);
            value = 0;
            for i = 1:l
                value = hand.Cards{i}.Value + value;
            end
        end
    end
    
    
end

