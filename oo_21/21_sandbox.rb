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

# def alphabetized(string)
#   alpha_characters = string.chars.select do |char|
#     ('a'..'z').include?(char.downcase)
#   end

#   alpha_characters.sort_by do |char|
#     [char.downcase, string.index(char)]
#   end.join
# end

def alphabetized(string)
  alpha_characters = string.chars.select do |char|
    ('a'..'z').include?(char.downcase)
  end

  alpha_characters.sort_by.with_index do |char, index|
    [char.downcase, index]
  end.join
end

p alphabetized('') == ''
p alphabetized(' ') == ''
p alphabetized('9#$.%') == ''
p alphabetized(' ba ') == 'ab'
p alphabetized('Ab Ba') == 'AabB'
p alphabetized('Ba Ab') == 'aABb'
p alphabetized('9A #b$B .a%') == 'AabB'
p alphabetized('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ') == 'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ'

p alphabetized('bA aB') == 'AabB'
p alphabetized('bA aBb') == 'AabBb'
