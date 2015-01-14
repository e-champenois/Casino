function out = isBlackJack(hand)
%This method returns true if the Hand object input is a BlackJack (two
%cards with value 21) or false if it is not.
l = length(hand.Cards);
val = hand.Value;
if l == 2 && val == 21
    out = true;
else
    out = false;
end
end