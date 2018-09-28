require 'socket'
require_relative './game_client'

class SocketServer
  attr_accessor :server

  def port_number
    3336
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept
    socket = @server.accept_nonblock
    username = read(socket)
    game_client = GameClient.new(socket, username)
    pending_clients.push(game_client)
    socket.puts("Welcome #{username}, how many players would you like to play with?")
    game_client
  rescue IO::WaitReadable, Errno::EINTR
    # puts 'No client to accept'
  end

  def create_game_runner_if_possible
    pending_games.each do |player_count, pending_clients|
      next unless (player_count - pending_clients.length).zero?

      pending_games.delete(player_count)
      return SocketGameRunner.new(pending_clients)
    end
    nil
  end

  def run_game(game_runner)
    Thread.start do
      game_runner.start
    end
  end

  def listen
    sleep(0.1)
    pending_clients.each do |client|
      player_count = read(client.socket).to_i
      next unless player_count >= 2

      join_pending_game(client, player_count)
      pending_clients.reject! { |pending_client| pending_client == client }
      inform_pending_players(client.name, player_count)
    end
  end

  def close
    pending_clients.each(&:close)
    pending_games.values.flatten.each(&:close)
    server.close if server
  end

  private

  def inform_pending_players(name, player_count)
    players_needed = player_count - pending_games[player_count].length

    message = create_message(name, players_needed)

    pending_games[player_count].each { |player| player.socket.puts(message) }
  end

  def create_message(name, players_needed)
    if players_needed == 0
      "#{name} has joined, game starting"
    elsif players_needed == 1
      "#{name} has joined, waiting for 1 more player"
    else
      "#{name} has joined, waiting for #{players_needed} more players"
    end
  end

  def join_pending_game(joining_player, player_count)
    if pending_games[player_count]
      pending_games[player_count].push(joining_player)
    else
      pending_games[player_count] = [joining_player]
    end
  end

  def pending_games
    @pending_games ||= {}
  end

  def pending_clients
    @pending_clients ||= []
  end

  def read(connection)
    begin
      connection.read_nonblock(10000).strip
    rescue IO::WaitReadable
      0
    end
  end
end
