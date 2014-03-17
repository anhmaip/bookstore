Feature: Rate and comment books
  As an activated user
  I can add rating (1 to 5) and comment to any book once

  Background:
    Given I have an activated account
    And System has some books

  Scenario: Not signed in user cannot comment on book
    Given I visit the link of a book
    Then I should not see "Comment" box

  Scenario: Not signed in user cannot rate book
    Given I visit the link of a book
    Then I should not see "Rate" box

  Scenario: Signed in user can comment on book for the first time
    Given I sign in with valid email and password
    And I visit the link of a book
    And I have not commented on that book before
    Then I can comment on that book

  Scenario: Signed in user can rate book for the first time
    Given I sign in with valid email and password
    And I visit the link of a book
    And I have not rated that book before
    Then I can rate that book

  Scenario: Signed in user can only comment once
    Given I sign in with valid email and password
    And I visit the link of a book
    And I have commented on that book before
    Then I should not see "Comment" box

  Scenario: Signed in user can only rate once
    Given I sign in with valid email and password
    And I visit the link of a book
    And I have rated that book before
    Then I should not see "Rate" box