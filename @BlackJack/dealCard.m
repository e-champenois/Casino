function dealCard(game, nPlayer, nHand)
%Deals a card to a player.
if nargin == 1
    nPlayer = 0;
    nHand = 1;
elseif nargin == 2
    nHand = 1;
end
if nPlayer > 0
    game.BettingPlayers{nPlayer}.Hand{nHand}.addCard(game.Deck.Cards{1});
    deltCard(game.Deck);
else
    game.Dealer.addCard(game.Deck.Cards{1});
    deltCard(game.Deck);
end

end