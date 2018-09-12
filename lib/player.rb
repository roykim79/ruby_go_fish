class Player
  attr_reader :name, :hand, :matches

  def initialize(name: 'John')
    @name = name
    @hand = []
    @matches = []
  end

  def take(cards)
    cards.each { |card| hand.push(card) }
  end

  def give(rank)
    cards = hand.select { |card| card.rank == rank }
    hand.reject! { |card| card.rank == rank }
    cards
  end

  def check_for_sets
    hand.each do |card_to_match|
      return unless hand.count { |card| card.rank == card_to_match.rank } == 4
      matches.push(card_to_match.rank)
      hand.reject! { |card| card.rank == card_to_match.rank }
    end
  end
end
