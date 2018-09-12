require 'rspec'
require 'player'
require 'playing_card'

describe Player do
  let(:player) { Player.new(name: 'Bob') }
  let(:card1) { PlayingCard.new(rank: 'A', suit: 'Spades') }
  let(:card2) { PlayingCard.new(rank: 'K', suit: 'Hearts') }

  describe '#initialize' do
    it 'sets the players name' do
      expect(player.name).to eq 'Bob'
    end

    it 'starts the player with and empty hand' do
      expect(player.hand.count).to eq 0
    end
  end

  describe '#take' do
    it 'adds a PlayingCard to the players hand' do
      player.take([card1])
      expect(player.hand.count).to eq 1
    end

    it 'can add multiple cards' do
      cards = [card1, card2]
      player.take(cards)
      expect(player.hand.count).to eq 2
    end
  end
end
