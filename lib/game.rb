class Game
  attr_accessor :players

  def initialize(players = [Player.new, Player.new])
    @players = players
  end

  def start
    deck = CardDeck.new
    deck.shuffle
    7.times do
      players.each { |player| player.take([deck.deal]) }
    end
  end
end
