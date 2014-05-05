require_relative "player"
require_relative "deck"
require_relative "card"

class Dealer < Player

  def show_initial_cards
    puts "#{@name} gets #{@cards.size} cards:"
    puts "The upcard is #{@cards[0]}"
    puts
  end


end