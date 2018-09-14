require 'rspec'
require 'game'

describe Game do
  let(:game) { Game.new }

  context 'initial game set up' do
    describe '#initialize' do
      it 'creates 2 new players by default' do
        expect(game.players.count).to eq 2
      end

      it 'sets the current_player to the first player' do
        expect(game.current_player).to eq game.players[0]
      end
    end

    describe '#start' do
      it 'it deals 7 cards to each player' do
        game.start
        game.players.each { |player| expect(player.hand.count).to eq 7 }
      end
    end
  end

  context 'playing a game' do
    let(:player1) { Player.new('Jim') }
    let(:player2) { Player.new('Bob') }
    let(:game) { Game.new([player1, player2]) }

    before :each do
      game.start
    end

    describe '#next_player' do
      it 'increments the current_player_index' do
        game.next_player
        expect(game.current_player).to eq player2
      end
    end

    describe '#play_turn' do
      it '' do

      end
    end
  end

end
