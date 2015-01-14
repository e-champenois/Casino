function addCard(hand,card)
%This method adds a Card object to the cell array Cards of a Hand.
hand.Cards{length(hand.Cards)+1} = card;
end