class Participant
  attr_accessor :hand

  def initialize
    @hand = Hand.new
  end

  def display_hand
    puts @hand.cards
  end

  def busted?
    @hand.score > 21
  end
end

class Player < Participant
  def initialize
    super
    @name = 'You'
  end
end

class Dealer < Participant
  def initialize
    super
    @name = 'The dealer'
  end

  def display_hand
    puts hand.cards.first
    puts "Face down card"
  end
end



class Hand
  attr_reader :cards

  def initialize
    @cards = []
    @score = 0
  end

  def <<(card)
    @cards << card
  end

  def score
    self.cards.map { |card| card.value }.sum
  end
end




class Deck
  attr_accessor :cards

  SUITS = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
  RANKS = ('2'..'10').to_a + %w(Jack Queen King Ace)

  def initialize(number_of_decks = 1)
    @cards = create(number_of_decks)
  end

  def create(number_of_decks)
    cards = []

    RANKS.each do |rank|
      SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end
    (cards * number_of_decks).shuffle
  end

  def deal_opening_hands(player, dealer)
    2.times do |_|
      [player, dealer].each { |recipient| deal_one_card!(recipient) }
    end
  end

  def deal_one_card!(recipient)
    recipient.hand << @cards.pop
  end
end


class Card
  attr_reader :rank

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = value
  end

  def value
    if ('2'..'10').include?(@rank)
      @rank.to_i
    elsif @rank == 'Ace'
      ace_value
    else
      10
    end
  end

  def ace_value
    11
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end




class TwentyOne

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    # dealer_turn
    # show_result
  end

  def deal_cards
    @deck.deal_opening_hands(@player, @dealer)
  end

  def show_initial_cards
    @player.display_hand
    puts @player.hand.score
    puts
    @dealer.display_hand
    puts @dealer.hand.score
  end

  def show_all_cards(participant)
    participant.display_hand
    puts participant.hand.score
    puts
  end

  def player_turn
    loop do
      break puts "Busted!" if @player.busted?
      puts "hit or stay?"
      choice = gets.chomp
      break unless choice == 'hit'
      @deck.deal_one_card!(@player)
      show_all_cards(@player)
    end
  end
end

system 'clear'
TwentyOne.new.start
