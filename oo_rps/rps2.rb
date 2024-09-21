class Player
  attr_reader :name, :choice

  private
  attr_writer :name, :choice
end

class Human < Player
  private
  def set_name
    @name = 'Mitch'
  end

  def choose
    @choice = 'rock'
  end
end

class Computer < Player
  private
  def set_name
    @name = 'Hal'
  end

  def choose
    @choice = Choice::CHOICES.sample
  end
end

class Choice
  CHOICES = %w(rock paper scissors lizard spock)
  CHOICES_DATA = {
    rock: {
      defeats: ['scissors', 'lizard'],
      active_verbs: ['crushes', 'crushes'],
      defeated_by: ['paper', 'spock'],
      passive_verbs: ['covered', 'vaporized']
      },
    paper: {
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
    lizard: {
      defeats: ['paper', 'spock'],
      active_verbs: ['eats', 'poisons'],
      defeated_by: ['rock', 'scissors'],
      passive_verbs: ['crushed', 'decapitated']
      },
    spock: {
      defeats: ['rock', 'scissors'],
      active_verbs: ['vaporizes', 'smashes'],
      defeated_by: ['paper', 'lizard'],
      passive_verbs: ['disproved', 'poisoned']
      }
  }
end

class Round
  attr_reader :player_choice, :computer_choice, :winner

  def initialize
    @player_choice = get_player_choice
    @computer_choice = get_computer_choice
  end

  def winner

  end

  private
  attr_writer :number, :winner
end

class Match
  attr_reader :scores, :round_number, :round, :winner

  def initialize
    @scores = {player: 0, computer: 0, ties: 0}
    @round_number = scores.values.sum + 1
    @round = Round.new
  end

  def update_scores

  end

  def winner

  end

  def winner?

  end

  private
  attr_writer :round_number, :scores, :winner
end

class RPSGame
  def initialize

  end
end
