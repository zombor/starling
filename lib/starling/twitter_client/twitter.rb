module Starling
  module TwitterClient
    class Twitter
      def initialize(client)
        @client = client
      end

      def send_tweet(text)
        @client.update(text)
      end
    end
  end
end
