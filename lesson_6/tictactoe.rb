# require 'pry'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
ROW_LEN = 3
WINNING_SCORE = 5
FIRST_PLAYER = 'choose'

# Accessing board helpers

def empty_in_board(brd)
  brd.select { |_, v| v == INITIAL_MARKER }
end

# return Array of values in board
# for a given row.
# rows are numbered starting at zero
# row supposed to be 0 or 1 or 2
def values_at_row(brd, row)
  values = []
  first_square = row * ROW_LEN + 1
  last_square = first_square + ROW_LEN - 1
  (first_square..last_square).each { |n| values << brd[n] }
  values
end

def values_at_col(brd, col)
  values = []
  first_square = col + 1
  last_square = first_square + 2 * ROW_LEN
  (first_square..last_square).step(3).each do |n|
    values << brd[n]
  end
  values
end

def values_diagonal_at_0(brd)
  values = []
  squares = [1, 5, 9]
  squares.each { |square| values << brd[square] }
  values
end

def values_diagonal_at_2(brd)
  values = []
  squares = [3, 5, 7]
  squares.each { |square| values << brd[square] }
  values
end

# return the number of the column
# in a bord given the square number
# position column 0 row  0 is square 1 position column 2 row  2
# is square 9
def square_to_column(sqr)
  sqr % ROW_LEN == 0 ? ROW_LEN - 1 : (sqr % ROW_LEN) - 1
end

# return the number of the row
# in a bord given the square number
# position column 0 row  0 is square 1 position column 2 row  2
# is square 9
def square_to_row(sqr)
  col = square_to_column(sqr)
  (sqr - col - 1) / ROW_LEN
end

def winning_combs(brd)
  combs = []
  rows_cols = (0..2)
  rows_cols.each do |n|
    combs << values_at_row(brd, n)
    combs << values_at_col(brd, n)
  end
  combs << values_diagonal_at_0(brd)
  combs << values_diagonal_at_2(brd)
end

# Bang and setters board helpers

def initialize_board
  (1..9).each_with_object({}) { |n, hash| hash[n] = INITIAL_MARKER }
end

def set_board_at!(brd, position, val)
  brd[position] = val
end

# Predicates

def diagonal_at_0?(sqr)
  diagonal0 = [1, 5, 9]
  diagonal0.include?(sqr)
end

def diagonal_at_2?(sqr)
  diagonal2 = [3, 5, 7]
  diagonal2.include?(sqr)
end

def player_one_move_left?(ar)
  ar.count(PLAYER_MARKER) == 2
end

def computer_one_move_left?(ar)
  ar.count(COMPUTER_MARKER) == 2
end

# return true if all values in vals
# are the string PLAYER_MARKER
def all_player?(vals)
  vals.all? { |val| val == PLAYER_MARKER }
end

# return true if all values in vals
# are the string COMPUTER_MARKER
def all_computer?(vals)
  vals.all? { |val| val == COMPUTER_MARKER }
end

def someone_won?(brd)
  winning_combs(brd).each do |comb|
    return true if all_player?(comb) || all_computer?(comb)
  end
  false
end

def valid?(brd, val)
  empty_in_board(brd).keys.include? val
end

def player_valid?(pl)
  pl.downcase.start_with?('c', 'p')
end

def board_full?(brd)
  empty_in_board(brd).empty?
end

def game?(scores)
  winner = scores.select { |k, v| (k == :computer || k == :player) && v == 5 }
  !winner.empty?
end

# Display helpers string manipulation and prompt

def display_board(brd)
  row_line = '-----+-----+-----'
  empty_line = '     |     |     '
  puts empty_line
  puts display_board_row(brd, 0)
  puts empty_line
  puts row_line
  puts empty_line
  puts display_board_row(brd, 1)
  puts empty_line
  puts row_line
  puts empty_line
  puts display_board_row(brd, 2)
  puts empty_line
  puts ''
end

def display_board_row(brd, row)
  val = values_at_row(brd, row)
  format("  %s  |  %s  |  %s  ", val[0], val[1], val[2])
end

def display_scores(scores)
  prompt "Computer scores: #{scores[:computer]}"
  prompt "Player scores: #{scores[:player]}"
end

def display_end_game(winner)
  msg = { computer: 'Computer Won a game!', player: 'You won a game!' }
  message_key = winner.keys[0]
  prompt msg[message_key]
  prompt('Play a new game?(y,n)')
end

def display_end_turn(winner_or_tie)
  messages = {
    player: "You won!",
    computer: 'Computer won!',
    tie: 'It is a tie!'
  }
  prompt messages[winner_or_tie]
  prompt('Play again?(y,n)')
end

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(ar, separator=', ', and_or='or')
  len = ar.size
  case len
  when 0
    ''
  when 1
    ar[0].to_s
  when 2
    ar[0].to_s + " #{and_or} " + ar[1].to_s
  else
    ar[0..-2].join(separator) + " #{and_or} " + ar[-1].to_s
  end
end

# Computer AI in the game helpers

