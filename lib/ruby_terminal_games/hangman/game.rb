require_relative 'board'
require_relative 'word'

module RubyTerminalGames
  module Hangman
    class Game
      attr_reader :word, :guess_total, :board, :input_index,
        :wrong_guesses

      def initialize
        @word = Word.new
        @board = Board.new
        @wrong_guesses = []
      end

      def play!
        @playing = true

        Keyboard.capture(detect_direction: true) do |key|
          begin
            @playing = false if key =~ /Q/
            next unless allowed_key?(key)
            guess(key)
          rescue
            @playing = false
            Keyboard.stop_capture!
          end
        end

        while @playing
          board.print_world!(self)
          sleep(0.05)
        end
      end

      private

      def allowed_key?(key)
        ('a'..'z').to_a.include?(key.downcase)
      end

      def guess(key)
        return if word.guess!(key.strip.downcase)
        @wrong_guesses << key.upcase
        @wrong_guesses.uniq!
      end
    end
  end
end
