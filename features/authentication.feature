Feature: Authentication
	In order to use the application
	As an unauthenticated user
	I should be able to authenticate

	@vcr
	Scenario: Fresh user is presented with oauth challange
		Given I am an unauthenticated user
		When I attempt to authenticate
		Then I should should see the twitter oauth authentication url
		And I should be asked to enter the oauth code
		When I provide an oauth code to the authenticator
		Then a twitter oauth token should be saved for the account
