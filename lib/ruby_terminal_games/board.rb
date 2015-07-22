module RubyTerminalGames
  class Board
    EMPTY_CHAR = " ".freeze
    HORIZONTAL_LINE = "─".freeze
    VERTICAL_LINE = "│".freeze
    HORIZONTAL_DASHED_LINE = "┄".freeze
    VERTICAL_DASHED_LINE = "┆".freeze
    LEFT_TOP_CORNER = "┌".freeze
    RIGHT_TOP_CORNER = "┐".freeze
    LEFT_BOTTOM_CORNER = "└".freeze
    RIGHT_BOTTOM_CORNER = "┘".freeze
    CENTER_SEPARATOR = "┼".freeze
    LEFT_SEPARATOR = "├".freeze
    RIGHT_SEPARATOR = "┤".freeze
    BOTTOM_SEPARATOR = "┴".freeze
    TOP_SEPARATOR = "┬".freeze

    attr_accessor :rows, :cols, :width, :height
    def initialize(width: nil, height: nil)
      @rows, @cols = STDOUT.winsize
      @width = width || @cols
      @height = height || @rows
    end

    def clear!
      move_cursor(1, 1)
      rows.times { write(EMPTY_CHAR * cols) }
    end

    def write(text, row: nil, col: nil)
      move_cursor(row, col) if (row && col)
      STDOUT.write(text)
    end

    def move_cursor(row, col)
      write("\e[#{row};#{col}H")
    end

    def draw_border!
      (0..height).each do |i|
        write(VERTICAL_LINE, row: i, col: 0)
        write(VERTICAL_LINE, row: i, col: width)
      end

      (0..width).each do |i|
        write(HORIZONTAL_LINE, row: 0, col: i)
        write(HORIZONTAL_LINE, row: height, col: i)
      end

      write(LEFT_TOP_CORNER, row: 0, col: 0)
      write(RIGHT_BOTTOM_CORNER, row: height, col: width)
      write(RIGHT_TOP_CORNER, row: 0, col: width)
      write(LEFT_BOTTOM_CORNER, row: height, col: 0)
    end
  end
end
