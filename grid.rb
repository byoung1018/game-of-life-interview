require './cell'

class Grid
  # can initialie grid another way if building out interface
  GRID_SIZE = 20.freeze
  
  STARTING_GRID = [
    '   x                ',
    ' x x                ',
    '  xx                ',
    '                    ',
    '                    ',
    '                    ',
    '                    ',
    '                    ',
    '                    ',
    '                    '
  ]

  def initialize(matrix=nil)
    # using the starting grid instead of creating an empty grid and an interface to fill it
    # this approach is not meant to be permanante
    @matrix = matrix || STARTING_GRID.map do |row|
      row.split('').map do |cell|
        cell_state = cell == ' ' ? Cell::DEAD : Cell::LIVE
        cell_object = Cell.new(cell_state)

        cell_object
      end
    end
  end

  # this might not be the same size as the "starting grid", can add dynamic 
  # size if that ends up being more permanante 
  def self.empty_grid
    empty_matrix = Array.new(GRID_SIZE) do
      Array.new(GRID_SIZE) { Cell.new }  
    end

    new(empty_matrix)
  end


  def neighbors(x, y)
    (x-1..x+1).to_a.map do |x_neighbor|
      (y-1..y+1).to_a.map do |y_neighbor|
        next nil if x == x_neighbor && y == y_neighbor

        get(x_neighbor, y_neighbor)
      end
    end.flatten.compact
  end

  def off_matrix?(x, y)
    x < 0 ||
    y < 0 ||
    y >= @matrix.count ||
    x >= @matrix.first.count
  end

  def get(x, y)
    return nil if off_matrix?(x, y)

    @matrix[y][x]
  end

  def each_with_index
    @matrix.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        yield(cell, x, y)
      end
    end
  end

  def print
    @matrix.each do |row|
      p row.map(&:to_s).join('')
    end
  end
end