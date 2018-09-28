# require 'rspec'
# require 'socket_server'
# require 'socket_client'
#
# class MockSocketClient
#   attr_reader :socket, :output
#
#   def initialize(port)
#     @socket = TCPSocket.new('localhost', port)
#   end
#
#   def provide_input(text)
#     socket.puts(text)
#   end
#
#   def capture_output(delay = 0.3)
#     sleep(delay)
#     begin
#       @output = @socket.read_nonblock(1000).chomp
#     rescue IO::WaitReadable
#       @output = ''
#     end
#   end
#
#   def close
#     socket.close if socket
#   end
# end
#
# describe SocketServer do
#   # attr_reader :server
#
#   # let(:server) { SocketServer.new }
#
#   # context 'before the server has started' do
#   #   it 'is not listening' do
#   #     expect { MockSocketClient.new(server.port_number) }.to raise_error(Errno::ECONNREFUSED)
#   #   end
#   # end
#
#   # context 'after the server has started' do
#     # attr_reader :clients
#
#     # let(:clients) { [] }
#
#     # def client_create_and_join(name, player_count, capture = false)
#     #   clients.push(client = MockSocketClient.new(server.port_number))
#     #   client.provide_input(name)
#     #   server.accept
#     #   client.capture_output
#     #   client.provide_input(player_count)
#     #   server.listen
#     #   clients.each(&:capture_output) if capture
#     #   client
#     # end
#
#     # before :each do
#     #   server.start
#     # end
#
#     # after :each do
#     #   server.close
#     #   clients.each(&:close)
#     # end
#
#     # it 'welcomes the player after giving a name' do
#     #   client = MockSocketClient.new(server.port_number)
#     #   clients.push(client)
#     #   client.provide_input('John')
#     #   server.accept
#     #   expect(clients[0].capture_output).to eq 'Welcome John, how many players would you like to play with?'
#     # end
#
#     # it 'will tell the player how many players are ready' do
#     #   client1 = client_create_and_join('John', '3')
#     #   expect(client1.capture_output).to eq 'John has joined, waiting for 2 more players'
#     # end
#
#     # it 'will tell all pending clients when a new players joins their game' do
#     #   client_create_and_join('John', '3', true)
#     #   client_create_and_join('Bob', '3')
#     #   clients.each { |c| expect(c.capture_output).to eq('Bob has joined, waiting for 1 more player') }
#     # end
#
#     # it 'will notify pending players when enough players have joined to start a game' do
#     #   client_create_and_join('John', '3', true)
#     #   client_create_and_join('Bob', '3', true)
#     #   client_create_and_join('Matt', '3')
#     #   clients.each { |c| expect(c.capture_output).to eq 'Matt has joined, game starting' }
#     # end
#
#     # it 'will not start a game until there are enough players' do
#     #   client_create_and_join('John', '3', true)
#     #   expect(server.create_game_runner_if_possible).to_not be_an_instance_of SocketGameRunner
#     # end
#
#     # it 'will not start a game until there are enough players' do
#     #   client_create_and_join('John', '3', true)
#     #   expect(server.create_game_runner_if_possible).to_not be_an_instance_of SocketGameRunner
#     # end
#
#     # it 'will start a game when there are enough players to start' do
#     #   client_create_and_join('John', '3', true)
#     #   client_create_and_join('Bob', '3', true)
#     #   client_create_and_join('Matt', '3', true)
#     #   s = server.create_game_runner_if_possible
#     #   expect(s.game.players[0].hand).to be true
#     #   # expect(server.create_game_runner_if_possible).to be_an_instance_of SocketGameRunner
#     # end
#   # end
# end
