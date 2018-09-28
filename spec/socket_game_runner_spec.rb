# require 'yaml'
# require 'rspec'
# require 'socket_server'
# require 'socket_client'
# require 'socket_game_runner'
#
# describe SocketGameRunner do
#   attr_reader :clients, :game_clients, :server
#
#   def client_create_and_join(name, player_count, capture = false)
#     clients.push(client = SocketClient.new(server.port_number))
#     client.provide_input(name)
#     game_clients.push(server.accept)
#     client.capture_output
#     client.provide_input(player_count)
#     server.listen
#     clients.each(&:capture_output) if capture
#     client
#   end
#
#   let(:clients) { [] }
#   let(:game_clients) { [] }
#   let(:server) { SocketServer.new }
#
#   context 'during a round of play' do
#     attr_reader :game_runner
#
#     def user_input(string)
#       allow(STDIN).to receive(:gets) { string }
#     end
#
#     before :each do
#       server.start
#       client_create_and_join('John', 3, true)
#       client_create_and_join('Bob', 3, true)
#       client_create_and_join('Joe', 3, true)
#       @game_runner = server.create_game_runner_if_possible
#     end
#
#     after :each do
#       server.close
#       clients.each(&:close)
#     end
#
#     it 'will inform the client of their players hand' do
#       game_runner.inform_clients_of_game_status
#       expect(clients[0].capture_output).to match(/your cards are/)
#     end
#
#     # it 'will inform everyone of the overall hands' do
#     #   game_runner.inform_clients_of_game_status
#     #   expect(clients[1].capture_output).to match(/John has 7 cards and 0 sets\nBob has 7 cards and 0 sets\nJoe has 7 cards and 0 sets\n/)
#     # end
#
#     # it 'will output what the player asked for' do
#     #   game_runner.inform_clients_of_game_status
#     #   clients.each(&:capture_output)
#     #   request = 'Bob for Jacks'
#     #   clients[0].provide_input(request)
#     #   request = game_runner.listen_for_request
#     #   result = game_runner.handle_request(request)
#     #   game_runner.inform_players(result)
#     #   expect(clients[0].capture_output).to match(/John asked Bob for Jacks/)
#     # end
#   end
# end
