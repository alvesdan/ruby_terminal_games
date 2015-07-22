module RubyTerminalGames
  module Sudoku
    class Board < RubyTerminalGames::Board
      def print_board(game)
        clear!
        print_top_border!
        print_middle_borders!
        print_bottom_border!
        print_instructions!

        user_inputs = game.user_inputs
        user_input_index = game.user_input_index
        state = game.puzzle.state

        user_inputs.each_with_index do |input, index|
          highlight = (input == user_inputs[user_input_index])
          row, col = input
          number = (state[index] || " ").to_s

          if game.puzzle.locked_position?(index)
            if highlight
              output = number.colorize(
                background: :green,
                color: :white
              )
            else
              output = number.colorize(color: :green)
            end
          else
            output = number

            if highlight
              output = number
                .colorize(background: :light_yellow, color: :black)
            end
          end

          write(output, row: row, col: col)
        end
      end

      private

      def corner_cols
        [
          2, 3, 4, 5, 6, 8,
          9, 10, 11, 12, 14,
          15, 16, 17, 18
        ]
      end

      def middle_rows
        [
          2, 3, 4, 5, 6,
          8, 9, 10, 11, 12,
          14, 15, 16, 17, 18
        ]
      end

      def middle_columns
        [
          2, 3, 4,
          6, 7, 8,
          10, 11, 12
        ]
      end

      def print_top_border!
        write(LEFT_TOP_CORNER, row: 1, col: 1)
        write(TOP_SEPARATOR, row: 1, col: 7)
        write(TOP_SEPARATOR, row: 1, col: 13)
        write(RIGHT_TOP_CORNER, row: 1, col: 19)
      end

      def print_middle_borders!
        write(LEFT_SEPARATOR, row: 5, col: 1)
        write(CENTER_SEPARATOR, row: 5, col: 7)
        write(CENTER_SEPARATOR, row: 5, col: 13)
        write(RIGHT_SEPARATOR, row: 5, col: 19)
        write(LEFT_SEPARATOR, row: 9, col: 1)
        write(CENTER_SEPARATOR, row: 9, col: 7)
        write(CENTER_SEPARATOR, row: 9, col: 13)
        write(RIGHT_SEPARATOR, row: 9, col: 19)

        middle_rows.each do |col|
          write(HORIZONTAL_DASHED_LINE, row: 5, col: col)
          write(HORIZONTAL_DASHED_LINE, row: 9, col: col)
        end

        middle_columns.each do |row|
          write(VERTICAL_DASHED_LINE, row: row, col: 7)
          write(VERTICAL_DASHED_LINE, row: row, col: 13)
        end
      end

      def print_bottom_border!
        write(LEFT_BOTTOM_CORNER, row: 13, col: 1)
        write(BOTTOM_SEPARATOR, row: 13, col: 7)
        write(BOTTOM_SEPARATOR, row: 13, col: 13)
        write(RIGHT_BOTTOM_CORNER, row: 13, col: 19)
      end

      def print_bottom_line!
        write(HORIZONTAL_LINE * width, row: 14, col: 1)
      end

      def print_instructions!
        print_bottom_line!
        text = 'Use 0 to clear input'
        write(text, row: 15, col: 1)

        exit_text = 'Press Q to exit'
        write(exit_text, row: 15, col: width - exit_text.length)
      end
    end
  end
end
