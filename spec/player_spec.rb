require 'rspec'
require 'player'
require 'playing_card'

describe Player do
  let(:player) { Player.new('Bob') }
  let(:card1) { PlayingCard.new('A', 'Spades') }
  let(:card2) { PlayingCard.new('A', 'Hearts') }
  let(:card3) { PlayingCard.new('K', 'Clubs') }
  let(:cards) { [card1, card2, card3] }

  describe '#initialize' do
    it 'sets the players name' do
      expect(player.name).to eq 'Bob'
    end

    it 'starts the player with and empty hand' do
      expect(player.hand.count).to eq 0
    end
  end

  describe '#card_count' do
    it 'returns the number of cards the player has' do
      expect(player.card_count).to eq 0
      player.take(cards)
      expect(player.card_count).to eq 3
    end
  end

  describe '#has_any?' do
    it 'returns true if the player has any of the rank asked for' do
      player.take(cards)
      expect(player.has_any?('A')).to be true
      expect(player.has_any?('J')).to be false
    end
  end

  describe '#public_hand' do
    it 'returns the players card count and set count as a string' do
      player.take(cards)
      expect(player.public_hand).to eq "Bob has 3 cards and 0 sets"
    end
  end

  describe '#private_hand' do
    it 'returns the ranks of the players cards as a string' do
      player.take(cards)
      expect(player.private_hand).to eq "Bob, your cards are A, A, K\n"
    end
  end

  describe '#take' do
    it 'adds an array of PlayingCards to the players hand' do
      player.take([card1])
      expect(player.card_count).to eq 1
    end

    it 'adds an array of PlayingCards to the players hand' do
      player.take(cards)
      expect(player.card_count).to eq 3
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

    describe '#set_count' do
      it 'returns the number of sets the player has' do
        expect(player.set_count).to be 0
      end
    end

    describe '#check_for_sets' do
      it 'will do nothing when there are not 4 of a rank in the players hand' do
        player.check_for_sets
        expect(player.card_count).to eq 3
      end

      it 'removes 4 cards of same rank and adds the rank to the sets array' do
        other_aces = [PlayingCard.new('A', 'Clubs'), PlayingCard.new('A', 'Diamonds')]
        player.take(other_aces)
        player.check_for_sets
        expect(player.card_count).to eq 1
        expect(player.set_count).to eq 1
        expect(player.sets).to eq ['A']
      end
    end
  end
end
