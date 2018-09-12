require 'rspec'
require 'playing_card'

describe PlayingCard do
  let(:card) { PlayingCard.new(rank: 'A', suit: 'Spades') }

  describe '#rank' do
    it 'returns the rank of the card' do
      expect(card.rank).to eq 'A'
    end
  end
end
