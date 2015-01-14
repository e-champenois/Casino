function reduceAce(hand)
%This method reduces the value of the first AceCard of value 11 found in a
%Hand.
for i = 1:length(hand.Cards)
    if hand.Cards{i}.Value == 11
        lowerAce(hand.Cards{i});
        break
    end
end
end