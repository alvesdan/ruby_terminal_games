module RubyTerminalGames
  module Hangman
    class Board < RubyTerminalGames::Board
      PLACEHOLDER = '_'.freeze

      def initialize(width: nil, height: nil)
        super
        @height = 10
      end

      def print_world!(game)
        print_placeholders(game.word)
        print_wrong_guesses(game.wrong_guesses)
        print_exit_instruction
      end

      private

      def print_placeholders(word)
        word.guess_letters.each_with_index do |letter, index|
          output = letter ? letter.upcase : ''
          output = output.green if word.won?
          placeholder = PLACEHOLDER
          write(output, row: 4, col: (index * 2) + 4)
          write(placeholder, row: 5, col: (index * 2) + 4)
        end
      end

      def print_wrong_guesses(guesses)
        write(guesses.join(', '), row: height - 2, col: 4)
      end

      def print_exit_instruction
        draw_border!
        text = "Press SHIFT+Q to exit"
        write(text, row: height + 1, col: cols - text.length)
      end
    end
  end
end
