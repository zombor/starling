require 'tweetstream'

module Starling
  module Timeline
    class Mine
      def initialize(token)
        @token = token
      end

      def latest
        token = @token.get_token

        TweetStream.configure do |config|
          config.consumer_key = 'OqWJ77FNMTNOTjojT9gHMA'
          config.consumer_secret = 'vd7OcWDBUeDvXCEpL3O6zkGkyZV8x4E9e0mXIufDwk'
          config.oauth_token = token[:token]
          config.oauth_token_secret = token[:secret]
          config.auth_method = :oauth
        end

        TweetStream::Client.new.userstream do |status|
          puts status.inspect
          Readline.refresh_line
        end
      end

      def stop
      end
    end
  end
end
