
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
ROW_LEN = 3
def display_board(brd)
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  spaces = ' ' * 2
  line_no_data = "#{spaces} #{spaces}|#{spaces} #{spaces}|#{spaces} #{spaces}"
  line_row = "#{'-' * 5}+#{'-' * 5}+#{'-' * 5}"
  puts ''
  puts line_no_data 
  puts "#{spaces}#{brd[1]}#{spaces}|#{spaces}#{brd[2]}#{spaces}|#{spaces}#{brd[3]}#{spaces}"
  puts line_no_data
  puts line_row 
  puts line_no_data
  puts "#{spaces}#{brd[4]}#{spaces}|#{spaces}#{brd[5]}#{spaces}|#{spaces}#{brd[6]}#{spaces}"
  puts line_no_data 
  puts line_row 
  puts line_no_data 
  puts "#{spaces}#{brd[7]}#{spaces}|#{spaces}#{brd[8]}#{spaces}|#{spaces}#{brd[9]}#{spaces}"
  puts line_no_data 
  puts ''
end

def initialize_board()
  (1..9).each_with_object({}) { |n, hash| hash[n] = INITIAL_MARKER}
end

def set_board_at!(brd, position, val)
  brd[position] = val
end

def empty_in_board(brd)
  brd.select {|k, v| v == INITIAL_MARKER}
end

def available_squares_str(brd)
  empty_in_board(brd).keys.join(', ')
end

def marked_in_board(brd)
  brd.reject {|k, v| v == INITIAL_MARKER}
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
  squares.each { |square| values << brd[square]  }
  values
end

def values_diagonal_at_2(brd)
  values = []
  squares = [3, 5, 7]
  squares.each{ |square| values << brd[square]}
  values
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

# return true if all values in vals
# are the string PLAYER_MARKER
def all_player?(vals)
  vals.all? {|val| val == PLAYER_MARKER}
end


# return true if all values in vals
# are the string COMPUTER_MARKER 
def all_computer?(vals)
  vals.all? {|val| val == COMPUTER_MARKER}
end

def computer_won?(brd)
  winning_combs(brd).each do |comb|
    return true if all_computer?(comb)
  end
  false
end

def player_won?(brd)
  winning_combs(brd).each do |comb|
    return true if all_player?(comb)
  end
  false
end

def valid?(brd, val)
  empty_in_board(brd).keys.include? val
end

def prompt(msg)
  puts msg
end

def player_places_piece(brd)
  square = nil
  loop do
    prompt "Choose a square (#{available_squares_str(brd)}):"
    square = gets.chomp.to_i
    break if valid?(brd,square)
    puts "Sorry #{square} is not a valid choice."
  end
  set_board_at!(brd,square, PLAYER_MARKER)
end

def computer_places_piece(brd)
  computer_choice = empty_in_board(brd).keys.sample
  set_board_at!(brd,computer_choice, COMPUTER_MARKER )
end


def board_full?(brd)
  empty_in_board(brd).empty?
end

if __FILE__ == $0
  loop do
    board = initialize_board
    is_a_tie = true

    display_board(board)
    loop do
      player_places_piece(board)
      if player_won?(board)
        puts "You won"
        display_board(board)
        is_a_tie = false
        break
      end
      computer_places_piece(board)
      if computer_won?(board)
        puts 'Computer won'
        display_board(board)
        is_a_tie = false
        break
      end
      break if board_full?(board)
      system 'clear'
      display_board(board)
    end

    if is_a_tie
      puts 'It is a tie'
      display_board(board)
    end

    prompt('Play again?(y,n)')
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end


