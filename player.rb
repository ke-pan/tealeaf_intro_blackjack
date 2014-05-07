require_relative "card"
class Player

  attr_reader :name

  def initialize(name="Mr. Somebody", chips=100)
    @name = name
    @chips = chips
    @cards = []
    @point = 0
  end

  def bet(wager=10) 
    @wager = wager
  end

  def deal(card)
    @cards << card
    #show_cards
  end

  def show_cards
    puts "#{name} gets #{@cards.size} cards, #{point} points:"
    @cards.each { |card| puts card }
    puts "#{name} gets blackjack" if blackjack?
    puts "#{name} gets bust!" if bust? 
    puts
  end

  def point
    aces = @cards.select { |card| card.ace? }
    @point = @cards.reduce(0) { |memo, card| memo + card.point}
    
    loop do
      break if aces.empty? || @point + 10 > 21
      aces.pop
      @point += 10
    end
    
    @point
  end

  def bust?
    point > 21
  end

  def blackjack?
    point == 21 && @cards.size == 2
  end

  def flush
    @cards = []
    @point = 0
  end



end


