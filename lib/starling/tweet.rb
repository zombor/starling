module Starling
  class Tweet
    attr_reader :token, :raw_tweet

    def initialize(token, tweet)
      @token = token
      @raw_tweet = tweet
    end

    def full_text
      @raw_tweet.full_text
    end

    def from_user
      @raw_tweet.from_user
    end
  end
end
