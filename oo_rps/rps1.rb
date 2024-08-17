class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    entered_name = ''
    loop do
      print "Please enter your name: "
      entered_name = gets.chomp
      break unless entered_name.empty?
      puts "Sorry, you must enter a value."
      puts
    end
    self.name = entered_name
  end

  def choose
    choice = nil
    loop do
      print "Please choose rock, paper, or scissors: "
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
      puts
    end
    puts
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(C3PO HAL Bender Kryten Rosie).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = %w(rock paper scissors)

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

# Game Orchestration Engine
class RPSGame
  attr_reader :human, :computer

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    system 'clear'
    puts "Welcome to Rock, Paper, Scissors!"
    puts
  end

  def display_players
    puts "#{human.name}, you will play against #{computer.name}."
    puts
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts
  end

  def display_result
    moves, verb = result_words
    puts "#{moves.first.capitalize} #{verb} #{moves.last}."
    puts
    display_winner
  end

  def result_words
    moves = [human.move, computer.move].map(&:to_s)
    moves.reverse! if computer.move > human.move
    verb = moves.first == moves.last ? "is equal to" : "beats"
    [moves, verb]
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie."
    end
    puts
  end

  def play_again?
    choice = nil
    loop do
      print "Would you like to play again? Enter 'y' if yes or 'n' if no: "
      choice = gets.chomp.downcase
      break if %w(y n).include?(choice)
      puts "Sorry, please enter 'y' or 'n'."
      puts
    end
    puts
    choice == 'y'
  end

  def display_goodbye_message
    puts "Thank you for playing, #{human.name}! Goodbye."
  end

  def play
    display_players
    loop do
      human.choose
      computer.choose
      display_moves
      display_result
      break unless play_again?
      system 'clear'
    end
    display_goodbye_message
  end
end

RPSGame.new.play
