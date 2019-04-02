
# A Deck is an array of all cards
# a card is a two element array first represent the suit second the rank
# a card rank is an integer form 1 to 13
# [[:hearts, 2], [:clubs, 1]......]

RANKS = (1..13).to_a
SUITS = [:hearts, :diamonds, :clubs, :spades]

def initilize_deck
  deck = []
  SUITS.each do |suit|
    RANKS.each {|rank| deck << [suit, rank]}
  end
  deck
end

player_cards = []
dealer_cards = []

deck = initilize_deck.shuffle


