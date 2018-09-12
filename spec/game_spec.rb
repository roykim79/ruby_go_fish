require 'rspec'
require 'game'

describe Game do
  let(:game) { Game.new }

  context 'initial game set up' do
    describe '#initialize' do
      it 'creates 2 new players by default' do
        expect(game.player1).not_to be_nil
        expect(game.player2).not_to be_nil
      end
    end
  end

end
