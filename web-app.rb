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
    redirect to('/game')
  end
end


get '/game' do
  @player = session[:player]
  @dealer = session[:dealer]

  if @player.blackjack?
    if @dealer.blackjack?
      @player.tie
      @result = "Tie!"
    else
      @player.win
      @result = "You win!"
    end
  end

  erb :game
end

before '/game/*' do
  @decks = session[:decks]
  @player = session[:player]
  @dealer = session[:dealer]
end

get '/game/hit' do
  @player.deal(@decks.deal)

  if @player.bust?
    @player.lose
    @result = "You lose!"
  end

  session[:decks] = @decks
  session[:player] = @player

  erb :hit, :layout=>false
end

get '/game/stay' do 
  until @dealer.point > 17
    @dealer.deal(@decks.deal)
  end

  if @dealer.bust? || @player.point > @dealer.point
    @player.win
    @result = "You win!"
  elsif @player.point == @dealer.point
    @player.tie
    @result = "Tie!"
  else
    @player.lose
    @result = "You lose!"
  end

  session[:decks] = @decks
  session[:dealer] = @dealer
  session[:player] = @player

  erb :stay, :layout=>false
end

get '/game/again' do
  if params[:again]
    @player.flush
    @dealer.flush
    session[:dealer] = @dealer
    session[:player] = @player
    redirect to('/bet')
  else
    redirect to('/')
  end
end

get '/game/quit' do
  redirect to('/')
end
