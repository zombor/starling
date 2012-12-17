require 'starling/access/token'

module Starling
  module Access
    class GetAccessToken
      def initialize(consumer, store = Starling::Access::Token.new(StringIO.new))
        @consumer = ConsumerRole.new(consumer)
        @output = OutputRole.new(store)
      end

      def get_access_token
        @consumer.get_request_token.authorize_url
      end

      def store_oauth_token(pin)
        begin
          token = @consumer.get_access_token(pin)
        rescue OAuth::Unauthorized => e
          raise e
        end
        @output.store_token(token)
        @output.store
      end

      class ConsumerRole
        def initialize(consumer)
          @consumer = consumer
        end

        def get_request_token
          @request_token = @consumer.get_request_token
        end

        def get_access_token(pin)
          access_token = @request_token.get_access_token(:oauth_verifier => pin)
        end
      end

      class OutputRole
        attr_reader :store

        def initialize(store)
          @store = store
        end

        def store_token(token)
          @store.save_token({:token => token.token, :secret => token.secret})
        end
      end
    end
  end
end
