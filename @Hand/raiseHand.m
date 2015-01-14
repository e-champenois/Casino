function raiseHand(hand)
%This method raises the value of each AceCard in Hand to 11.
for i = 1:length(hand.Cards)
    if hand.Cards{i}.Value == 1
        raiseAce(hand.Cards{i});
    end
end
end