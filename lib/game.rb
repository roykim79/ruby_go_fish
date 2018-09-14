class Game
  # attr_reader :current_player
  attr_accessor :players, :current_player_index

  def initialize(players = [Player.new, Player.new])
    @players = players
    @current_player_index = 0
  end

  def start
    deck = CardDeck.new
    deck.shuffle
    7.times do
      players.each { |player| player.take([deck.deal]) }
    end
  end

  def current_player
    players[current_player_index]
  end

  def play_turn

  end

  def next_player
    self.current_player_index = current_player_index + 1
  end
end
