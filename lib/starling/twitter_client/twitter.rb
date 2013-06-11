module Starling
  module TwitterClient
    class Twitter
      def initialize(client)
        @client = client
      end

      def send_tweet(text)
        @client.update(text)
      end

      def reply(id, text)
        @client.update(text, {:in_reply_to_status_id => id})
      end

      def home_timeline(count = nil)
        @client.home_timeline(:count => count)
      end
    end
  end
end
