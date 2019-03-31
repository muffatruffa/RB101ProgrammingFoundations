require 'minitest/autorun'
require_relative 'tictactoe'

class TicTacToeTest < Minitest::Test
  def setup
    @board = {}
    (1..9).each {|n| @board[n] = 'X'}
  end


  def test_emtpy_in_board_return_empty
    board = {}
    (1..9).each {|n| @board[n] = ' '}
    assert_empty(empty_in_board(board), 'return empty hash')
  end

  def test_board_full?
    assert(board_full?(@board), 'return true if board full')

    @board[1] = ' '
    assert_equal(false, board_full?(@board))
  end

  def test_values_at_row
    @board[3] = 3
    @board[9] = 9
    assert_equal(['X','X',3], values_at_row(@board, 0))
    assert_equal(['X','X',9], values_at_row(@board, 2))
  end

  def test_values_at_col
    @board[1] = 1
    @board[9] = 9
    assert_equal([1,'X','X'], values_at_col(@board, 0))
    assert_equal(['X','X',9], values_at_col(@board, 2))
  end

  def test_values_diagonal_at_0
    @board[1] = 1
    @board[9] = 9
    assert_equal([1,'X',9], values_diagonal_at_0(@board))
  end


  def test_values_diagonal_at_2
    @board[3] = 3
    assert_equal([3,'X','X'], values_diagonal_at_2(@board))
  end

  def test_allplayer?
    vals = ['X','O','X']
    assert_equal(false, all_player?(vals))
    vals = ['X', 'X', 'X']
    assert_equal(true, all_player?(vals))
  end

  def test_computer_won?
    @board[1] = COMPUTER_MARKER
    @board[2] = COMPUTER_MARKER
    @board[3] = COMPUTER_MARKER
    @board[4] = COMPUTER_MARKER
    @board[9] = COMPUTER_MARKER
    assert(computer_won?(@board))
  end

  def test_joinor
    ar = [1, 2]
    ar_2 = [1, 2, 3]
    assert_equal('1 or 2', joinor(ar))
    assert_equal('1, 2 or 3', joinor(ar_2))
  end

  def test_defend_by_column_0
    @board[2] = PLAYER_MARKER
    @board[5] = PLAYER_MARKER
    @board[8] = INITIAL_MARKER
    assert_equal(8, defend_by_column(@board))
  end


  def test_defend_by_column_1
    @board[7] = PLAYER_MARKER
    @board[1] = PLAYER_MARKER
    @board[4] = INITIAL_MARKER
    assert_equal(4, defend_by_column(@board))
  end


  def test_defend_by_column_2
    @board[3] = PLAYER_MARKER
    @board[6] = PLAYER_MARKER
    @board[9] = INITIAL_MARKER
    assert_equal(9, defend_by_column(@board))
  end

  def test_square_tocolumn
    col = square_to_column(5)
    assert_equal(1, col)
    col = square_to_column(7)
    assert_equal(0, col)
  end

  def test_suqare_to_row
    row= square_to_row(5)
    assert_equal(1, row)
    row = square_to_row(7)
    assert_equal(2, row)
  end

  def test_defend_by_column
#    board = {}
#    (1..9).each {|n| board[n] = INITIAL_MARKER}
#    board[5] = PLAYER_MARKER
#    board[9] = PLAYER_MARKER
#    assert_equal(1, defend_by_column(board))

    board = {}
    (1..9).each {|n| board[n] = INITIAL_MARKER}
    board[3] = PLAYER_MARKER
    board[5] = PLAYER_MARKER
    assert_equal(7, defend_by_column(board))
  end
end

