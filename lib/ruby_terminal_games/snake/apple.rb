module RubyTerminalGames
  module Snake
    class Apple
      attr_reader :position, :width, :height
      def initialize(width, height)
        @width = width
        @height = height
        @position = [height - 4, width - 4]
      end

      def move(snake)
        begin
          moved = [
            rand(height - 4) + 2,
            rand(width - 4) + 2
          ]
        end while snake.used?(moved)
        @position = moved
      end
    end
  end
end
