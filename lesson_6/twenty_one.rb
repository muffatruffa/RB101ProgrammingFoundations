# A Deck is an array of all cards
# a card is a two element array first represent the suit second the rank
# a card rank is an integer form 1 to 13
# a card suit is a symbol
# [[:hearts, 2], [:clubs, 1]......]

RANKS = (1..13).to_a
SUITS = [:hearts, :diamonds, :clubs, :spades]
PLAYERS = [:dealer, :user]
FIRST_TURN_CRDS = 2
BUST_VAL = 21
DEALER_STOP = 17

def initilize_deck
  deck = []
  SUITS.each do |suit|
    RANKS.each { |rank| deck << [suit, rank] }
  end
  deck
end

def add_card!(deck, player_cards)
  player_cards << deck.pop
end

def start_player_cards!(deck, player_cards)
  FIRST_TURN_CRDS.times { |_| add_card!(deck, player_cards) }
end

def display_turn_cards(user:, dealer:)
  display_message("Dealer has: #{joinor(dealer[1..-1], ' ,', '')} and unkown")
  display_message("You have: #{joinor(user)}")
  display_message 'Stay or Hit? (enter stay or hit)'
end

def display_message(msg)
  puts "=> #{msg}"
end

def joinor(cards, separator=', ', and_or='and')
  len = cards.size
  case len
  when 0
    ''
  when 1
    card_to_s(cards[0])
  when 2
    card_to_s(cards[0]) + " #{and_or} " + card_to_s(cards[1])
  else
    cards = cards.map { |card| card_to_s(card) }
    cards[0..-2].join(separator) + " #{and_or} " + cards[-1]
  end
end

def player_stay?(answer)
  loop do
    break if answer.downcase == 'stay' || answer.downcase == 'hit'
    display_message("Sorry #{answer} it's not a valid choise.")
    display_message("Enter stay or hit please.")
    answer = gets.chomp
  end
  answer.downcase == 'stay'
end

def player_busted?(player_cards)
  player_cards_sum(player_cards) > BUST_VAL
end

def player_cards_sum(player_cards)
  ranks = rank_vals(player_cards)
  cards_values(ranks).sum
end

def rank_val(rank)
  case rank
  when 11, 12, 13 then 10
  else RANKS[rank - 1]
  end
end

def rank_vals(cards)
  cards.map { |card| card[1] }
end

def cards_values(ranks)
  ranks.each_index.map do |index|
    val = rank_val(ranks[index])
    if ranks[index] == 1 && ranks[0, index].count(1).zero?
      ranks_sum = ranks.inject(0) { |sum, rank| sum + rank_val(rank) } - 1
      val = 11 if ranks_sum + 11 <= BUST_VAL
    end
    val
  end
end

def player_hit!(deck, player_cards)
  add_card!(deck, player_cards)
end

def display_end_game(dealer:, user:, busted: nil)
  user_sc = player_cards_sum(user)
  dealer_sc = player_cards_sum(dealer)
  display_message("Dealer has: #{joinor(dealer)}")
  display_message("Dealer scored: #{dealer_sc}")
  display_message("You have: #{joinor(user)}")
  display_message("You scored: #{user_sc}")
  if busted
    busted = busted == :dealer ? 'Dealer' : 'You'
    display_message "#{busted} busted!"
  elsif user_sc == dealer_sc
    display_message "It's a tie!"
  else
    winner = user_sc > dealer_sc ? 'You' : 'Dealer'
    display_message "#{winner} won!"
  end
end

def card_to_s(card)
  "#{rank_to_s(card[1])} of #{card[0].to_s.capitalize}"
end

def rank_to_s(rank)
  case rank
  when 1 then 'Ace'
  when 11 then 'Jack'
  when 12 then 'Qeen'
  when 13 then 'King'
  else RANKS[rank - 1].to_s
  end
end

def play_again?(y_n)
  will_play = true
  loop do
    answer = y_n.downcase
    if answer == 'n' || answer == 'y'
      will_play = false if y_n == 'n'
      break
    else
      display_message "Sorry #{y_n} is not a valid answer"
      display_message "Enter y if you want to play again otherwise enter n."
      y_n = gets.chomp
    end
  end
  will_play
end

def display_welcome
  display_message "Hello, welcome to Twenty-One."
end

if __FILE__ == $PROGRAM_NAME
  welcome = true
  loop do
    system('clear') || system('cls')
    display_welcome if welcome
    welcome = false
    user_cards = []
    dealer_cards = []

    deck = initilize_deck.shuffle

    dealer = PLAYERS[0]
    user = PLAYERS[1]

    start_player_cards!(deck, user_cards)
    start_player_cards!(deck, dealer_cards)

    loop do
      display_turn_cards(user: user_cards, dealer: dealer_cards)
      answer = gets.chomp
      break if player_stay?(answer)
      player_hit!(deck, user_cards)
      break if player_busted?(user_cards)
    end

    busted = nil
    if player_busted?(user_cards)
      busted = user
    else
      display_message "You stayed, It's dealer time!'"
      loop do
        if player_cards_sum(dealer_cards) > DEALER_STOP ||
           player_busted?(dealer_cards)
          break
        else
          player_hit!(deck, dealer_cards)
        end
      end
      busted = dealer if player_busted?(dealer_cards)
    end

    display_end_game(dealer: dealer_cards, user: user_cards, busted: busted)
    display_message "Do you want to play again? (y / n)"
    answer = gets.chomp
    break unless play_again?(answer)
  end
  display_message "Thank you for playing Twenty-One"
end
