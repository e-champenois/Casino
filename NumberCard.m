classdef NumberCard < Cards
    %This class creates Number Card objects. These are characterized by a
    %suit and a value (2 through 10). This class inherits from the Cards class.
    
    properties
        Value
        ID
    end
    
    methods
        function obj = NumberCard(suit, val)
            obj = obj@Cards(suit);
            obj.Value = val;
            vals = num2str(val);
            obj.ID = [vals suit];
        end
    end
    
end

