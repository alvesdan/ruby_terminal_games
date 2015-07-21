require_relative 'puzzle'
require_relative 'board'

module RubyTerminalGames
  module Sudoku
    class Game < RubyTerminalGames::Game
      attr_reader :board, :puzzle, :user_input_index, :user_input
      def initialize
        @puzzle = Puzzle.new
        @board = Board.new
        @user_input_index = 0
      end

      def play!
        @playing = true
        Keyboard.capture(detect_direction: true) do |key|
          begin
            @playing = false if key =~ /q/
            if direction_key?(key)
              move_user_input(key)
            else
              if allowed_input?(key)
                add_user_input(key.to_i)
              end
            end
          rescue
            Keyboard.stop_capture
            @playing = false
          end
        end

        while @playing
          board.print_board(self)
          sleep(0.1)
        end
      end

      def user_inputs
        @user_inputs ||= begin
          inputs = []
          [2, 3, 4, 6, 7, 8, 10, 11, 12].each do |row|
            [2, 4, 6, 8, 10, 12, 14, 16, 18].each do |col|
              inputs << [row, col]
            end
          end
          inputs
        end
      end

      def direction_key?(key)
        [UP, LEFT, RIGHT, DOWN].include?(key)
      end

      def move_user_input(key)
        moved = case key
        when UP
          [user_input_index - 9, 0].max
        when RIGHT
          [user_input_index + 1, 80].min
        when LEFT
          [user_input_index - 1, 0].max
        when DOWN
          [user_input_index + 9, 80].min
        end
        @user_input_index = moved
      end

      def allowed_input?(key)
        ('0'..'9').include?(key)
      end

      def add_user_input(input)
        puzzle.add_input(input, user_input_index)
      end
    end
  end
end
