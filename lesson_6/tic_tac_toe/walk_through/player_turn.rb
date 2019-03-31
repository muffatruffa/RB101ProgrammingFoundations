INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'

def display_board(brd)
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

board = initialize_board

display_board(board)

set_board_at!(board,1,'X')
player_places_piece(board)
display_board(board)

#set_board_at!(board, 3, 'X')
#display_board(board)
#p empty_in_board(board)
#p marked_in_board(board)
