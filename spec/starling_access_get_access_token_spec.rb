require 'starling/access/get_access_token'

describe Starling::Access::GetAccessToken do
	it 'returns an authorize url' do
		consumer = double('consumer')
		consumer.should_receive(:get_request_token).and_return(RequestTokenMock.new)
		get_access_token = Starling::Access::GetAccessToken.new(consumer)
		get_access_token.execute.should be_a(String)
	end
end

class RequestTokenMock
	def authorize_url
		'http://twitter.com/test'
	end
end
