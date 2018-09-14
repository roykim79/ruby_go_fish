class GameClient
  attr_accessor :socket, :player
  
  def initialize(socket, name)
    @socket = socket
    @player = Player.new(name)
  end
end
