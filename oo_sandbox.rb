RANKS = ('2'..'10').to_a + %w(Jack Queen King Ace)

SUITS = ['Spades', 'Hearts', 'Diamonds', 'Clubs']

deck = []

SUITS.each do |suit|
  RANKS.each do |rank|
    deck << "#{rank} of #{suit}"
  end
end

p deck
