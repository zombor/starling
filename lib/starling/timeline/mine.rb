require 'readline'
require 'starling/tweet'

module Starling
  module Timeline
    class Mine
      attr_reader :output

      def initialize(client, output, id_generator)
        @client = client
        @output = output
        @id_generator = id_generator

        @client.on_error do |message|
          @output << "error: #{message}"
        end

        @client.on_reconnect do |timeout, retries|
          @output << "reconnecting in #{timeout} seconds..."
        end
      end

      def latest(&block)
        @client.userstream do |status|
          token = @id_generator.store(status.id)
          @output << Tweet.new(token, status)

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
