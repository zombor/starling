Feature: View Stream
  In order to view tweets
  As an authenticated user
  I should be able to view various twitter streams provided to me

  @vcr
  Scenario: User sees last 25 tweets by default
    Given I want to authenticate
    And I have valid authentication credentials
    When I launch the application
    Then I should see the latest 25 tweets from my timeline
