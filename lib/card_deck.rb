require_relative './playing_card'

class CardDeck
  attr_reader :cards

  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze
  SUITS = %w[Spades Hearts Clubs Diamonds].freeze

  def initialize
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards.push(PlayingCard.new(rank, suit))
      end
    end
  end

  def count
    cards.count
  end

  def deal
    cards.pop
  end

  def shuffle
    cards.shuffle!
  end
end
