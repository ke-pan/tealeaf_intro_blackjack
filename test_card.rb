require_relative "card"
require "test/unit"

class TestCard < Test::Unit::TestCase

  def test_ace
    card = Card.new('K')
    refute card.ace?
    card = Card.new('A')
    assert card.ace?
  end

  def test_point
    card = Card.new('A')
    assert_equal 1, card.point 
    card = Card.new('2')
    assert_equal 2, card.point
    card = Card.new('3')
    assert_equal 3, card.point
    card = Card.new('4')
    assert_equal 4, card.point
    card = Card.new('5')
    assert_equal 5, card.point
    card = Card.new('6')
    assert_equal 6, card.point
    card = Card.new('7')
    assert_equal 7, card.point
    card = Card.new('8')
    assert_equal 8, card.point
    card = Card.new('9')
    assert_equal 9, card.point
    card = Card.new('10')
    assert_equal 10, card.point
    card = Card.new('J')
    assert_equal 10, card.point
    card = Card.new('Q')
    assert_equal 10, card.point
    card = Card.new('K')
    assert_equal 10, card.point
  end

end