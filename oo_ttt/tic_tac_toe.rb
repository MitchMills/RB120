module DisplayMethods
  def clear_screen
    system 'clear'
  end

  def display_welcome_message
    clear_screen
    puts 'Welcome to Tic Tac Toe!'
  end

  def display_board
    puts "Your Mark: '#{human.mark}'  Computer's Mark:'#{computer.mark}'"
    puts
    board.draw
    puts
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_available_moves
    empty_squares = board.unmarked_square_keys
    print "Choose an empty square (#{joinor(empty_squares)}): "
  end

  def joinor(choices, delimiter: ',', word: 'or')
    leading_numbers = "#{choices[0..-2].join("#{delimiter} ")}"

    case choices.size
    when 1 then"#{choices.first}"
    when 2 then "#{choices.first} #{word} #{choices.last}"
    else leading_numbers + "#{delimiter} #{word} #{choices.last}"
    end
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.mark
      puts "You won!"
    when computer.mark
      puts "Computer won!"
    else
      puts "It's a tie."
    end
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
  end

  def display_goodbye_message
    puts
    puts 'Thanks for playing Tic Tac Toe!'
  end
end



module MoveMethods
  HUMAN_MARK = 'X'
  COMPUTER_MARK = 'O'
  FIRST_TO_MOVE = HUMAN_MARK

  def player_moves
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
    toggle_current_mark
  end

  def human_turn?
    @current_mark == HUMAN_MARK
  end

  def toggle_current_mark
    @current_mark = human_turn? ? COMPUTER_MARK : HUMAN_MARK
  end

  def human_moves
    display_available_moves

    choice = nil
    loop do
      choice = gets.chomp.to_i
      break if board.unmarked_square_keys.include?(choice)
      puts "Sorry, that's not a valid choice."
    end

    board[choice] = human.mark
  end

  def computer_moves
    choice = board.unmarked_square_keys.sample
    board[choice] = computer.mark
  end
end



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

  def reset
    (1..9).each { |key| squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def []=(key, mark)
    @squares[key].mark = mark
  end

  def unmarked_square_keys
    squares.keys.select { |key| squares[key].unmarked? }
  end

  def full?
    unmarked_square_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |keys|
      return squares[keys.first].mark if winning_line?(keys)
    end
    nil
  end

  private

  def winning_line?(keys)
    all_marked?(keys) && all_same_mark?(keys)
  end

  def all_marked?(keys)
    keys.all? { |key| squares[key].marked? }
  end

  def all_same_mark?(keys)
    squares.values_at(*keys).map(&:mark).uniq.size == 1
  end
end



class Square # SQUARE # SQUARE # SQUARE
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

  def marked?
    mark != INITIAL_MARK
  end
end



class Player # PLAYER # PLAYER # PLAYER
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
end



class TTTGame # GAME GAME GAME GAME GAME
  include DisplayMethods, MoveMethods

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARK)
    @computer = Player.new(COMPUTER_MARK)
    @current_mark = FIRST_TO_MOVE
  end

  def play
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_moves
      display_result
      break unless play_again?
      reset
      display_play_again_message
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

  def reset
    board.reset
    @current_mark = FIRST_TO_MOVE
    clear_screen
  end
end

game = TTTGame.new
game.play
