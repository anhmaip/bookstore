Feature: Confirm user account
  In order to activate the user account after signing up
  As a user
  I want to be able to confirm my account via email

    Scenario: User confirms new account
      Given I have signed up for a new account
      When I click on the confirmation link in the confirmation email
      Then I should be redirected to the Sign in page
      And I should see a successfully confirmed message
      And My User database record is updated with confirmed time

