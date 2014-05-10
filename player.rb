class Player

  attr_reader :name
  attr_accessor :cards, :action

  def initialize(name="Mr. Somebody")
    @name  = name
    @cards = []
    @action = 'hit'
  end

  def deal(card)
    cards.push(card)
  end

  def hands
    cards.reduce('') { |memo, card| memo + " #{card}" }
  end

  def point
    aces = cards.select { |card| card.ace? }
    point = cards.reduce(0) { |memo, card| memo + card.point}

    aces.each do |_ace|
      break if point + 10 > 21
      point += 10
    end
    
    point
  end

  def bust?
    point > 21
  end

  def blackjack?
    point == 21 && cards.size == 2
  end

  def flush
    self.cards = []
    self.action = 'hit'
  end

  def status
    if blackjack?
      "blackjack"
    elsif bust?
      "bust"
    else
      "#{point.to_s} points"
    end
  end

end
