class Card

  def initialize(point, suit="heart")
    @suit = suit
    @point = point
  end

  def point
    @point > 10 ? 10 : @point
  end

  def to_s
    case @point
    when 1 then "Ace of "
    when 2 then "Two of "
    when 3 then "Three of "
    when 4 then "Four of "
    when 5 then "Five of "
    when 6 then "Six of "
    when 7 then "Seven of "
    when 8 then "Eight of "
    when 9 then "Nine of "
    when 10 then "Ten of "
    when 11 then "Jack of "
    when 12 then "Queen of "
    when 13 then "King of "
    end + @suit
  end

  def ace?
    @point == 1
  end

end
