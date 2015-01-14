function shuffleDeck(deck)
% This method shuffles a Deck object. This will rearrange the cell array of
% Cards into a random order.
nCards = length(deck.Cards);
iniDeck = deck.Cards;
deck.Cards = {};
for i = 1:nCards
    n = randi(length(iniDeck));
    deck.Cards{i} = iniDeck{n};
    iniDeck(n) = [];
end
end