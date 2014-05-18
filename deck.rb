require_relative "card"
require_relative "utils"

class Deck
  SUITS = ['spades', 'hearts', 'diamonds', 'clubs']
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
