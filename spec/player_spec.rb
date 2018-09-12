require 'rspec'
require 'player'

describe Player do
  let(:player) { Player.new('Bob') }

  describe '#initialize' do
    it 'sets the players name' do
      expect(player.name).to eq 'Bob'
    end

    it 'starts the player with and empty hand' do
      expect(player.hand.count).to eq 0
    end
  end
end
