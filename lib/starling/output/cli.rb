require 'colorize'

module Starling
  module Output
    class CLI
      def initialize
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

      def output(data)
        data.each do |line|
          if line.respond_to? :full_text
            text = colorize_handle(line.full_text)
            $stdout.print "\e[0G\e[K#{line.from_user.colorize(color_of(line.from_user))}: #{text}\n"
          else
            $stdout.print "\e[0G\e[K#{line}\n"
          end
        end
      end

      protected

      def color_of(string)
        num = string.delete("^0-9A-Za-z_").to_i(36) % @colors.size
        @colors[@color_codes[num]]
      end

      def colorize_handle(text)
        text.gsub(/@([A-Za-z0-9_]{1,15})/) do |username|
          username.colorize(color_of(username))
        end
      end
    end
  end
end
