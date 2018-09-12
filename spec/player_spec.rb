require 'rspec'
require 'player'
require 'playing_card'

describe Player do
  let(:player) { Player.new(name: 'Bob') }
  let(:card1) { PlayingCard.new(rank: 'A', suit: 'Spades') }
  let(:card2) { PlayingCard.new(rank: 'A', suit: 'Hearts') }
  let(:card3) { PlayingCard.new(rank: 'K', suit: 'Clubs') }
  let(:cards) { [card1, card2, card3] }

  describe '#initialize' do
    it 'sets the players name' do
      expect(player.name).to eq 'Bob'
    end

    it 'starts the player with and empty hand' do
      expect(player.hand.count).to eq 0
    end
  end

  describe '#take' do
    it 'adds an array of PlayingCards to the players hand' do
      player.take([card1])
      expect(player.hand.count).to eq 1
    end

    it 'adds an array of PlayingCards to the players hand' do
      player.take(cards)
      expect(player.hand.count).to eq 3
    end
  end

  context 'dealing with multiple cards' do
    before :each do
      player.take(cards)
    end

    describe '#give' do
      it 'returns the card(s) of a given rank from the players hand as an array' do
        expect(player.give('A')).to eq([card1, card2])
      end

      it 'removes the cards of a given rank from the players hand' do
        player.give('A')
        expect(player.hand).to eq [card3]
      end
    end

    describe '#check_for_sets' do
      it 'will do nothing when there are not 4 of a rank in the players hand' do
        player.check_for_sets
        expect(player.hand.count).to eq 3
      end

      it 'looks for 4 cards of same rank and adds the rank to the sets array' do
        other_aces = [PlayingCard.new(rank: 'A', suit: 'Clubs'), PlayingCard.new(rank: 'A', suit: 'Diamonds')]
        player.take(other_aces)
        player.check_for_sets
        expect(player.hand.count).to eq(1)
        expect(player.matches).to eq ['A']
      end
    end
  end
end
