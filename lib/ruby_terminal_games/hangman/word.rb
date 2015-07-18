module RubyTerminalGames
  module Hangman
    class Word
      attr_reader :letters, :guess_letters, :input_index
      def initialize
        @letters = random_word.chars
        @guess_letters = @letters.map { nil }
      end

      def guess!(key)
        return true if won?

        found = false
        letters.each_with_index do |letter, index|
          next unless letter == key
          found = true
          @guess_letters[index] = letter
        end
        found
      end

      def won?
        letters.size == guess_letters.compact.size
      end

      private

      def random_word
        path = File.expand_path(
          File.join(File.dirname(__FILE__), "words.txt"))

        File.readlines(path)
          .map { |line|
          line.strip.downcase
        }.reject { |w| w.empty? }.sample
      end
    end
  end
end
