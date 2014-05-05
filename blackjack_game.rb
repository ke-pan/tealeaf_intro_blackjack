require_relative "dealer"
require_relative "player"
require_relative "deck"


puts "What's your name?"
player_name = gets.chomp


puts "How many decks do you want to play?"
decks_num = Integer gets.chomp


puts "Hello, #{player_name}! Have a good time!"
puts "You want to play #{decks_num} decks."
puts


@player = Player.new(player_name)
@decks = Deck.new(decks_num)
@dealer = Dealer.new("Dealer")

def initial_game
  @decks.shuffle
  player_deal
  dealer_deal
  player_deal
  dealer_deal
end

def player_turn
  loop do
    if @player.blackjack?
      puts "You get blackjack!"
      puts
      break
    end
    puts "hit or stay?"
    break if gets.downcase.start_with?('s')
    player_deal
    @player.show_cards
    @dealer.show_initial_cards
    if @player.bust?
      puts "You bust!"
      puts
      break
    end
  end
  
  @player.bust? ? "player lose" : ""
end

def dealer_turn
  until @dealer.bust? || @dealer.point >= 17
    dealer_deal
    @dealer.show_cards
  end

  if @dealer.blackjack?
    if @player.blackjack?
      "tie"
    else
      "player lose"
    end
  elsif @dealer.bust?
    puts "Dealer bust!"
    puts
    "player win"
  elsif @dealer.point > @player.point
    "player lose"
  elsif @dealer.point == @player.point
    "tie"
  else
    "player win"
  end

end

def player_deal
  @player.deal(@decks.deal)
end

def dealer_deal
  @dealer.deal(@decks.deal)
end


loop do
  initial_game
  @player.show_cards
  @dealer.show_initial_cards
  if player_turn == "player lose" || (result = dealer_turn) == "player lose"
    puts "You lose this round."
    puts
  elsif result == "tie"
    puts "Push!"
    puts
  else
    puts "You win this round!"
    puts
  end

  puts "Report this round:"
  @player.show_cards
  @dealer.show_cards

  @player.flush
  @dealer.flush

  puts "Do you want to play again, yes or no?"
  break if gets.downcase.start_with?('n')
end
