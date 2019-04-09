
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
GAME = 5


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

def user_stay?(answer)
  answer == 's'
end

def retrieve_hit_stay_answer
  puts
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

def display_players_cards(user_cards, dealer_cards)
  puts
  display_cards(user_cards, introduce: 'You have ', new_line: "")
  display_scores(user_cards, introduce: ' and you scored ')
  display_cards(dealer_cards, introduce: 'Dealer has ', new_line: "")
  display_scores(dealer_cards, introduce: ' and scored ')
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

def display_scores(cards, introduce: "", new_line: "\n")
  cards = player_cards_sum(cards).to_s
  print(introduce + cards + new_line)
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

def game_winner(players_round)
  game_winner = nil
  scored_five = players_round.select { |_, score| score == GAME }
  unless scored_five.empty?
    game_winner = scored_five.keys[0]
    game_winner = game_winner == :dealer ? 'Dealer' : 'You'
  end
  game_winner
end

def retrieve_another_game_answer(gm_winner)
  display_message "#{gm_winner} won #{GAME} rounds."
  display_message "Do you want to play another game? (y / n)"
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

def retrieve_play_again_answer
  puts
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
  display_message 'Evry 5 round a player win he/she win a game.'
end

def scored_21?(players_total, player)
  player_cards_total(players_total, player) == 21
end

def user_turn(user_cards, dealer_cards, deck, players_total, user)
  loop do
    break if scored_21?(players_total, user)
    display_turn_cards(user: user_cards, dealer: dealer_cards)
    answer = retrieve_hit_stay_answer
    break if user_stay?(answer)
    player_hit!(deck, user_cards, players_total, user)
    break if player_busted?(players_total, user)
  end
end

def dealer_turn(dealer_cards, deck, players_total, dealer)
  loop do
    break if player_busted?(players_total, dealer)
    break if scored_21?(players_total, dealer)
    if player_cards_total(players_total, dealer) > DEALER_STOP
      display_message('Dealer stays.')
      break
    end
    display_message "Dealer hit!"
    player_hit!(deck, dealer_cards, players_total, dealer)
    sleep(1)
    dl_cards = joinor(dealer_cards[1..-1], ', ', '')
    display_message("Dealer has now: #{dl_cards} and unkown")
    sleep(1)
  end
end

def retrieve_result(user_cards, dealer_cards, user, dealer)
  res = Hash.new
  user_scores = player_cards_sum(user_cards)
  dealer_scores = player_cards_sum(dealer_cards)
  if user_scores > 21
    res[:busted] = user
  elsif dealer_scores > 21
    res[:busted] = dealer
  elsif dealer_scores < user_scores
    res[:winner] = user
  elsif dealer_scores > user_scores
    res[:winner] = dealer
  else
    res[:tie] = :tie
  end
  res
end

def add_round_winner(round_res, players_round)
  winner = nil
  if round_res.has_key?(:busted)
    winner = round_res[:busted] == :dealer ? :user : :dealer
	end
	winner = round_res[:winner] if round_res.has_key?(:winner)
  players_round[winner] += 1 if winner
end

def display_end_result(res_hash)
  case res_hash.keys[0]
  when :busted then display_busted(res_hash[:busted])
  when :tie then display_tie
  else display_winner(res_hash[:winner])
  end
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
    deck = initilize_deck.shuffle
    dealer = PLAYERS[0]
    user = PLAYERS[1]
    players_total = Hash.new(0)

    start_player_cards!(deck, user_cards, players_total, user)
    start_player_cards!(deck, dealer_cards, players_total, dealer)

    if scored_21?(players_total, user) && scored_21?(players_total, dealer)
      display_players_cards(user_cards, dealer_cards)
      display_tie
    end

    user_turn(user_cards, dealer_cards, deck, players_total, user)

    unless player_busted?(players_total, user) || scored_21?(players_total, user)
      display_message "You stayed, It's dealer time!'"
      dealer_turn(dealer_cards, deck, players_total, dealer)
    end

    round_result = retrieve_result(user_cards, dealer_cards, user, dealer)
    add_round_winner(round_result, players_round)
    display_players_cards(user_cards, dealer_cards)
    display_end_result(round_result)

    g_winner = game_winner(players_round)
    answer = if g_winner
               players_round = Hash.new(0)
               retrieve_another_game_answer(g_winner)
             else
               retrieve_play_again_answer
             end
    break unless play_again?(answer)
  end
  display_message "Thank you for playing Twenty-One"
end
