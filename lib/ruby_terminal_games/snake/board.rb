module RubyTerminalGames
  module Snake
    class Board < RubyTerminalGames::Board
      APPLE = "❤".freeze
      SNAKE_BODY = "◆".freeze
      SNAKE_HEAD_RIGHT = "⊃".freeze
      SNAKE_HEAD_LEFT = "⊂".freeze
      SNAKE_HEAD_UP = "∩".freeze
      SNAKE_HEAD_DOWN = "∪".freeze

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
          "Speed:", speed + 1, "Points:", points
        ].join(' ')
        write(stats, row: rows, col: 0)
      end

      def draw_exit_instructions!
        text = "Press Q to exit"
        write(text, row: rows, col: cols - text.length)
      end

      def draw_apple!(apple)
        row, col = apple.position
        write(APPLE.red, row: row, col: col)
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
        when UP then SNAKE_HEAD_UP
        when RIGHT then SNAKE_HEAD_RIGHT
        when DOWN then SNAKE_HEAD_DOWN
        when LEFT then SNAKE_HEAD_LEFT
        end
      end

      def draw_snake_body(direction, position, head: false)
        row, col = position
        text = head ? snake_head(direction) : SNAKE_BODY
        write(text, row: row, col: col)
      end

    end
  end
end
