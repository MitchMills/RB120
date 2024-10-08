module RPSRules
  GAMES_PER_MATCH = 5

  RPS_CHOICES = %w(rock paper scissors)
  RPSLS_CHOICES = RPS_CHOICES + %w(lizard spock)
  # RPSFW_CHOICES = RPS_CHOICES + %w(fire water)

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



class Player
  include RPSRules

  attr_reader :name, :choice

  private
  attr_writer :name, :choice
end

class Human < Player
  def set_name
    @name = 'Mitch'
  end

  def choose
    @choice = Choice.new('rock')
  end
end

class Computer < Player
  def set_name
    @name = 'Hal'
  end

  def choose
    @choice = Choice.new(RPSLS_CHOICES.sample)
  end
end



class Choice
  include RPSRules

  attr_reader :type

  def initialize(type)
    @type = type
    @data = CHOICES_DATA[type]
  end

  def compare_choices(other_type)

  end

  def >(other_type)

  end

  def <(other_type)

  end

  protected
  attr_writer :type, :data
end



class Round
  attr_reader :player_choice, :computer_choice, :winner

  def initialize
    @player_choice = get_player_choice
    @computer_choice = get_computer_choice
  end

  def result
    player_choice.compare_choices(computer_choice)
  end

  private
  attr_writer :number, :winner
end

class Match
  attr_reader :scores, :round, :winner

  def initialize
    @scores = Scores.new
    @round = Round.new
  end

  def round_number
    current = scores.total + 1
    max = RPSRules::GAMES_PER_MATCH
    current <= max ? current : max
  end

  def result

  end

  def over?

  end

  private
  attr_writer :scores, :winner
end

class Scores
  attr_reader :player, :computer, :ties

  def initialize
    @player = 0
    @computer = 0
    @ties = 0
  end

  def total
    player + computer + ties
  end

  def update(result)
    result += 1
  end

  private
  attr_writer :player, :computer, :ties
end

class Stats
  def initialize
    @player_match_wins = 0
    @computer_match_wins = 0
    @match_ties = 0
  end

  private
  attr_accessor :player_match_wins, :computer_match_wins, :match_ties
end




class RPSGame

  def initialize
    @human = Human.new
    @computer = Computer.new
    @stats = Stats.new
  end

  def set_game_type(type) # e.g. rps, rpsls, rpsfw
    game_type = type
  end

  def update_stats(result)

  end

  private
  attr_accessor :human, :computer, :stats, :game_type
end
