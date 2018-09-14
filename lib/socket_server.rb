require 'socket'
require 'game_client'

class SocketServer
  def port_number
    3336
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept
    client = @server.accept_nonblock
    pending_clients.push(client)
    client.puts('Enter a username')
    # client
  rescue IO::WaitReadable, Errno::EINTR
    puts 'No client to accept'
  end

  def close
    @server.close if @server
  end

  private

  def pending_clients
    @pending_clients ||= []
  end
end
