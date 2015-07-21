module RubyTerminalGames
  module Sudoku
    class Board < RubyTerminalGames::Board
      def print_board(game)
        clear!
        print_top_border!
        print_middle_borders!
        print_bottom_border!

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

      def print_top_border!
        write("┌", row: 1, col: 1)
        write("┬", row: 1, col: 7)
        write("┬", row: 1, col: 13)
        write("┐", row: 1, col: 19)
      end

      def print_middle_borders!
        write("├", row: 5, col: 1)
        write("┼", row: 5, col: 7)
        write("┼", row: 5, col: 13)
        write("┤", row: 5, col: 19)
        write("├", row: 9, col: 1)
        write("┼", row: 9, col: 7)
        write("┼", row: 9, col: 13)
        write("┤", row: 9, col: 19)
      end

      def print_bottom_border!
        write("└", row: 13, col: 1)
        write("┴", row: 13, col: 7)
        write("┴", row: 13, col: 13)
        write("┘", row: 13, col: 19)
      end
    end
  end
end
