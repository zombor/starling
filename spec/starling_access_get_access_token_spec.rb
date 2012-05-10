require 'starling/access/get_access_token'
require 'ostruct'

describe Starling::Access::GetAccessToken do
	it 'returns an authorize url' do
		consumer = double('consumer')
		consumer.should_receive(:get_request_token).and_return(RequestTokenMock.new)
		auth = Starling::Access::GetAccessToken.new(consumer)
		auth.get_access_token.should be_a(String)
	end

	it 'should store the oauth token in a data store' do
		consumer = double('consumer')
		consumer.should_receive(:get_request_token).and_return(RequestTokenMock.new)
		pin = '12345'
		datastore = double('datastore')
		datastore.should_receive(:puts).with(kind_of(Hash))
		auth = Starling::Access::GetAccessToken.new(consumer, datastore)
		auth.get_access_token
		auth.store_oauth_token(pin)
	end
end

class RequestTokenMock
	def authorize_url
		'http://twitter.com/test'
	end

	def get_access_token(oauth_verify)
		OpenStruct.new({:token => '1234', :secret => '1234'})
	end
end
