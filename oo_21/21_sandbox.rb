=begin
%: opening_hands

*** EARLY FINISH / NO DEALER TURN ***

PLAYER BLACKJACK && DEALER BLACKJACK
  % display opening deal
  % display opening hands => PLAYER BLACKJACK

  {display message: blackjack
  {any key to continue

  * clear screen *
  [display message: dealer reveal
  [display all cards => DEALER BLACKJACK
  display message: dealer blackjack
  display message: tie


PLAYER BLACKJACK && NO DEALER BLACKJACK
  % display opening deal
  % display opening hands => PLAYER BLACKJACK

  {display message: blackjack
  {any key to continue

  * clear screen *
  [display message: dealer reveal
  [display all cards => NO DEALER BLACKJACK
  display message: not dealer blackjack
  display message: you win


PLAYER BUSTED
  % display opening deal
  % display opening hands => NO BLACKJACK

  {display message: hit or stay => PLAYER HITS (can be multiple times)
  * clear screen *
  <display message: you chose to hit
  <diplay card deal => PLAYER BUSTED
  <display hands (hidden card)
  {display message: player busted
  {any key to continue

  * clear screen *
  [display message: dealer reveal
  [display all cards
  display message: busted2
  display message: dealer wins





*** REGULAR FINISH / PROCEED TO DEALER TURN

PLAYER TWENTY ONE
  % display opening deal
  % display opening hands => NO BLACKJACK

  {display message: hit or stay => PLAYER HITS (can be multiple times)
  * clear screen *
  <display message: you chose to hit
  <diplay card deal => PLAYER TWENTY ONE
  <display hands (hidden card)
  {display message: player twenty-one
  {any key to continue

  * clear screen *
  [display message: dealer reveal
  [display all cards
  DEALER TURN

PLAYER STAYS
  % display opening deal
  % display opening hands => NO BLACKJACK

  {display message: hit or stay => PLAYER STAYS (can be after hits)

  * clear screen *
  <display message: you chose to stay
  [display message: dealer reveal
  [display all cards
  DEALER TURN



*** DEALER TURN
  {display message: dealer turn
  {any key to continue
  * clear screen *
  display message: dealer decision
  display all cards

dealer blackjack => DEALER WINS
  pause?
  display message: dealer blackjack
  display message: dealer wins




=end

def alphabetized(string)
  string.chars.sort_by { |char, index| char.downcase }.join
end
p alphabetized('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ') #== 'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ'

# def length_alphabetical(sentence)
#   sentence.split.sort_by { |word| [word.size, word.downcase] }
# end

# p length_alphabetical('To say yes or no') == ["no", "or", "To", "say", "yes"]
# p length_alphabetical('A man a plan a canal Panama') == ["A", "a", "a", "man", "plan", "canal", "Panama"]
# p length_alphabetical('The quick brown fox jumps over the lazy dog') == ["dog", "fox", "The", "the", "lazy", "over", "brown", "jumps", "quick"]
# p length_alphabetical('The Slow Path for Studious Learners to a Career in Software Development') == ["a", "in", "to", "for", "The", "Path", "Slow", "Career", "Learners", "Software", "Studious", "Development"]
