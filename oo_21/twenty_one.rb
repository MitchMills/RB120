module GameSettings
  CARD_SUITS = %w(Spades Hearts Diamonds Clubs)
  CARD_RANKS = ('2'..'10').to_a + %w(Jack Queen King Ace)
  CARDS_IN_ONE_DECK = CARD_SUITS.size * CARD_RANKS.size

  DECKS_IN_GAME = 1
  CARDS_IN_GAME = (CARDS_IN_ONE_DECK * DECKS_IN_GAME)
  CARDS_IN_FIRST_DEAL = 2
  RESHUFFLE_TRIGGER = 0.25

  TARGET_TOTAL = 21
  DEALER_STAY_TOTAL = 17

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


module Formatting
  def clear_screen
    system 'clear'
  end

  def blank_line(number = 1)
    number.times { puts }
  end
end


module Displayable
  include GameSettings

  def display_opening_deal
    puts "Here's the deal:"
    cards = opening_deal_cards

    cards.each_with_index do |card, index|
      subject_verb = index.even? ? '  You get' : '    The dealer gets'
      final_index = cards.size - 1
      dealt_card = index == final_index ? 'a face-down card' : "the #{card}"

      puts "#{subject_verb} #{dealt_card}."
    end
    blank_line
  end

  def opening_deal_cards
    last_index = CARDS_IN_FIRST_DEAL - 1
    (0..last_index).flat_map do |index|
      [player.hand[index], dealer.hand[index]]
    end
  end

  def display_hands(facedown_card: false)
    [dealer, player].each do |participant|
      hide_card = facedown_card && participant == dealer
      participant.display_hand(facedown_card: hide_card)
      participant.display_total(facedown_card: hide_card)
      blank_line
    end
  end

  def display_stayed(participant)
    subject = participant == player ? 'You' : 'The dealer'
    puts "#{subject} chose to stay."
  end
end


class Participant
  include GameSettings

  attr_accessor :hand, :name

  def initialize
    @hand = Hand.new
  end

  def to_s
    name
  end

  def hit!(card)
    hand << card
  end

  def display_hand(facedown_card: false)
    participant = self.class == Player ? "YOUR" : "THE DEALER'S"
    puts "#{participant} HAND:"

    hand.cards.each_with_index do |card, index|
      facedown_index = CARDS_IN_FIRST_DEAL - 1
      facedown = facedown_card && index == facedown_index
      puts facedown ? "  Face-down card" : "  #{card}"
    end
  end

  def display_total(facedown_card: false)
    label = facedown_card ? 'VISIBLE TOTAL' : 'TOTAL'
    total = facedown_card ? hand.visible_total : hand.total

    puts "#{label}: #{total}"
  end
end


class Player < Participant
  def initialize
    super
    @name = 'Mitch'
  end

  def choose_name
    'Mitch'
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
    deck.number_of_cards < (CARDS_IN_GAME * RESHUFFLE_TRIGGER)
  end
end



class Hand
  include GameSettings

  attr_accessor :cards

  def initialize
    @cards = []
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
    raw_total = cards.map(&:value).sum
    adjust_for_aces(raw_total)
  end

  def visible_total
    last_visible_index = CARDS_IN_FIRST_DEAL - 2
    self[0..last_visible_index].map(&:value).sum
  end

  def adjust_for_aces(total)
    number_of_aces = cards.count { |card| card.rank == 'Ace'}
    number_of_aces.times { total -= 10 if total > TARGET_TOTAL}
    total
  end
end




class Deck
  include GameSettings

  attr_accessor :cards

  def initialize
    @cards = reshuffle
  end

  def reshuffle
    cards = (create_one_deck * DECKS_IN_GAME).shuffle
  end

  def create_one_deck
    CARD_RANKS.each_with_object([]) do |rank, deck|
      CARD_SUITS.each { |suit| deck << Card.new(rank, suit) }
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
  include GameSettings, Formatting, Displayable

  attr_accessor :player, :dealer

  def initialize
    clear_screen
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    intro
    opening_hands
    player_turn
    # dealer_turn
    # result
  end



  def intro
    puts "Welcome to Twenty-One!"
    print "Enter any key to start: "
    gets
    blank_line
  end

  def opening_hands
    dealer.deal_opening_hands!(player)
    display_opening_deal
    display_hands(facedown_card: true)
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
        blank_line
      end

      break display_stayed(player) if choice == 's'

      clear_screen
      player.hit!(dealer.deal_one_card!)
      display_hit(participant)
      display_hands(facedown_card: true)
    end
  end


  def dealer_turn
    loop do
      show_all_cards(dealer)
      break display_turn_finished(dealer) if dealer.turn_finished?
      dealer.hit!(dealer.deal_one_card!)
    end
    display_hands
    display_stayed(dealer)
  end

  def display_hit(participant)
    subject = participant == player ? 'You' : 'The dealer'
    puts "#{subject} chose to hit."
    puts "#{subject} got the #{participant.hand[-1]}."
    blank_line
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

TwentyOne.new.start
