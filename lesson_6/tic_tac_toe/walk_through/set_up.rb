 # display empty board

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
  (1..9).each_with_object({}) { |n, hash| hash[n] = ' '}
end

board = initialize_board

display_board(board)

p board
