Given /^I am an unauthenticated user$/ do
end

When /^I attempt to authenticate$/ do
	consumer = OAuth::Consumer.new(
		'OqWJ77FNMTNOTjojT9gHMA',
		'vd7OcWDBUeDvXCEpL3O6zkGkyZV8x4E9e0mXIufDwk',
		:site => 'https://api.twitter.com'
	)

	authenticator = Starling::Access::GetAccessToken.new(consumer)
	authenticator.execute
end

Then /^I should should see the twitter oauth authentication url$/ do
	  pending # express the regexp above with the code you wish you had
end

Then /^I should be asked to enter the oauth code$/ do
	  pending # express the regexp above with the code you wish you had
end

When /^I provid an oauth code to the authenticator$/ do
	  pending # express the regexp above with the code you wish you had
end

Then /^the a twitter oauth token should be saved for the account$/ do
	  pending # express the regexp above with the code you wish you had
end

