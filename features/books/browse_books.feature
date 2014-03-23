Feature: Browse books
  As an anonymous user
  I want to browse for books according to categories

  Background:
    Given System has 2 categories, each has 15 books

  Scenario: User sees category list
    When I visit the Categories page
    Then I should see the links to all categories listed

  Scenario: User browses for books by selecting a category
    When I visit category 1 link
    Then I should see book 1 to 10 of category 1
    And I should see page 2 for the other books
    When I click on page 2
    Then I should see book 11 to 15 of category 1