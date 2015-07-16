$:.push File.expand_path('../lib', __FILE__)

require 'ruby_terminal_games/version'

Gem::Specification.new do |s|
  s.name        = 'ruby_terminal_games'
  s.version     = RubyTerminalGames::VERSION
  s.summary     = 'Ruby Terminal Games'
  s.description = 'Simple basic bash game implementations in Ruby.'
  s.authors     = ['Daniel Alves']
  s.email       = 'daniel@danielalves.me'
  s.files       = Dir['lib/**/*', 'bin/*', 'README.md']
  s.homepage    = 'https://github.com/alvesdan/ruby_terminal_games'
  s.license     = 'MIT'

  s.add_dependency 'curses'
  s.add_dependency 'colorize'
end
