Feature: Authentication
	In order to use the application
	As an unauthenticated user
	I should be able to authenticate

	@vcr
	Scenario: Fresh user is presented with oauth challenge
		Given I am an unauthenticated user
		When I attempt to authenticate
		Then I should see the twitter oauth authentication url
		And I should be asked to enter the oauth code
		When I provide the correct pin to the challenge
		Then a twitter oauth token should be saved for the account

	@vcr
	Scenario: Fresh user enters incorrect pin to oauth challenge
		Given I am an unauthenticated user
		When I attempt to authenticate
		Then I should see the twitter oauth authentication url
		And I should be asked to enter the oauth code
		When I provide an incorrect pin to the challenge
		Then I should see an error message
