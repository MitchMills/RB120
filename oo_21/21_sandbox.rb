=begin
*** EARLY FINISH / NO DEALER TURN ***

player busted => DEALER WINS
  {display message: busted
  {any key to continue
  * clear screen *
  [display message: dealer reveal
  [display all cards
  display message: busted2
  display message: dealer wins


player blackjack && dealer blackjack => TIE
  {display message: blackjack
  {any key to continue
  * clear screen *
  [display message: dealer reveal
  [display all cards
  display message: dealer blackjack
  display message: tie


player blackjack && dealer not blackjack => PLAYER WINS
  {display message: blackjack
  {any key to continue
  * clear screen *
  [display message: dealer reveal
  [display all cards
  display message: no dealer blackjack
  display message: you win



*** REGULAR FINISH / PROCEED TO DEALER TURN

player twenty one => COMPARE
  {display message: twenty-one
  {any key to continue
  * clear screen *
  [display message: dealer reveal
  [display all cards
  DEALER TURN

player stays => COMPARE
  {display message: you stayed
  {any key to continue
  * clear screen *
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
