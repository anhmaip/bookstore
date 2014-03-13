Feature: Confirm user account
  In order to activate the user account after signing up
  As a newly registered user
  I want to be able to confirm my account via email

    Scenario: User confirms new account successfully
      Given I have signed up for a new account
      And I have not confirmed before
      When I click on the confirmation link in the confirmation email
      Then I should be redirected to the Sign in page
      And I should see a successfully confirmed message
      And My User database record is updated with confirmed time

