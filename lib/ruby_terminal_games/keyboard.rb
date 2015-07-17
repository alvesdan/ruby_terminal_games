module RubyTerminalGames
  class Keyboard
    attr_reader :thread

    def capture(detect_direction: false, &block)
      Curses.noecho
      Curses.stdscr.keypad(true)
      Curses.curs_set(0)
      Curses.cbreak
      Curses.raw

      Thread.new do
        loop do
          key = Curses.getch
          command = direction(key) || key
          command = key unless detect_direction
          block.call(command)
          sleep(0.15)
        end
      end
    end

    private

    def direction(key)
      case key
      when Curses::KEY_UP; then UP;
      when Curses::KEY_DOWN; then DOWN;
      when Curses::KEY_RIGHT; then RIGHT;
      when Curses::KEY_LEFT; then LEFT;
      end
    end

  end
end
