require 'readline'

module Starling
  module Timeline
    class Mine
      attr_reader :output

      def initialize(client, output)
        @client = client
        @output = output
      end

      def latest(&block)
        @client.userstream do |status|
          @output << status

          if block
            block.call
          end
        end
      end

      def stop
        @client.stop
      end
    end
  end
end
