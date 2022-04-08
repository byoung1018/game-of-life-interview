require './grid'
require './cell'
class Game
  attr_accessor :grid

  def initialize
    @grid = Grid.new
  end

  def run
    grid.print
    20.times do
      puts '----------------------'
      sleep 0.5
      new_grid = Grid.empty_grid
      grid.each_with_index do |cell, x, y|
        live_neighbors_count = grid.neighbors(x, y).select(&:live?).count
        # just being explicit, don't really need to set the dead states, they're already set
        new_state = if cell.live?        
          live_neighbors_count.between?(2, 3) ? Cell::LIVE : Cell::DEAD
        else
          live_neighbors_count == 3 ? Cell::LIVE : Cell::DEAD
        end
        new_grid.get(x, y).state = new_state
      end

      self.grid = new_grid
      grid.print
    end
  end
end

Game.new.run