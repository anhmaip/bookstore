Feature: View book details
  As an anonymous user
  I want to view the details of any book

  Background:
    Given System has some books

  Scenario: User views book details
    When I visit the link of a book
    Then I should see all details of the book
    And I should see the comment list of the book