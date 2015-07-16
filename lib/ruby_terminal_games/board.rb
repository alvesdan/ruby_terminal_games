
module RubyTerminalGames
  class Board
    attr_accessor :rows, :cols, :width, :height
    def initialize(width: nil, height: nil)
      @rows, @cols = STDOUT.winsize
      @width = width || @cols
      @height = height || @rows
    end

    def clear!
      move_cursor(1, 1)
      rows.times { write(" " * cols) }
    end

    def write(text, row: nil, col: nil)
      move_cursor(row, col) if (row && col)
      STDOUT.write(text)
    end

    def move_cursor(row, col)
      write("\e[#{row};#{col}H")
    end

    def draw_border!
      # Left and right border
      (0..height).each do |i|
        write("│", row: i, col: 0)
        write("│", row: i, col: width)
      end

      # Top and bottom border
      (0..width).each do |i|
        write("─", row: 0, col: i)
        write("─", row: height, col: i)
      end

      # Corners
      write("┌", row: 0, col: 0)
      write("┘", row: height, col: width)
      write("┐", row: 0, col: width)
      write("└", row: height, col: 0)
    end
  end
end
