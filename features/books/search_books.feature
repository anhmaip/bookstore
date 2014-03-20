Feature: Search for books
  As an anonymous user
  I want to search for books by (part of) book title, author name, category

  Background:
    Given System has 2 categories, each has 5 books
    And Each category has 1 book with title containing "interesting book"
    And Each category has 1 book with author name containing "arthur"
    And I visit the Home page

  Scenario: User searches for books by book title without choosing category
    When I enter search box with "interesting book"
    And I click on "Search" button
    Then I should see 2 books with title containing "interesting book"

  Scenario: User searches for books by book title with category 1 chosen
    When I enter search box with "interesting book"
    And I select category 1
    And I click on "Search" button
    Then I should see 1 books with title containing "interesting book", which belongs to category 1

  Scenario: User searches for books by author name without choosing category
    When I enter search box with "arthur"
    And I click on "Search" button
    Then I should see 2 books with author name containing "arthur"

  Scenario: User searches for books by author name with category 1 chosen
    When I enter search box with "arthur"
    And I select category 1
    And I click on "Search" button
    Then I should see 1 books with author name containing "arthur", which belongs to category 1

  Scenario: User searches without keyword and without category
    When I click on "Search" button
    Then I should see 10 books

  Scenario: User searches without keyword and with category 1 chosen
    When  I select category 1
    And I click on "Search" button
    Then I should see 5 books belonging to category 1
    
  Scenario: No book matches keyword
    When I enter search box with "non-existing book"
    And I click on "Search" button
    Then I should see 0 book