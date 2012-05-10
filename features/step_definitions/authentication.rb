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

Then /^I should should see the twitter oauth authentication url$/ do
	@authorize_url.should be_a(String)
end

Then /^I should be asked to enter the oauth code$/ do
	consumer = OAuth::Consumer.new(
		'OqWJ77FNMTNOTjojT9gHMA',
		'vd7OcWDBUeDvXCEpL3O6zkGkyZV8x4E9e0mXIufDwk',
		:site => 'https://api.twitter.com'
	)

	@io = StringIO.new
	@auth = Starling::Access::GetAccessToken.new(consumer, @io)
	@auth.get_access_token
end

When /^I provide an oauth code to the authenticator$/ do
	pin = '0650515'
	@status = @auth.store_oauth_token(pin)
end

Then /^a twitter oauth token should be saved for the account$/ do
	string = eval(@io.string)
	string[:token].should_not be_nil
	string[:secret].should_not be_nil
end

