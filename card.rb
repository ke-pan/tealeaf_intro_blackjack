class Card

  attr_reader :value, :suit
  def initialize(value, suit="H")
    @value = value
    @suit = suit
  end

  def point
    case value
    when 'A' then 1
    when 'J', 'Q', 'K' then 10
    else value.to_i
    end
  end

  def to_s
    suit_utf8 = case suit
                when 'spades'   then "\u2660".encode('utf-8')
                when 'hearts'   then "\u2665".encode('utf-8')
                when 'diamonds' then "\u2666".encode('utf-8')
                when 'clubs'    then "\u2663".encode('utf-8')
                end 
    suit_utf8 + value
  end

  def ace?
    value == 'A'
  end

  def pic_name
    value = case self.value
            when 'A' then 'ace'
            when 'J' then 'jack'
            when 'Q' then 'queen'
            when 'K' then 'king'
            else self.value
            end
    suit + '_' + value
  end

end
