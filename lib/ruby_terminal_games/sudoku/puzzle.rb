module RubyTerminalGames
  module Sudoku
    class Puzzle
      attr_reader :state, :locked_positions
      def initialize
        @locked_positions = []
        @state = build_puzzle
      end

      def add_input(input, user_input_index)
        return if locked_position?(user_input_index)
        input = nil if input.zero?
        previous = state[user_input_index]
        @state[user_input_index] = input
        return true if valid?
        @state[user_input_index] = previous
        false
      end

      def locked_position?(user_input_index)
        locked_positions.include?(user_input_index)
      end

      private

      def puzzle_string
        path = File.expand_path(
          File.join(File.dirname(__FILE__), "puzzles.txt"))

        File.readlines(path)
          .map { |line|
          line.strip
        }.reject { |w| w.empty? }.sample
      end

      def build_puzzle
        puzzle_string.chars.each_with_index.map do |char, index|
          number = char.to_i
          @locked_positions << index unless number.zero?
          number.zero? ? nil : number
        end
      end

      def valid?
        valid_rows? && valid_columns? && valid_squares?
      end

      def valid_rows?
        rows.each do |row|
          return false if row.compact.size != row.compact.uniq.size
        end
        true
      end

      def valid_columns?
        columns.each do |col|
          return false if col.compact.size != col.compact.uniq.size
        end
        true
      end

      def valid_squares?
        squares.each do |square|
          return false if square.compact.size != square.compact.uniq.size
        end
        true
      end

      def rows
        (0..8).map do |i|
          start = i * 9
          (start..start+8).map { |j| state[j] }
        end
      end

      def columns
        (0..8).map do |i|
          (0..9).map do |n|
            state[n*9 + i]
          end
        end
      end

      def squares
        [
          [0, 1, 2],
          [3, 4, 5],
          [6, 7, 8],
          [27, 28, 29],
          [30, 31, 32],
          [33, 34, 35],
          [54, 55, 56],
          [57, 58, 59],
          [60, 61, 62]
        ].map do |group|
          group.map { |i|
            [0, 9, 18].map { |j|
              state[i + j]
            }.flatten
          }.flatten
        end
      end
    end
  end
end
