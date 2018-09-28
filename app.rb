require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/player'
require 'pry'

players = []
sets1 = %w[A 2 3]
sets2 = %w[4 5 6 7]
sets3 = %w[8 9]
sets4 = %w[10 J]
sets5 = %w[Q]
cards1 = %w[A 3 5 K J 10 3 J Q Q Q]
cards2 = %w[A 3 5 K J]
cards3 = %w[A 3 5 K J 10 3 J Q K K A]
cards4 = %w[A 3 5 K J 10 3 J Q]
cards5 = %w[A 3 5 K J 10]
players.push(Player.new('John', cards1, sets1))
players.push(Player.new('Ringo', cards2, sets2))
players.push(Player.new('Paul', cards3, sets3))
players.push(Player.new('George', cards4, sets4))
players.push(Player.new('Roy', cards5, sets5))

get '/' do
  erb :landing
end

get '/game' do
  @players = players
  erb :game
end

get '/lobby' do
  erb :lobby
end
