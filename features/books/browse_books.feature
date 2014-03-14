Feature: Browse books
  As an anonymous user
  I want to browse for books according to categories

    Background:
      Given Categories have been pre-populated

    Scenario: User sees category list on Home page
      When I visit the Home page
      Then I should see all categories listed
