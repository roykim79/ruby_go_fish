class GameClient
  attr_reader :socket, :player, :name

  def initialize(socket, name)
    @socket = socket
    @name = name
  end

  def close
    socket.close if socket
  end

  def puts(text)
    socket.puts(text)
  end

  def read
    socket.read_nonblock(1000)
  end

  def card_count
    player.card_count
  end

  def take(cards)
    player.take(cards)
  end

  def set_count
    player.set_count
  end
end
