require 'twitter/json_stream'

module Starling
  module Timeline
    class Mine
      def initialize(token)
        @token = token
      end

      def latest
        token = @token.get_token
        options = {
          :oauth => {
            :consumer_key => token[:token],
            :consumer_secret => token[:secret]
          },
          :path => '/1/statuses/filter.json',
        }

        items = []

        EventMachine::run do
          stream = ::Twitter::JSONStream.connect(options)

          stream.on_error do |message|
            puts message
          end

          stream.each_item do |item|
            items << item
          end

          stream.stop
          EventMachine.stop
        end

        items
      end

      def stop
      end
    end
  end
end
