require 'rspec'
require 'card_deck'

describe CardDeck do
  let(:deck) { CardDeck.new }
  let(:dealt_card) { deck.deal }
  let(:deck2) { CardDeck.new }
  let(:dealt_card2) { deck2.deal }

  describe '#initialize' do
    it 'creates 52 cards' do
      expect(deck.cards.count).to eq 52
    end
  end

  describe '#deal' do
    it 'takes a card from the deck' do
      deck.deal
      expect(deck.cards.count).to eq 51
    end

    it 'returns an instance of PlayingCard' do
      expect(dealt_card).to be_an_instance_of PlayingCard
    end
  end

  describe '#shuffle' do
    it 'randomly changes the order of the deck' do
      deck.shuffle
      expect(dealt_card.value).not_to eq(dealt_card2.value)
    end
  end

  describe '#count' do
    it 'returns the number of cards remaining in the the cards list' do
      expect(deck.count).to be 52
    end
  end
end
