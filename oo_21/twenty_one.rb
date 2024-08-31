module TwentyOneRules
  TARGET_TOTAL = 21
  DEALER_STAY_TOTAL = 17
  CARDS_IN_FIRST_DEAL = 2

  DECKS_IN_GAME = 1
  RESHUFFLE_TRIGGER = 0.25
end




class Participant
  include TwentyOneRules

  attr_accessor :hand

  def initialize
    @hand = Hand.new
  end

  def to_s
    name
  end

  def display_hand
    puts "#{self.name.upcase}'S CARDS:"
    hand.cards.each { |card| puts "  #{card}"}
  end

  def display_total
    puts "TOTAL: #{hand.total}"
  end

  def turn_over?
    self.blackjack? || self.twenty_one? || self.busted?
  end

  def blackjack?
    hand.number_of_cards == CARDS_IN_FIRST_DEAL && hand.total == TARGET_TOTAL
  end

  def twenty_one?
    hand.number_of_cards > CARDS_IN_FIRST_DEAL && hand.total == TARGET_TOTAL
  end

  def busted?
    hand.total > TARGET_TOTAL
  end
end

class Player < Participant
  attr_reader :name

  def initialize
    super
    @name = 'Player'
  end
end

class Dealer < Participant
  attr_reader :name

  def initialize
    super
    @name = 'Dealer'
  end

  def display_hand
    visible_cards = hand.cards.map(&:itself) # necessary?
    visible_cards[1] = "Face down card"

    puts "#{self.name.upcase}'S CARDS:"
    visible_cards.each { |card| puts "  #{card}"}
  end

  def display_total
    puts "VISIBLE TOTAL: #{hand[0].value + hand[2..-1].map(&:value).sum}"
  end

  def display_revealed_hand
    Participant.display_hand # works?
  end

  def display_revealed_total
    Participant.display_total # works?
  end
end



class Hand
  attr_accessor :cards, :total

  def initialize
    @cards = []
    @total = 0
  end

  def number_of_cards
    cards.size
  end

  def [](index)
    cards[index]
  end

  def <<(card)
    cards << card
  end

  def total
    raw_total = cards.map { |card| card.value }.sum
    adjust_for_aces(raw_total)
  end

  def adjust_for_aces(total)
    number_of_aces = cards.count { |card| card.rank == 'Ace'}
    number_of_aces.times { total -= 10 if total > TwentyOneRules::TARGET_TOTAL}
    total
  end
end




class Deck
  include TwentyOneRules

  SUITS = %w(Spades Hearts Diamonds Clubs)
  RANKS = ('2'..'10').to_a + %w(Jack Queen King Ace)
  CARDS_IN_ONE_DECK = SUITS.size * RANKS.size
  CARDS_IN_GAME = CARDS_IN_ONE_DECK * DECKS_IN_GAME

  attr_accessor :cards

  def initialize
    @cards = reshuffle
  end

  def create_one_deck
    cards = []

    RANKS.each do |rank|
      SUITS.each { |suit| cards << Card.new(rank, suit) }
    end

    cards
  end

  def deal_opening_hands(player, dealer)
    CARDS_IN_FIRST_DEAL.times do |_|
      [player, dealer].each { |recipient| deal_one_card!(recipient) }
    end
  end

  def deal_one_card!(recipient)
    recipient.hand << @cards.pop
  end

  def reshuffle
    cards = (create_one_deck * DECKS_IN_GAME).shuffle
  end

  def time_to_reshuffle?
    cards.size < CARDS_IN_GAME * RESHUFFLE_TRIGGER
  end
end


class Card
  attr_reader :rank, :suit, :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = calculate_value
  end

  def calculate_value
    if ('2'..'10').include?(rank)
      rank.to_i
    elsif rank == 'Ace'
      11
    else
      10
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end




class TwentyOne
  include TwentyOneRules

  attr_reader :player, :dealer, :deck

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
    deck.deal_opening_hands(player, dealer)
  end

  def show_initial_cards
    player.display_hand
    puts player.display_total
    puts
    dealer.display_hand
    puts dealer.display_total
  end

  def show_all_cards(participant)
    participant.display_hand
    puts participant.display_total
    puts
  end

  def player_turn
    loop do
      break display_turn_over(player) if player.turn_over? # NOT WORKING

      choice = nil
      loop do
        print "Do you want to hit or stay? (enter 'h' or 's'): "
        choice = gets.chomp.downcase
        break if %w(h s).include?(choice)
        puts "Sorry, you must enter 'h', or 's'."
        puts
      end
      break unless choice == 'h'
      puts
      @deck.deal_one_card!(player)
      show_all_cards(player)
    end
  end

  def display_turn_over(participant)
    if participant.blackjack?
      display_blackjack(participant)
    elsif participant.twenty_one?
      display_twenty_one(participant)
    elsif participant.busted?
      display_busted(participant)
    end
  end

  def display_blackjack(participant)
    puts "#{participant} has a blackjack!"
    puts
  end

  def display_twenty_one(participant)
    puts "#{participant}'s total is 21!"
    puts
  end

  def display_busted(participant)
    puts "#{participant} has busted!"
    puts
  end
end

system 'clear'
TwentyOne.new.start
