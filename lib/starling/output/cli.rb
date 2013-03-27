require 'colorize'

module Starling
  module Output
    class CLI
      def initialize(data)
        @data = data
        @color_codes = (31..36).to_a + (91..96).to_a
        @colors = {
          31 => :blue,
          32 => :red,
          33 => :green,
          34 => :yellow,
          35 => :magenta,
          36 => :cyan,
          91 => :light_red,
          92 => :light_blue,
          93 => :light_green,
          94 => :light_magenta,
          95 => :light_cyan,
          96 => :light_yellow,
        }
      end

      def output
        @data.each do |line|
          $stdout.print "\e[0G\e[K#{line.from_user.colorize(color_of(line.from_user))}: #{line.text}\n"
        end
      end

      protected

      def color_of(string)
        num = string.delete("^0-9A-Za-z_").to_i(36) % @colors.size
        @colors[@color_codes[num]]
      end
    end
  end
end
