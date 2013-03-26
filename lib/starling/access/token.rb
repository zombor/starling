module Starling
  module Access
    class Token
      def initialize(store)
        @store = store
      end

      def get_token
        return parse_stored_token if has_token?
      end

      def save_token(token)
        @store.puts token
      end

      def has_token?
        token = parse_stored_token
        token.is_a?(Hash) && token.has_key?(:token) && token.has_key?(:secret)
      end

      private

      def parse_stored_token
        @store.rewind
        val = @store.read
        eval val
      end
    end
  end
end
