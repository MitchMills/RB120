class Participant
  WINNING_TOTAL = 21

  attr_accessor :hand

  def initialize
    @hand = Hand.new
  end

  def display_hand
    puts hand.cards
  end

  def display_total
    puts hand.total
  end

  def busted?
    hand.total > WINNING_TOTAL
  end
end

class Player < Participant
  def initialize
    super
    @name = 'You'
  end
end

class Dealer < Participant
  LIMIT = 17

  def initialize
    super
    @name = 'The dealer'
  end

  def display_hand
    puts hand.cards.first
    puts "Face down card"
    puts hand.cards[2..-1]
  end

  def display_total
    puts hand.total - hand[1].value
  end

  def display_revealed_hand
    puts hand.cards
  end

  def display_revealed_total
    puts hand.total
  end
end



class Hand
  attr_accessor :cards

  def initialize
    @cards = []
    @total = 0
  end

  def [](index)
    cards[index]
  end

  def <<(card)
    cards << card
  end

  def total
    cards.map { |card| card.value }.sum
  end
end




class Deck
  SUITS = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
  RANKS = ('2'..'10').to_a + %w(Jack Queen King Ace)
  OPENING_HAND_SIZE = 2

  attr_accessor :cards

  def initialize(number_of_decks = 1)
    @cards = create(number_of_decks)
  end

  def create(number_of_decks)
    cards = []

    RANKS.each do |rank|
      SUITS.each { |suit| cards << Card.new(rank, suit) }
    end

    (cards * number_of_decks).shuffle
  end

  def deal_opening_hands(player, dealer)
    OPENING_HAND_SIZE.times do |_|
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
      11
    else
      10
    end
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
    puts @player.display_total
    puts
    @dealer.display_hand
    puts @dealer.display_total
  end

  def show_all_cards(participant)
    participant.display_hand
    puts participant.hand.total
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
