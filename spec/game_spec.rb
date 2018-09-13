require 'rspec'
require 'game'

describe Game do
  let(:game) { Game.new }

  context 'initial game set up' do
    describe '#initialize' do
      it 'creates 2 new players by default' do
        expect(game.players.count).to eq 2
      end
    end

    describe '#start' do
      it 'it deals 7 cards to each player' do
        game.start
        game.players.each { |player| expect(player.hand.count).to eq 7 }
      end
    end
  end

end
