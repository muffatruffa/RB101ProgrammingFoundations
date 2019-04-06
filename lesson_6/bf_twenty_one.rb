# A Deck is an array of all cards
# a card is a two element array first represent the suit second the rank
# a card rank is an integer form 1 to 13
# a card suit is a symbol
# [[:hearts, 2], [:clubs, 1]......]

RANKS = (1..13).to_a
SUITS = [:hearts, :diamonds, :clubs, :spades]
PLAYERS = [:dealer, :user]
FIRST_TURN_CRDS = 2
WIN_VAL = 21
DEALER_STOP = 17

def initilize_deck
  deck = []
  SUITS.each do |suit|
    RANKS.each { |rank| deck << [suit, rank] }
  end
  deck
end

def add_card!(deck, player_cards, players_total, player)
  player_cards << deck.pop
  players_total[player] = player_cards_sum(player_cards)
end

def player_cards_total(players_total, player)
  players_total[player]
end

def start_player_cards!(deck, player_cards, players_total, player)
  FIRST_TURN_CRDS.times do |_|
    add_card!(deck, player_cards, players_total, player)
  end
end

def display_turn_cards(user:, dealer:)
  display_message("Dealer has: #{joinor(dealer[1..-1], ', ', '')} and unkown")
  display_message("You have: #{joinor(user)}")
end

def display_message(msg, new_line: "\n")
  print "=> #{msg}" + new_line
  $stdout.flush
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

def user_saty?(answer)
  answer == 's'
end

def retrieve_hit_stay_answer
  display_message 'Stay or Hit? (s / h)'
  answer = gets.chomp
  loop do
    break if answer.downcase == 's' || answer.downcase == 'h'
    display_message("sorry #{answer} it's not a valid choise.")
    display_message("enter s to stay  or h to  hit please.")
    answer = gets.chomp
  end
  answer.downcase
end

def player_busted?(players_total, player)
  player_cards_total(players_total, player) > WIN_VAL
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
      val = 11 if ranks_sum + 11 <= WIN_VAL
    end
    val
  end
end

def player_hit!(deck, player_cards, players_total, player)
  add_card!(deck, player_cards, players_total, player)
end

def display_game_result(user_cards, dealer_cards, players_total, user, dealer)
  display_cards(user_cards, introduce: 'You have ', new_line: "")
  display_scores(players_total, user, introduce: ' and you scored ')
  display_cards(dealer_cards, introduce: 'Dealer has ', new_line: "")
  display_scores(players_total, dealer, introduce: ' and  scored ')
end

def display_winner_21(winner, user_scores, dealer_scores)
  if user_scores == dealer_scores
    display_message "Both players reached 21."
    display_tie
  else
    winner = winner == :dealer ? 'Dealer' : 'You'
    display_message "#{winner} reached 21 and won!"
  end
end

def display_busted(busted)
  busted = busted == :dealer ? 'Dealer' : 'You'
  winner = busted == 'Dealer' ? 'You' : 'Dealer'
  display_message "#{busted} busted #{winner} won!"
end

def display_tie
  display_message "It's a tie!'"
end

def display_winner(winner)
  winner = winner == :dealer ? 'Dealer' : 'You'
  display_message "#{winner} won!"
end

def display_cards(cards, introduce: '', new_line: "\n")
  display_message(introduce + joinor(cards), new_line: new_line)
end

def display_scores(players_total, player, introduce: "", new_line: "\n")
  scores = player_cards_total(players_total, player).to_s
  print(introduce + scores + new_line)
end

def card_to_s(card)
  "#{rank_to_s(card[1])} of #{card[0].to_s.capitalize}"
end

def rank_to_s(rank)
  case rank
  when 1 then 'Ace'
  when 11 then 'Jack'
  when 12 then 'Queen'
  when 13 then 'King'
  else RANKS[rank - 1].to_s
  end
end

def play_again?(answer)
  answer == 'y'
end

def retrieve_play_again_answer
  display_message "Do you want to play again? (y / n)"
  answer = gets.chomp
  loop do
    if answer.downcase == 'n' || answer.downcase == 'y'
      break
    else
      display_message "Sorry #{answer} is not a valid choise."
      display_message "Enter y if you want to play again otherwise enter n."
      answer = gets.chomp
    end
  end
  answer.downcase
end

def display_welcome
  display_message "Hello, welcome to Twenty-One."
end

def scored_21?(players_total, player)
  player_cards_total(players_total, player) == 21
end

if __FILE__ == $PROGRAM_NAME
  welcome = true
  players_round = Hash.new(0)
  loop do
    system('clear') || system('cls')
    display_welcome if welcome
    welcome = false
    user_cards = []
    dealer_cards = []
    players_total = Hash.new(0)

    deck = initilize_deck.shuffle

    dealer = PLAYERS[0]
    user = PLAYERS[1]

    start_player_cards!(deck, user_cards, players_total, user)
    start_player_cards!(deck, dealer_cards, players_total, dealer)
    winner21 = nil

    loop do
      break if scored_21?(players_total, user)
      display_turn_cards(user: user_cards, dealer: dealer_cards)
      answer = retrieve_hit_stay_answer
      break if user_saty?(answer)
      player_hit!(deck, user_cards, players_total, user)
      break if player_busted?(players_total, user)
    end

    busted = nil
    if player_busted?(players_total, user)
      busted = user
    elsif scored_21?(players_total, user)
      winner21 = user
    else
      display_message "You stayed, It's dealer time!'"
      loop do
        if player_cards_total(players_total, dealer) > DEALER_STOP ||
           player_busted?(players_total, dealer) ||
           scored_21?(players_total, dealer)
          break
        else
          display_message "Dealer hit!"
          player_hit!(deck, dealer_cards, players_total, dealer)
          sleep(1)
          dl_cards = joinor(dealer_cards[1..-1], ', ', '')
          display_message("Dealer has now: #{dl_cards} and unkown")
          sleep(2)
        end
      end
      busted = dealer if player_busted?(players_total, dealer)
      winner21 = dealer if scored_21?(players_total, dealer)
      unless busted || winner21
        sleep(0.5)
        display_message('Dealer stays.')
      end
    end

    display_game_result(user_cards, dealer_cards, players_total, user, dealer)
    user_scores = player_cards_total(players_total, user)
    dealer_scores = player_cards_total(players_total, dealer)
    unless winner21 || busted
      turn_winner = user_scores > dealer_scores ? user : dealer
      unless user_scores == dealer_scores
        display_winner(turn_winner)
        players_round[turn_winner] += 1
      end
      display_tie if user_scores == dealer_scores
    end
    if winner21
      players_round[winner21] += 1
      display_winner_21(winner21, user_scores, dealer_scores)
    end
    if busted
      display_busted(busted)
      winner = busted == :dealer ? :user : :dealer
      players_round[winner] += 1
    end
    puts players_round

    answer = retrieve_play_again_answer
    break unless play_again?(answer)
  end
  display_message "Thank you for playing Twenty-One"
end
