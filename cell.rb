class Cell
  LIVE = 'live'.freeze
  DEAD = 'dead'.freeze
  STATES = [LIVE, DEAD].freeze

  attr_reader :state, :grid

  def initialize(state=DEAD)
    self.state = state
    @grid = grid
  end

  def state=(state)
    raise "invalid state: #{state}" unless STATES.include?(state)
    @state = state
  end

  def live?
    state == LIVE
  end

  def dead?
    state == DEAD
  end

  def to_s
    if live?
      'x'
    else
      ' '
    end
  end
end