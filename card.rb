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
    suit + value
  end

  def ace?
    value == 'A'
  end

end
