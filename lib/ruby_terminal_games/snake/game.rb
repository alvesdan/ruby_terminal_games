require_relative 'board'
require_relative 'snake'
require_relative 'apple'

module RubyTerminalGames
  module Snake
    class Game < RubyTerminalGames::Game
      attr_reader :board, :snake, :direction, :apple,
        :points, :speed, :counter

      def initialize
        @direction = RIGHT
        @board = Board.new

        @apple = Apple.new(
          width: @board.width,
          height: @board.height
        )

        @snake = Snake.new(
          width: @board.width,
          height: @board.height
        )

        @points = 0
        @speed = 0
        @counter = 0
      end

      def play!
        @playing = true

        KEYBOARD.capture(detect_direction: true) do |key|
          exit if key =~ /q/i
          next unless direction_allowed?(key)
          @direction = key
        end

        while @playing
          eat?
          snake.move!(direction)
          snake.died? and @playing = false
          game_interval!
          board.print_world!(self)
        end
      end

      def about
        [
          "Remember the good old times. Use the keyboard ",
          "arrows to control the snake."
        ].join
      end

      private

      def eat?
        return unless snake.eat?(apple)
        snake.grow!(direction)
        add_points!
        increase_speed!
      end

      def add_points!
        @points += (1 * @counter += 1)
      end

      def increase_speed!
        @speed += 0.0005
      end

      def game_interval!
        sleep([0.1 - @speed, 0].max)
      end

      def direction_allowed?(dir)
        allowed = case @direction
        when UP, DOWN
          [LEFT, RIGHT]
        when LEFT, RIGHT
          [UP, DOWN]
        end
        allowed.include?(dir)
      end
    end
  end
end
