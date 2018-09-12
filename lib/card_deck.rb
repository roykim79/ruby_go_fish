class CardDeck
  attr_reader :cards

  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2]
  SUITS = %w[Spades Hearts Clubs Diamonds]

  def initialize
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards.push(PlayingCard.new({rank: rank, suit: suit}))
      end
    end
  end

  def deal
    cards.pop
  end
end
