require 'pry'

class Board # BOARD # BOARD # BOARD
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],  # horizontal
    [1, 4, 7], [2, 5, 8], [3, 6, 9],  # vertical
    [1, 5, 9], [3, 5, 7]              # diagonal
  ]

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def get_square_at(key)
    squares[key]
  end

  def set_square_at(key, mark)
    squares[key].mark = mark
  end

  def unmarked_square_keys
    squares.keys.select { |key| squares[key].unmarked? }
  end

  def full?
    unmarked_square_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  def detect_winner
    WINNING_LINES.each do |squares|
      if squares.all? { |key| @squares[key].mark == TTTGame::HUMAN_MARK }
        return TTTGame::HUMAN_MARK
      elsif squares.all? { |key| @squares[key].mark == TTTGame::COMPUTER_MARK }
        return TTTGame::COMPUTER_MARK
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| squares[key] = Square.new }
  end

  # def detect_winner
  #   WINNING_LINES.each do |line|
  #     if count_human_marks(@squares.values_at(*line)) == 3
  #       return TTTGame::HUMAN_MARK
  #     elsif count_computer_marks(@squares.values_at(*line)) == 3
  #       return TTTGame::COMPUTER_MARK
  #     end
  #   end
  #   nil
  # end

  # def count_human_marks(squares)
  #   squares.map(&:mark).count(TTTGame::HUMAN_MARK)
  # end

  # def count_computer_marks(squares)
  #   squares.map(&:mark).count(TTTGame::COMPUTER_MARK)
  # end

end

class Square #SQUARE #SQUARE #SQUARE
  INITIAL_MARK = ' '

  attr_accessor :mark

  def initialize(mark = INITIAL_MARK)
    @mark = mark
  end

  def to_s
    @mark
  end

  def unmarked?
    mark == INITIAL_MARK
  end
end

class Player # PLAYER # PLAYER # PLAYER
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
end

# Orchestration Engine
class TTTGame # TTTGame # TTTGame # TTTGame
  HUMAN_MARK = 'X'
  COMPUTER_MARK = 'O'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARK)
    @computer = Player.new(COMPUTER_MARK)
  end

  def play
    system 'clear'
    display_welcome_message

    loop do
      display_board(false)

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?

        display_board
      end
      display_result
      break unless play_again?
      board.reset
      system 'clear'
      puts "Let's play again!"
      puts
    end

    display_goodbye_message
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_board(clear_screen = true)
    system 'clear' if clear_screen
    2.times { puts } if clear_screen
    puts "Your mark is '#{human.mark}', The computer's mark is '#{computer.mark}'"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def human_moves
    empty_squares = board.unmarked_square_keys.join(', ')
    print "Choose an empty square (#{empty_squares}): "
    choice = nil
    loop do
      choice = gets.chomp.to_i
      break if board.unmarked_square_keys.include?(choice)
      puts "Sorry, that's not a valid choice."
    end

    board.set_square_at(choice, human.mark)
  end

  def computer_moves
    choice = board.unmarked_square_keys.sample
    board.set_square_at(choice, computer.mark)
  end

  def display_result
    display_board
    case board.detect_winner
    when human.mark
      puts "You won!"
    when computer.mark
      puts "Computer won!"
    else
      puts "It's a tie."
    end
  end

  def play_again?
    answer = nil
    loop do
      print "Would you like to play again? (y/n): "
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, you can only answer y or n."
      puts
    end

    answer == 'y'
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe!'
  end
end

game = TTTGame.new
game.play
