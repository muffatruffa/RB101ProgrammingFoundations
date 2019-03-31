require 'minitest/autorun'
require_relative 'main_game_loop'

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
end
