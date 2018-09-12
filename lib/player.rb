class Player
  attr_reader :name, :hand

  def initialize(name: 'John')
    @name = name
    @hand = []
  end

  def take(cards)
    cards.each { |card| hand.push(card)  }
  end
end
