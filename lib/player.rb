class Player
  attr_reader :name, :hand

  def initialize(name = 'John')
    @name = name
    @hand = []
  end
end
