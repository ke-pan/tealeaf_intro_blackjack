require 'rubygems'
require 'sinatra'
require 'pry'
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

set :sessions, true

get '/' do
  # binding.pry
  erb :home
end

post '/' do
  # binding.pry
  if params[:player_name].empty?
    @error = "Please enter a valid name!"
    erb :home
  else
    session[:player] = Player.new(params[:player_name])
    decks = Deck.new(2)
    decks.shuffle
    session[:decks] = decks
    session[:dealer] = Dealer.new("Dealer")
    redirect to('/bet')
  end
end

get '/bet' do
  @player = session[:player]
  erb :bet
end

post '/bet' do
  @player = session[:player]
  if params[:bet].to_i <= 0
    @error = "You have to bet some money!"
    erb :bet
  elsif params[:bet].to_i > @player.money
    @error = "You only have $#{@player.money}!"
    erb :bet
  else
    @player.bet = params[:bet].to_i
    dealer = session[:dealer]
    decks = session[:decks]
    @player.deal(decks.deal)
    dealer.deal(decks.deal)
    @player.deal(decks.deal)
    dealer.deal(decks.deal)
    session[:decks] = decks
    session[:player] = @player
    session[:dealer] = dealer
    # binding.pry
    redirect to('/blackjack_game')
  end
end

get '/blackjack_game' do
  # @decks = session[:decks]
  @player = session[:player]
  @dealer = session[:dealer]

  if @player.blackjack? || @player.bust? || @player.action == 'stay'
    @result =
    if @player.blackjack?
      if @dealer.blackjack?
        @player.tie
        "Tie!"
      else
        @player.win
        "You win!"
      end
    elsif @player.bust?
      @player.lose
      "You lose!"
    elsif @dealer.bust?
      @player.win
      "You win!"
    elsif @player.point > @dealer.point
      @player.win
      "You win!"
    elsif @player.point == @dealer.point
      @player.tie
      "Tie!"
    else
      @player.lose
      "You lose!"
    end
  end
  # binding.pry
  erb :blackjack_game
end

post '/blackjack_game' do
  # binding.pry
  decks = session[:decks]
  player = session[:player]
  dealer = session[:dealer]

  if params[:again]
    player.flush
    dealer.flush
    redirect to('/bet')
  elsif params[:quit]
    redirect to('/')
  elsif params[:hit]
    player.deal(decks.deal)
  else
    player.action = 'stay'
    until player.bust? || player.blackjack? || dealer.point > 17
      dealer.deal(decks.deal)
    end
  end


      
  session[:decks] = decks
  session[:player] = player
  session[:dealer] = dealer
  redirect to('/blackjack_game')
end
