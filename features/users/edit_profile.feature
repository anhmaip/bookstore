Feature: Edit user profile
  In order to update my profile information
  As a registered user
  I want to edit my user profile

    Background:
      Given I have an activated account
      And I sign in with valid email and password

    Scenario: User edits profile successfully
      When I edit my user profile
      Then I should see "You updated your account successfully"