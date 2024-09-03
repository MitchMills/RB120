module TwentyOneRules
  TARGET_TOTAL = 21
  DEALER_STAY_TOTAL = 17
  CARDS_IN_FIRST_DEAL = 2

  DECKS_IN_GAME = 1
  RESHUFFLE_TRIGGER = 0.25

  def turn_finished?
    blackjack? || twenty_one? || busted?
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




class Participant
  include TwentyOneRules

  attr_accessor :hand

  def initialize
    @hand = Hand.new
  end

  def to_s
    name
  end

  def display_hand(hidden_card: false)
    puts "#{self.name.upcase}'S CARDS:"
    hand.cards.each_with_index do |card, index|
      puts hidden_card && index == 1 ? "  Face-down card" : "  #{card}"
    end
  end

  def display_total(hidden_card: false)
    label = hidden_card ? 'VISIBLE TOTAL' : 'TOTAL'
    total = hidden_card ? hand.visible_total : hand.total

    puts "#{label}: #{total}"
  end

  def hit!(card)
    hand << card
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
  attr_accessor :deck

  def initialize
    super
    @name = 'Dealer'
    @deck = Deck.new
  end

  def deal_opening_hands!(player)
    CARDS_IN_FIRST_DEAL.times do |_|
      [player, self].each { |recipient| recipient.hit!(deal_one_card!) }
    end
  end

  def deal_one_card!
    deck.remove_one_card!
  end

  def stay?
    hand.total >= DEALER_STAY_TOTAL
  end

  def reshuffle_deck
    deck.reshuffle
  end

  def time_to_reshuffle?
    deck.number_of_cards < Deck::CARDS_IN_GAME * RESHUFFLE_TRIGGER
  end
end



class Hand
  attr_reader :total
  attr_accessor :cards

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

  def visible_total
    self[0].value
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

  def reshuffle
    cards = (create_one_deck * DECKS_IN_GAME).shuffle
  end

  def create_one_deck
    RANKS.each_with_object([]) do |rank, cards|
      SUITS.each { |suit| cards << Card.new(rank, suit) }
    end
  end

  def number_of_cards
    cards.size
  end

  def remove_one_card!
    cards.pop
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

  attr_reader :player, :dealer

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    deal_opening_hands
    show_visible_cards
    player_turn
    # dealer_turn
    # show_result
  end

  def deal_opening_hands
    dealer.deal_opening_hands!(player)
  end

  def show_visible_cards
    [dealer, player].each do |participant|
      participant.display_hand(hidden_card: participant == dealer)
      participant.display_total(hidden_card: participant == dealer)
      puts
    end
  end

  def show_all_cards
    [dealer, player].each do |participant|
      participant.display_hand
      participant.display_total
      puts
    end
  end

  def player_turn
    loop do
      break display_turn_finished(player) if player.turn_finished?

      choice = nil
      loop do
        print "Do you want to hit or stay? (enter 'h' or 's'): "
        choice = gets.chomp.downcase
        break if %w(h s).include?(choice)
        puts "Sorry, you must enter 'h', or 's'."
        puts
      end
      break display_stayed(player) if choice == 's'

      system 'clear'
      display_hit(player)
      show_visible_cards
    end
  end


  def dealer_turn
    loop do
      show_all_cards(dealer)
      break display_turn_finished(dealer) if dealer.turn_finished?
      dealer.hit!(dealer.deal_one_card!)
    end
    show_all_cards(dealer)
    display_stayed(dealer)
  end

  def display_stayed(participant)
    puts "#{participant} has chosen to stay."
  end

  def display_hit(participant)
    puts "#{participant} has chosen to hit."
    card = dealer.deal_one_card!
    puts "#{participant} gets the #{card}."
    player.hit!(card)
    puts
  end

def display_turn_finished(participant)
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
