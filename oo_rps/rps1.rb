class Player
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      entered_name = ''
      loop do
        print "Please enter your name: "
        entered_name = gets.chomp
        break unless entered_name.empty?
        puts "Sorry, you must enter a value."
        puts
      end
      self.name = entered_name
    else
      self.name = %w(Number 5 HAL Bender Kryten Rosie).sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        print "Please choose rock, paper, or scissors: "
        choice = gets.chomp
        break if %w(rock paper scissors).include?(choice)
        puts "Sorry, invalid choice."
        puts
      end
      puts
      self.move = choice
    else
      self.move = %w(rock paper scissors).sample
    end
  end

  def human?
    @player_type == :human
  end
end

# Game Orchestration Engine
class RPSGame
  attr_reader :human, :computer

  def initialize
    display_welcome_message
    @human = Player.new
    @computer = Player.new(:computer)
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

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts
    determine_winner
  end

  def determine_winner
    case human.move
    when 'rock'
      puts "It's a tie." if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when 'scissors'
      puts "It's a tie." if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
    when 'paper'
      puts "It's a tie." if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissors'
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
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
