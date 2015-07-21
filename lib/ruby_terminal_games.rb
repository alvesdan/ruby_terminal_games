require 'io/console'
require 'curses'
require 'colorize'

module RubyTerminalGames
  UP = 0
  RIGHT = 1
  DOWN = 2
  LEFT = 3
end

require_relative 'ruby_terminal_games/game'
require_relative 'ruby_terminal_games/board'
require_relative 'ruby_terminal_games/keyboard'
require_relative 'ruby_terminal_games/snake'
require_relative 'ruby_terminal_games/hangman'
require_relative 'ruby_terminal_games/sudoku'
