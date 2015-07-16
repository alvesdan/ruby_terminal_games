module RubyTerminalGames
  module Snake
    class Board < RubyTerminalGames::Board
      def initialize(width: nil, height: nil)
        super
        @width = cols
        @height = rows - 1
      end

      def print_world!(game)
        clear!
        draw_border!
        draw_exit_instructions!
        draw_apple!(game.apple)
        draw_stats!(game.counter, game.points)
        draw_snake!(game.snake.state, game.direction)
      end

      private

      def draw_stats!(speed, points)
        stats = [
          "SPEED:", speed + 1, "POINTS:", points
        ].join(' ')
        write(stats, row: rows, col: 0)
      end

      def draw_exit_instructions!
        text = "Press Q to exit"
        write(text, row: rows, col: cols - text.length)
      end

      def draw_apple!(apple)
        row, col = apple.position
        write("❤", row: row, col: col)
      end

      def draw_snake!(snake_state, direction)
        snake_state.each do |state|
          index, pos = state
          head = (index == snake_state.length - 1)
          draw_snake_body(direction, pos, head: head)
        end
      end

      def snake_head(position)
        case position
        when UP then '∩'
        when RIGHT then '⊃'
        when DOWN then '∪'
        when LEFT then '⊂'
        end
      end

      def draw_snake_body(direction, position, head: false)
        row, col = position
        text = head ? snake_head(direction) : '◆'
        write(text, row: row, col: col)
      end

    end
  end
end
