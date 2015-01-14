function out = bustedAce(hand)
%This method returns true if a hand is busted and contains an AceCard with
%value 11, or false otherwise.
out = false;
if hand.Value > 21
    for i = 1:length(hand.Cards)
        if hand.Cards{i}.Value == 11
            out = true;
            break
        end
    end
end
end