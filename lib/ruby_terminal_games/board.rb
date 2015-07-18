
module RubyTerminalGames
  class Board
    attr_accessor :rows, :cols, :width, :height
    def initialize(width = nil, height = nil)
      @rows, @cols = STDOUT.winsize
      @width = width || @cols
      @height = height || @rows
    end

    def clear!
      move_cursor(1, 1)
      rows.times { write(" " * cols) }
    end

    def write(text, row = nil, col = nil)
      move_cursor(row, col) if (row && col)
      STDOUT.write(text)
    end

    def move_cursor(row, col)
      write("\e[#{row};#{col}H")
    end

    def draw_border!
      # Left and right border
      (0..height).each do |i|
        write("│", i, 0)
        write("│", i, width)
      end

      # Top and bottom border
      (0..width).each do |i|
        write("─", 0, i)
        write("─", height, i)
      end

      # Corners
      write("┌", 0, 0)
      write("┘", height, width)
      write("┐", 0, width)
      write("└", height, 0)
    end
  end
end
