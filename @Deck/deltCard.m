function deltCard(deck)
%This function tells a Deck object that a card has been dealt from it,
%removing the first card of that deck.
deck.Cards(1) = [];
end