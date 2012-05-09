module Starling
	module Access
		class GetAccessToken
			def initialize(consumer)
				@consumer = consumer
			end

			def execute
				request_token = @consumer.get_request_token
				request_token.authorize_url
			end
		end
	end
end
