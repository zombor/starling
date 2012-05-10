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
        parse_stored_token.is_a?(Hash) && parse_stored_token.has_key?(:token) && parse_stored_token.has_key?(:secret)
      end

      private

      def parse_stored_token
        eval @store.string
      end
    end
  end
end
