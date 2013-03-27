require 'eventmachine'

module Starling
  module Delivery
    class CLI
      def initialize(config, timeline, twitter, command, output)
        @config = config
        @timeline = timeline
        @twitter = twitter
        @command = command
        @output = output
      end

      def execute
        EM.run do
          Thread.start do
            while buf = Readline.readline("> ", true)
              @command.process(buf.chomp)
            end
          end

          EM.add_periodic_timer(1) do
            @output.output(@timeline.output)

            @timeline.output.clear
            Readline.refresh_line
          end

          @timeline.latest
        end
      end
    end
  end
end
