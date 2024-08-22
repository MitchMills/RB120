class Board # BOARD
  INITIAL_MARK = ' '

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARK) }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, mark)
    @squares[key].mark = mark
  end
end

class Square #SQUARE
  attr_accessor :mark

  def initialize(mark)
    @mark = mark
  end

  def to_s
    @mark
  end
end

class Player # PLAYER
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
end

# Orchestration Engine
class TTTGame # TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new('X')
    @computer = Player.new('O')
  end

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      display_board
      break
      break if someone_won? || board_full?

      computer_moves
      break if someone_won? || board_full?
    end
    # display_result
    display_goodbye_message
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_board
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
    print "Choose a square between 1 and 9: "
    choice = nil
    loop do
      choice = gets.chomp.to_i
      break if (1..9).include?(choice)
      puts "Sorry, that's not a valid square."
    end
    board.set_square_at(choice, @human.mark)
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe!'
  end
end

game = TTTGame.new
game.play
