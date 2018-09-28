require 'socket'
require 'yaml'

class Client
  attr_reader :socket, :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
  end

  def start
    @socket = TCPSocket.new('localhost', port)
  end

  def provide_input(text)
    return unless text.length > 0

    @socket.puts(text)
  end

  def capture_output(delay = 0.1)
    sleep(delay)
    # @socket.read_nonblock(1000)# not gets which blocks
    output = @socket.read_nonblock(1000)
    puts output
    YAML.load(output) # not gets which blocks
  rescue IO::WaitReadable
    ''
  end

  def process_output(data)
    puts data
  end

  def close
    @socket.close if @socket
  end
end

print("whats your name? :\\n")
text = gets.chomp

client = Client.new(3336)

# print("whats your name? :")
# text = gets.chomp
client.provide_input(text)

loop do
  client.process_output(client.capture_output)

  # print "Enter to see if there's any output or type 'play'."
  text = gets.chomp
  break if text == 'end'

  client.provide_input(text)
end

client.close