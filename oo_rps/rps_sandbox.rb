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
  @defeated_by   # paper, spock
  @passive_verbs    # covered, vaporized

  CHOICES_DATA = {
    rock:     {
      defeats: ['scissors', 'lizard'],
      active_verbs: ['crushes', 'crushes'],
      defeated_by: ['paper', 'spock'],
      passive_verbs: ['covered', 'vaporized']
      },
    paper:    {
      defeats: ['rock', 'spock'],
      active_verbs: ['covers', 'disproves'],
      defeated_by: ['scissors', 'lizard'],
      passive_verbs: ['cut', 'eaten']
      },
    scissors: {
      defeats: ['paper', 'lizard'],
      active_verbs: ['cuts', 'decapitates'],
      defeated_by: ['rock', 'spock'],
      passive_verbs: ['crushed', 'smashed']
      },
    lizard:   {
      defeats: ['paper', 'spock'],
      active_verbs: ['eats', 'poisons'],
      defeated_by: ['rock', 'scissors'],
      passive_verbs: ['crushed', 'decapitated']
      },
    spock:    {
      defeats: ['rock', 'scissors'],
      active_verbs: ['vaporizes', 'smashes'],
      defeated_by: ['paper', 'lizard'],
      passive_verbs: ['disproved', 'poisoned']
      }
  }

RPSGame
  @human
  @computer
  @stats
    total games played
    matches stats
    games stats
Match
  @round_number
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
