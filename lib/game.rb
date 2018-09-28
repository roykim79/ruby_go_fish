require 'yaml'
require_relative './card_deck'

class Game
  attr_accessor :players, :current_player_index, :deck, :turn

  def initialize(players = [Player.new, Player.new], deck = CardDeck.new)
    @players = players
    @deck = deck
    @turn = 0
  end

  def start
    deck.shuffle

    7.times do
      players.each { |player| player.take([deck.deal]) }
    end
  end

  def current_player
    players[turn % players.count]
  end

  def play_turn(asked_player, card_rank)
    result_string = "\nRESULT\n#{current_player.name} asked #{asked_player.name} for #{card_rank}s\n"
    result_hash = {
      'asking_player' => current_player.name,
      'asked_player' => asked_player.name,
      'card_rank' => card_rank
    }

    if asked_player.has_any?(card_rank)
      result_hash['guessed_right'] = true
      cards_asked_for = asked_player.give(card_rank)
      result_string << "#{asked_player.name} gave #{current_player.name} #{cards_asked_for.count} #{card_rank}\n"
      result_hash['cards_added'] = cards_asked_for.count
      current_player.take(cards_asked_for)
    else
      result_string << "#{current_player.name} went fishing\n"
      result_hash['fished'] = true
      result_hash['cards_added'] = 1
      current_player.take([deck.deal])
    end

    set_made = current_player.check_for_sets
    result_hash['set_made'] = set_made

    if set_made
      result_string << "#{current_player.name} completed a set of #{set_made}'s"
    else
      result_string << "#{current_player.name} did not complete any sets"
      next_player
    end

    result_string
    # result_hash
    # YAML.dump(result_hash)
  end

  def winner
    players.find { |player| player.card_count.zero? }
  end

  def game_overview
    game_status = ''

    players.each do |player|
      game_status << player.public_hand
    end

    game_status
  end

  def get_player_hand(player)
    player.hand
  end

  def next_player
    self.turn = turn + 1
  end
end
