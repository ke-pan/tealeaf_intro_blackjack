require_relative "player"
require_relative "card"
require "test/unit"

class TestPlayer < Test::Unit::TestCase

  attr_reader :player

  def setup
    @player = Player.new("Mr. Test")
  end

  def test_blackjack
    player.deal(Card.new('K'))
    player.deal(Card.new('A'))
    assert(player.blackjack?)

    player.flush
    player.deal(Card.new('Q'))
    player.deal(Card.new('6'))
    player.deal(Card.new('5'))
    refute(player.blackjack?)
  end

  def test_bust
    player.deal(Card.new('10'))
    player.deal(Card.new('5'))
    player.deal(Card.new('A'))
    refute(player.bust?)
    player.deal(Card.new('8'))
    assert(player.bust?)
  end

  def test_point
    player.deal(Card.new('A'))
    player.deal(Card.new('5'))
    player.deal(Card.new('A'))
    assert_equal(17, player.point)
    player.deal(Card.new('J'))
    assert_equal(17, player.point)
  end

end
