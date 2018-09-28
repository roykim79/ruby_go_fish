require 'sinatra'
require 'sinatra/reloader'
require 'sprockets'
require 'sass'
require_relative 'lib/game'
require_relative 'lib/player'

class Server < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions
  # Start Assets
  set :environment, Sprockets::Environment.new
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/javascripts'
  environment.css_compressor = :scss
  get '/assets/*' do
    env['PATH_INFO'].sub!('/assets', '')
    settings.environment.call(env)
  end
  # End Assets

  def self.game
    @@game ||= Game.new
  end

  def self.pending_games
    @@pending_games ||= {
      '2' => [],
      '3' => [],
      '4' => [],
      '5' => []
    }
  end

  def start_game_if_possible
    self.class.pending_games.each do |count, players|
      next unless count.to_i == players.count

      @@game = Game.new(players)
      @@game.start
      self.class.pending_games[count] = []
    end
  end

  get '/' do
    slim :index
  end

  post '/' do
    session[:current_user_name] = params.fetch('name')
    session[:user_joined_game] = false
    redirect '/lobby'
  end

  get '/lobby' do
    slim :lobby, locals: { pending_games: self.class.pending_games }
  end

  post '/join' do
    count = params.fetch('player-count')
    player = Player.new(session[:current_user_name])
    self.class.pending_games[count].push(player)
    session[:user_joined_game] = true
    start_game_if_possible
    redirect '/game' if defined?(@@game)
    redirect "/waiting?player-count=#{count}"
  end

  get '/waiting' do
    redirect '/game' if defined?(@@game)
    count = params.fetch('player-count')
    players = self.class.pending_games[count]

    user_player = if session[:user_joined_game]
                    players.find { |player| player.name == session[:current_user_name] }
                  else
                    Player.new('No Player')
                  end
    other_players = players.reject { |player| player == user_player }
    other_players = [Player.new('No Player')] if other_players.length.zero?

    slim :waiting, locals: {
      joined: session[:user_joined_game],
      user_player: user_player,
      other_players: other_players,
      count: count,
      params: params,
      username: session[:current_user_name]
    }
  end

  get '/game' do
    game = self.class.game
    players = game.players
    user_player = players.find { |player| player.name == session[:current_user_name] }
    other_players = players.reject { |player| player == user_player }

    if user_player == game.current_player
      slim :current_player_view, locals: {
        game: game,
        user_player: user_player,
        other_players: other_players,
        params: params,
        username: session[:current_user_name]
      }
    else
      slim :game, locals: {
        game: game,
        user_player: user_player,
        other_players: other_players,
        params: params,
        username: session[:current_user_name]
      }
    end
  end

  post '/game' do
    game = self.class.game
    player_name = params.fetch('player-name')
    card_rank = params.fetch('card-rank')
    asked_player = game.players.find { |player| player.name == player_name }
    game.play_turn(asked_player, card_rank)

    redirect '/game'
  end
end
