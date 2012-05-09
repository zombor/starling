require 'starling/authenticate'

describe Starling::Authenticate do
	it 'should ask for an oauth code from a user' do
		auth = Starling::Authenticate.new(output)
		auth.ask_for_code
	end
end
