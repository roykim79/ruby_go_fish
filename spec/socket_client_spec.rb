require 'socket'
require 'socket_client'

class MockServer
  attr_reader :port_number
  attr_reader :output

  def initialize(port)
    @port_number = port
    @socket = TCPServer.new(port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def accept
    client = @socket.accept_nonblock
    client.puts('Enter a username') if client
    sleep(0.1)
  end

  def capture_output(delay = 0.1)
    sleep(delay)
    @output = @socket.read_nonblock(1000) # not gets which blocks
  rescue IO::WaitReadable
    @output = ''
  end

  def close
    @socket.close if @socket
  end
end

describe SocketClient do
  before :each do
    @server = MockServer.new(3336)
    @client = SocketClient.new(@server.port_number)
  end

  after :each do
    @server.close
    @client.close
  end

  it 'sends a greeting at start' do
    expect { @client.start }.to output("Hello\n").to_stdout
  end

  it 'asks for a name' do
    @client.start
    @server.accept
    expect { @client.give_instructions }.to output("Enter a username\n").to_stdout
  end
end
