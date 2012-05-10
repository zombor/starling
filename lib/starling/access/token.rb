module Starling
  module Access
    class Token
      def initialize(store)
        @store = store
      end

      def get_token
        eval @store.string
      end

      def save_token(token)
        @store.puts token
      end
    end
  end
end
