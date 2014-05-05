require_relative "card"

class Deck
  
  def initialize(number=1)  
    @number_of_decks = number
    reload
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    reload if @cards.empty?
    @cards.pop
  end

  def reload
    suits = ["spade", "heart", "club", "diamond"]
    points = (1..13)
    one_deck = []
    suits.each do |suit|
      points.each do |point|
        one_deck.push Card.new(point, suit)
      end
    end
    @cards = one_deck * @number_of_decks
  end

  def to_s
    @cards.map { |card| card.to_s }.to_s
  end

end

#deck = Deck.new(2)
#puts deck