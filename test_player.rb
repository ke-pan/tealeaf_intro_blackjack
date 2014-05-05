require_relative "player"
require_relative "card"
require "test/unit"

class TestPlayer < Test::Unit::TestCase

  def setup
    @player = Player.new("Mr. Test", 100)
  end

  def test_blackjack
    @player.deal(Card.new(13))
    @player.deal(Card.new(1))
    assert(@player.blackjack?)

    @player.flush
    @player.deal(Card.new(12))
    @player.deal(Card.new(6))
    @player.deal(Card.new(5))
    refute(@player.blackjack?)
  end

  def test_bust
    @player.deal(Card.new(10))
    @player.deal(Card.new(5))
    refute(@player.bust?)
    @player.deal(Card.new(8))
    assert(@player.bust?)
  end

  def test_point
    @player.deal(Card.new(1))
    @player.deal(Card.new(5))
    @player.deal(Card.new(1))
    assert_equal(17, @player.point)
    @player.deal(Card.new(13))
    assert_equal(17, @player.point)
  end

end
