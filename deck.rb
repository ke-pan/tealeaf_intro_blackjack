require_relative "card"
require_relative "utils"

class Deck
  SUIT_SPADE = "\u2660".encode('utf-8')
  SUIT_HEART = "\u2665".encode('utf-8')
  SUIT_DIAMOND = "\u2666".encode('utf-8')
  SUIT_CLUB = "\u2663".encode('utf-8')
  SUITS = [SUIT_SPADE, SUIT_HEART, SUIT_CLUB, SUIT_DIAMOND]
  VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
  ONE_DECK = VALUES.product(SUITS)

  include Utils
  
  attr_accessor :cards, :number

  def initialize(number=1)
    number = 1 if number < 1
    @number = number
    reload(number)
  end

  def shuffle
    prompt "Shuffling..."
    cards.shuffle!
  end

  def deal
    if cards.empty?
      prompt "We played out of cards, reloading..."
      reload(number)
      shuffle
    end
    cards.pop
  end

  def reload(number)
    self.cards = (ONE_DECK * number).map {|v, s| Card.new(v, s)}
  end

end
