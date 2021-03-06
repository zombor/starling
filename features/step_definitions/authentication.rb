Given /^I am an unauthenticated user$/ do
end

When /^I attempt to authenticate$/ do
	consumer = OAuth::Consumer.new(
		'OqWJ77FNMTNOTjojT9gHMA',
		'vd7OcWDBUeDvXCEpL3O6zkGkyZV8x4E9e0mXIufDwk',
		:site => 'https://api.twitter.com'
	)

	auth = Starling::Access::GetAccessToken.new(consumer)
	@authorize_url = auth.get_access_token
end

Then /^I should see the twitter oauth authentication url$/ do
	@authorize_url.should be_a(String)
end

Then /^I should be asked to enter the oauth code$/ do
	consumer = OAuth::Consumer.new(
		'OqWJ77FNMTNOTjojT9gHMA',
		'vd7OcWDBUeDvXCEpL3O6zkGkyZV8x4E9e0mXIufDwk',
		:site => 'https://api.twitter.com'
	)

	@store = Starling::Access::Token.new(StringIO.new)
	@auth = Starling::Access::GetAccessToken.new(consumer, @store)
	url = @auth.get_access_token
	#puts url
end

When /^I provide the correct pin to the challenge$/ do
	# This pin doesn't matter. When we are in vcr mode, uncomment the STDIN line
	pin = '12345'
	#pin = STDIN.gets.strip
	@status = @auth.store_oauth_token(pin)

	if @status[:status] == false
		raise @status[:message]
	end
end

Then /^a twitter oauth token should be saved for the account$/ do
	raise "No token!" unless @store.has_token?

	string = @store.get_token
	string[:token].should_not be_nil
	string[:secret].should_not be_nil
end

When /^I provide an incorrect pin to the challenge$/ do
	@status = @auth.store_oauth_token('feiabeif38r3')
end

Then /^I should see an error message$/ do
	@status.should be_a(Hash)
	@status[:status].should be(false)
end
