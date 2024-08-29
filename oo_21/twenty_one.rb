class Participant
  attr_accessor :hand

  def initialize
    @hand = []
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
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = value(rank)
  end

  def value(rank)
    if ('2'..'10').include?(rank)
      rank.to_i
    elsif rank == 'Ace'
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




class Game

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end

  def deal_cards
    @deck.deal_opening_hands(@player, @dealer)
  end

  def show_initial_cards
    puts @player.hand
    puts @dealer.hand
  end
end

Game.new.start
