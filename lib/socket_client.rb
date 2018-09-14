require 'socket'

class SocketClient
  attr_reader :socket, :output

  def initialize(port)
    @port = port
  end

  def start
    puts 'Hello'
    @socket = TCPSocket.new('localhost', @port)
  end

  def capture_output(delay = 0.1)
    sleep(delay)
    begin
      @output = @socket.read_nonblock(1000) # not gets which blocks
    rescue IO::WaitReadable
      @output = ''
    end
  end

  def give_instructions
    puts @socket.read_nonblock(1000)
  end

  def close
    @socket.close if @socket
  end
end
