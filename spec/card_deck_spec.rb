require 'rspec'
require 'card_deck'

describe CardDeck do
  let(:deck) { CardDeck.new }

  describe '#initialize' do
    it 'creates 52 cards' do
      expect(deck.cards.count).to eq 52
    end
  end

  describe '#deal' do
    let(:deck2) { CardDeck.new }
    let(:dealt_card) { deck.deal }
    let(:dealt_card2) { deck2.deal }

    it 'takes a card from the deck' do
      deck.deal
      expect(deck.cards.count).to eq 51
    end

    it 'returns an instance of PlayingCard' do
      expect(dealt_card).to be_an_instance_of PlayingCard
    end
  end
end
