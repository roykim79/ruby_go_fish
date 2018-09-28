class Player
  attr_reader :name, :hand, :sets

  def initialize(name = 'John', hand = [], sets = [])
    @name = name
    @hand = hand
    @sets = sets
  end

  def take(cards)
    cards.each { |card| hand.push(card) }
  end

  def give(rank)
    cards = hand.select { |card| card.rank == rank }
    hand.reject! { |card| card.rank == rank }
    cards
  end

  def card_count
    hand.count
  end

  def set_count
    sets.count
  end

  def has_any?(rank)
    hand.any? { |card| card.rank == rank }
  end

  def public_hand
    "#{name} has #{card_count} cards and #{set_count} sets"
  end

  def private_hand
    hand_string = "#{name}, your cards are "

    @hand.each_with_index do |card, index|
      hand_string << card.rank
      hand_string << ', ' unless index == card_count - 1
    end

    hand_string
    hand_string << "\n"
  end

  def check_for_sets
    to_delete = []
    hand.uniq.each do |card_to_match|
      rank = card_to_match.rank
      next unless hand.count { |card| card.rank == rank } == 4

      to_delete.push(rank)
    end

    to_delete.uniq.each do |rank|
      sets.push(rank)
      hand.reject! { |card| card.rank == rank }
    end
    sets[-1]
  end
end