# return a square from board
# if there is a column or a row
# where there are two PLAYER_MARKER
# else nil
def defend_by_column_row(brd)
  empty_squares = empty_in_board(brd).keys
  empty_squares.each do |sqr_num|
    row = square_to_row(sqr_num)
    col = square_to_column(sqr_num)
    row_vals = values_at_row(brd, row)
    col_vals = values_at_col(brd, col)
    is_threat = player_one_move_left?(row_vals) ||
                player_one_move_left?(col_vals)
    return sqr_num if is_threat
  end
  nil
end

# return a square from board
# if there is a diagonal  where there are two PLAYER_MARKER
# else nil
def defend_by_diagonal(brd)
  empty_squares = empty_in_board(brd).keys
  empty_squares.each do |sqr_num|
    if diagonal_at_0?(sqr_num) &&
       player_one_move_left?(values_diagonal_at_0(brd))
      return sqr_num
    end
    if diagonal_at_2?(sqr_num) &&
       player_one_move_left?(values_diagonal_at_2(brd))
      return sqr_num
    end
  end
  nil
end

# return a square from board
# if there is a column  or a row
# where there are two COMPUTER_MARKER
# else nil
def computer_winning_col_row(brd)
  empty_squares = empty_in_board(brd).keys
  empty_squares.each do |sqr_num|
    row = square_to_row(sqr_num)
    col = square_to_column(sqr_num)
    row_vals = values_at_row(brd, row)
    col_vals = values_at_col(brd, col)
    return sqr_num if computer_one_move_left?(row_vals) ||
                      computer_one_move_left?(col_vals)
  end
  nil
end

# return a square from board
# if there is a diagonal  where there are two COMPUTER_MARKER
# else nil
def computer_winning_digonal(brd)
  empty_squares = empty_in_board(brd).keys
  empty_squares.each do |sqr_num|
    if diagonal_at_0?(sqr_num) &&
       computer_one_move_left?(values_diagonal_at_0(brd))
      return sqr_num
    end
    if diagonal_at_2?(sqr_num) &&
       computer_one_move_left?(values_diagonal_at_2(brd))
      return sqr_num
    end
  end
  nil
end

def corner_or_five_or_random(brd)
  empties = empty_in_board(brd).keys
  corners = [1, 3, 7, 9]
  empty_corners = corners & empties
  # if !empty_corners.empty?
  #   empty_corners.sample
  # elsif empties.include?(5)
  #   5
  # else
  #   empties.sample
  # end
  if empties.include?(5)
    5
  elsif !empty_corners.empty?
    empty_corners.sample
  else
    empties.sample
  end
end

# Logic for choosing the first player helpers

def choose_player
  player = ''
  loop do
    prompt 'Plaese enter the letter p if you want to play first.'
    prompt 'Or enter the letter c if you want the computer plays first.'
    player = gets.chomp
    break if player_valid?(player)
  end
  player = case player
           when /c/ then :computer
           else :player
           end
end

def initialize_player(current_player)
  current_player == 'choose' ? choose_player : FIRST_PLAYER
end

# Computer moves

def computer_places_piece!(brd)
  computer_choice = computer_winning_col_row(brd)
  computer_choice ||= computer_winning_digonal(brd)
  computer_choice ||= defend_by_column_row(brd)
  computer_choice ||= defend_by_diagonal(brd)
  computer_choice ||= corner_or_five_or_random(brd)
  set_board_at!(brd, computer_choice, COMPUTER_MARKER)
end

# Player moves

def player_places_piece!(brd)
  square = nil
  loop do
    squares_str = joinor(empty_in_board(brd).keys)
    prompt "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
    prompt "Choose a square (#{squares_str}):"
    square = gets.chomp.to_i
    break if valid?(brd, square)
    prompt "Sorry #{square} is not a valid choice."
  end
  set_board_at!(brd, square, PLAYER_MARKER)
end

# Player and Computer dinamic dispatch

def place_piece!(brd, player)
  return player_places_piece!(brd) if player == :player
  computer_places_piece!(brd)
end

def alternate_player(current_player)
  current_player == :player ? :computer : :player
end

# Inside main game helpers

def end_game_or_turn(scores, winner_or_tie)
  if game?(scores)
    display_end_game(scored_five(scores))
    scores = Hash.new { 0 }
  else
    display_end_turn(winner_or_tie)
  end
  scores
end

def scored_five(scores)
  scores.select { |k, v| (k == :computer || k == :player) && v == 5 }
end

# Turn inside a game

def play_turn(board, scores, current_player)
  loop do
    # clear screen and display board inside the turn
    system 'clear'
    display_board(board)
    place_piece!(board, current_player)
    if someone_won?(board)
      scores[current_player] += 1
      return current_player
    end
    if board_full?(board)
      return :tie
    end
    current_player = alternate_player(current_player)
  end
end

# Main loop game

def play_game
  scores = Hash.new { 0 }
  loop do
    board = initialize_board
    current_player = initialize_player(FIRST_PLAYER)
    winner_or_tie = play_turn(board, scores, current_player)
    # clear screen and display board after a turn
    system 'clear'
    display_board(board)

    display_scores(scores)
    scores = end_game_or_turn(scores, winner_or_tie)
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
  prompt "Thanks for playing Tic Tac Toe"
end

if __FILE__ == $PROGRAM_NAME
  play_game
end
