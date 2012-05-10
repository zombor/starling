module Starling
	module Access
		class GetAccessToken
			def initialize(consumer, output = STDOUT)
				@consumer = ConsumerRole.new(consumer)
				@output = OutputRole.new(output)
			end

			def get_access_token
				@consumer.get_request_token.authorize_url
			end

			def store_oauth_token(pin)
				begin
					token = @consumer.get_access_token(pin)
				rescue OAuth::Unauthorized => e
					return {:status => false, :message => e.to_s}
				end
				@output.store_token(token)
				{:status => true}
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
				def initialize(output)
					@output = output
				end

				def store_token(token)
					@output.puts({:token => token.token, :secret => token.secret})
				end
			end
		end
	end
end
