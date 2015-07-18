module RubyTerminalGames
  module Hangman
    class Word
      attr_reader :letters, :guess_letters, :input_index
      def initialize
        @letters = random_word.chars
        @guess_letters = @letters.map { nil }
      end

      def guess!(key)
        found = false
        letters.each_with_index do |letter, index|
          next unless letter == key
          found = true
          @guess_letters[index] = letter
        end
        found
      end

      private

      def random_word
        File.readlines('./lib/ruby_terminal_games/hangman/words.txt')
          .map { |line|
          line.strip.downcase
        }.reject { |w| w.empty? }.sample
      end
    end
  end
end