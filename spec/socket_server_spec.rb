require 'rspec'
require 'socket_server'
require 'socket_client'

class MockSocketClient
  attr_reader :socket
  attr_reader :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  # def accept_message(text)
  #   text
  # end

  def capture_output(delay=0.1)
    sleep(delay)
    begin
      @output = @socket.read_nonblock(1000)
    rescue IO::WaitReadable
      @output = ''
    end
  end

  def close
    @socket.close if @socket
  end
end

describe SocketServer do
  before :each do
    @server = SocketServer.new
  end

  context 'before the server has started' do
    it 'is not listening' do
      expect { MockSocketClient.new(@server.port_number) }.to raise_error(Errno::ECONNREFUSED)
    end
  end

  context 'after the server has started' do
    before :each do
      @server.start
      @clients = []
    end

    after :each do
      @server.close
      @clients.each(&:close)
    end

    it 'asks the player for a name' do
      client = MockSocketClient.new(@server.port_number)
      @clients.push(client)
      @server.accept
      expect(client.capture_output).to eq("Enter a username\n")
    end
  end
  # let(:server) { SocketServer.new }

  # context 'before the server has stared' do
  #   it 'is not listening for new connections' do
  #     expect { SocketClient.new(server.port_number) }.to raise_error(Errno::ECONNREFUSED)
  #   end
  # end

  # context 'after the serer has started' do
  #   let(:clients) { [] }

  #   before :each do
  #     server.start
  #   end

  #   after :each do
  #     server.stop
  #     clients.each(&:close)
  #   end

  #   it 'is listening for new connections' do
  #     expect { clients.push(SocketClient.new(server.port_number)) }.not_to raise_error
  #   end

  #   it 'informs the player that they have connected' do
  #     client1 = SocketClient.new(server.port_number)
  #     clients.push(client1)
  #     server.accept_new_client('client1')
  #     expect(client1.capture_output).to match(/Welcome client1/)
  #   end

  # end
end
