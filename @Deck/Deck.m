classdef Deck < handle
    %This class creates Deck objects. A deck has only one property, Cards,
    %which is a cell array of the Card objects representing the cards in
    %the deck.
    
    properties
        Cards %cell array of cards
    end
    
    methods
        function deck = Deck(used)
            if nargin < 1
                suites = ['S' 'H' 'C' 'D'];
                deck.Cards = {};
                for i = 1:13
                    for j = 1:4
                        suit = suites(j);
                        if i == 1
                            deck.Cards{length(deck.Cards)+1} = AceCard(suit);
                        elseif i < 11
                            deck.Cards{length(deck.Cards)+1} = NumberCard(suit, i);
                        else
                            deck.Cards{length(deck.Cards)+1} = FaceCard(suit, i);
                        end
                    end
                end
            elseif strcmp(used,'Used')
                deck.Cards = {};
            end
        end   
    end    
end

