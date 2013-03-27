require 'eventmachine'

module Starling
  module Delivery
    class CLI
      def initialize(config)
        @config = config
      end

      def execute(timeline, twitter, command, output)
        EM.run do
          Thread.start do
            while buf = Readline.readline("> ", true)
              if buf == 'stop'
                timeline.stop
              else
                command.process(buf.chomp)
              end
            end
          end

          EM.add_periodic_timer(1) do
            output.output(timeline.output)

            timeline.output.clear
            Readline.refresh_line
          end

          timeline.latest
        end
      end
    end
  end
end
