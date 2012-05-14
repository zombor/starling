# These need to be split up in order to do VCR stuff. Is there a bette way?
Given /^I want to authenticate$/ do
  steps %{
    Given I am an unauthenticated user
    When I attempt to authenticate
    Then I should see the twitter oauth authentication url
    And I should be asked to enter the oauth code
  }
end

Given /^I have valid authentication credentials$/ do
  steps %{
    When I provide the correct pin to the challenge
    Then a twitter oauth token should be saved for the account
  }
end

When /^I launch the application$/ do
end

Then /^I should see the latest (\d+) tweets from my timeline$/ do |arg1|
  timeline = Starling::Timeline::Mine.new(@store)

  tweets = timeline.latest

  timeline.stop

  tweets.length.should == 25
end
