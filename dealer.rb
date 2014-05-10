require_relative "player"

class Dealer < Player

  # def show_initial_cards
  #   print "#{name}:  #{cards[1]} ##\n"
  # end

  def initial_hands
    " ## #{cards[1]}"
  end
end
