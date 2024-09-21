=begin
* OBJECTS *

Player
  @name
  @choice
Human < Player
Computer < Player

Choice
  CHOICES = [rock, paper, scissors, lizard, spock]
  @choice           # rock
  @defeats          # scissors, lizard
  @active_verbs     # smashes, crushes
  @is_defeated_by   # paper, spock
  @passive_verbs    # is covered by, is vaporized by

Game
  @human
  @computer
  @stats
    total games played
    matches stats
    games stats
Match
  @scores = {player: 0, computer: 0, ties: 0}
  @winner
Round
  @winner

* ORCHESTRATION *
intro
set names
match loop
  round
  match result
result
outro
=end
