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

  def test_cards_values
    crds = [1]
    assert_equal([11], cards_values(crds))
    crds = [1, 8, 1]
    assert_equal([11, 8, 1], cards_values(crds))
    crds = [1, 4, 1, 5]
    assert_equal([11, 4, 1, 5], cards_values(crds))

  end
end

