require_relative './socket_server'
require_relative './socket_game_runner'
require_relative './game'
require_relative './player'
require_relative './card_deck'
require_relative './playing_card'

server = SocketServer.new
server.start

loop do
  begin
    server.accept
    server.listen
    game_runner = server.create_game_runner_if_possible
    server.run_game(game_runner) if game_runner
  rescue => e
    puts e
    server.close
  end
end
