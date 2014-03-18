Feature: Rate and comment books
  As an activated user
  I can add rating (1 to 5) and comment to any book once

  Background:
    Given I have an activated account
    And System has some books

  Scenario: Not signed in user cannot comment on book
    When I visit the link of a book
    Then I should not see "comment" box

  Scenario: Not signed in user cannot rate book
    When I visit the link of a book
    Then I should not see "rate" box

  Scenario: Signed in user can only comment once
    When I sign in with valid email and password
    And I visit the link of a book
    And I have commented on that book before
    Then I should not see "comment" box

  Scenario: Signed in user can only rate once
    When I sign in with valid email and password
    And I visit the link of a book
    And I have rated that book before
    Then I should not see "rate" box

  Scenario: Signed in user can rate and comment on book for the first time
    When I sign in with valid email and password
    And I visit the link of a book
    Then I should see "comment" box
    And I should see "rate" box
    When I comment "My comment" and rate 3
    Then I should see "Comment posted!"

  Scenario: User can only rate when also comment
    When I sign in with valid email and password
    And I visit the link of a book
    When I comment "" and rate 3
    Then I should see "Error occured while posting comment, please try again!"