class PlayingCard
  attr_reader :rank

  def initialize(rank:, suit:)
    @rank = rank
  end
end
