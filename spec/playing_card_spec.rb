require 'rspec'
require 'playing_card'

describe PlayingCard do
  let(:card) { PlayingCard.new('A', 'Spades') }

  describe '#rank' do
    it 'returns the rank of the card' do
      expect(card.rank).to eq 'A'
    end
  end

  describe '#suit' do
    it 'returns the suit of the card' do
      expect(card.suit).to eq 'Spades'
    end
  end

  describe '#value' do
    it 'returns the rank and suit of a card as a string' do
      expect(card.value).to eq 'A of Spades'
    end
  end
end
