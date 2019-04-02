require 'minitest/autorun'
require_relative 'twenty_one'

class TwentyOneTest < Minitest::Test
  def setup
    @deck = initilize_deck
  end

  def test_initilize_deck
    assert_equal(52, @deck.size)
    assert_equal(@deck.first, [:hearts, 1])
    assert_equal(@deck.last, [:spades, 13])
  end
end

