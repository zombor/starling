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
    end
  end
end
