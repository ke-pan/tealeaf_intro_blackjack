require_relative "dealer"
require_relative "player"
require_relative "deck"
require_relative "utils"

class BlackjackGame

  include Utils

  attr_accessor :player, :decks, :dealer

  def initialize
  end

  def run
    # prepare
    clear_screen
    get_player
    set_decks
    get_dealer

    loop do
      # initial hand, player and dealer deal 2 cards
      player.deal(decks.deal)
      dealer.deal(decks.deal)
      player.deal(decks.deal)
      dealer.deal(decks.deal)
      show_table

      # player's turn
      until player.action == 'stay' || player.blackjack? || player.bust?
        prompt "Hit or Stay? h/s"
        action = gets.chomp
        if action.downcase.start_with? 'h' # hit
          player.action = 'hit'
          player.deal(decks.deal)
        else
          player.action = 'stay'
        end
        show_table
      end

      # dealer's turn
      show_table(initial=false)
      until player.bust? || player.blackjack? || dealer.point > 17
        dealer.deal(decks.deal)
        show_table(initial=false)
      end

      report
      # ask a new round
      break unless play_again?
      player.flush
      dealer.flush

    end

  end

  def clear_screen
    system "sleep 0.5"
    system "clear"
  end

  def show_table(initial=true)
    clear_screen
    width = dealer.name.length > player.name.length ? \
            dealer.name.length : player.name.length
    dealer_hands = initial ? dealer.initial_hands : dealer.hands
    puts "#{dealer.name.ljust(width)}: #{dealer_hands}"
    puts "#{player.name.ljust(width)}: #{player.hands}"
  end

  def get_player
    prompt "Welcome to Ke's Blackjack game! What's your name?"
    name = gets.chomp.strip
    self.player = Player.new(name)
  end

  def set_decks
    prompt "Hello #{player.name}, how many decks do you want to player, choose \
within 1-8"
    decks_num = gets.chomp
    self.decks = Deck.new(decks_num.to_i)
    decks.shuffle
  end

  def get_dealer
    self.dealer = Dealer.new("Dealer")
  end

  def report
    result =
    if player.blackjack?
      if dealer.blackjack?
        "Tie!"
      else
        "You win!"
      end
    elsif player.bust?
      "You lose!"
    elsif dealer.bust?
      "You win!"
    elsif player.point > dealer.point
      "You win!"
    elsif player.point == dealer.point
      "Tie!"
    else
      "You lose!"
    end
    prompt "#{player.name} got #{player.status}, \
#{dealer.name} got #{dealer.status}. #{result}"
  end

  def play_again?
    prompt "Do you want to play again? y/n"
    answer = gets.chomp
    answer.downcase.start_with? 'y'
  end

end
