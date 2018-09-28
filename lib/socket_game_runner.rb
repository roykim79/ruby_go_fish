require 'yaml'

class SocketGameRunner
  attr_reader :game, :game_clients

  def initialize(game_clients)
    @game_clients = game_clients
    game_clients.each do |client|
      client_to_player[client] = Player.new(client.name)
    end
    @game = Game.new(client_to_player.values)
    game.start
  end

  def start
    until game.winner
      inform_clients_of_game_status

      request = listen_for_request
      if valid_request?(request)
        result = handle_request(request)
        inform_players(result)
      end
    end

    inform_players("Game Over")
  end

  # def play_round
  #   inform_clients_of_game_status
  #   request = listen_for_request
  #   result = handle_request(request)
  #   inform_players(result)
  # end

  def listen_for_request
    current_client.socket.read_nonblock(1000)
  rescue IO::WaitReadable
    retry
  end

  def client_to_player
    @client_to_player ||= {}
  end

  def handle_request(request)
    player_name, rank = request.match(/([a-z]+) for ([a-z0-9]+)s?/i).captures
    return unless player_name && rank

    asked_player = game.players.find { |player| player.name == player_name }
    game.play_turn(asked_player, rank)
  end

  def inform_players(data)
    game_clients.each { |client| inform_client(client, data) }
  end

  def inform_client(client, data)
    client.puts(YAML.dump(data))
  end

  def inform_clients_of_game_status
    game_clients.each do |client|
      message = "\nROUND BEGIN\n" + hand_s(client) + game_overview_s + current_player_s
      # message = "\nROUND BEGIN\n" + hand_s(client)
      inform_client(client, message)
    end
  end

  private

  def valid_request?(request)
    request.match(/([a-z]+) for ([a-z0-9]+)s?/i)
  end

  def current_client
    client_to_player.key(game.current_player)
  end

  def hand_s(client)
    client_player = client_to_player[client]
    client_player.private_hand
  end

  def current_player_s
    "It is #{game.current_player.name}'s turn\\n"
  end

  def game_overview_s
    game.game_overview
  end
end
