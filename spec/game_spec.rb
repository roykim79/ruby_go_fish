require 'rspec'
require 'yaml'
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

  context 'while playing a game' do
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

      it 'returns the first player when called while being on the last player' do
        game.next_player
        game.next_player
        expect(game.current_player).to eq player1
      end
    end

    describe '#game_overview' do
      it 'returns the game status to each of the players' do
        expect(game.game_overview).to eq "Jim has 7 cards and 0 setsBob has 7 cards and 0 sets"
      end
    end

    describe '#get_player_hand' do
      it 'returns the cards a player is holding' do
        expect(game.get_player_hand(player1).count).to eq 7
      end
    end

    describe '#play_turn' do
      it 'will change the number of cards current player has' do
        expect { game.play_turn(player2, 'A') }.to change { player1.card_count }
      end

      # it 'returns the round action as a string' do
      #   result = game.play_turn(player2, 'A')
      #   converted = YAML.safe_load(result)
      #   # expect(converted).to match(/Jim asked Bob for As/)
      #   expected = {
      #     "asked_player" => "Bob",
      #     "asking_player" => "Jim",
      #     "card_rank" => "A",
      #     "cards_added" => 1,
      #     "fished" => true,
      #     "set_made" => nil
      #   }
      #   expect(converted).to eq(expected)
      # end
    end

    describe '#winner' do
      it 'will not return a winner in the beginning' do
        expect(game.winner).to be_nil
      end
    end
  end
end
