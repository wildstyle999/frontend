Feature: View news index
  As a visitor to the website
  I want to see a selection of news
  So that I can select an article to read easily

  Scenario Outline: User sees a list of news
    When I visit the news page in <language>
    Then I see a list of news in <language>

  Examples:
    | language |
    | English  |
    | Welsh    |

  Scenario: Browsing paginated results
    When I visit the news page
    Then I should see the 'Older' button
    And I should not see the 'Newer' button
    When I go to the next page of results
    And I should see the 'Older' button
    And I should see the 'Newer' button

  # BUG: Implementation of NewsDecorator#next_page? not correct
  # If the last page has 10 items it expects another page afterwards
  @wip
  Scenario: Last page
    When I visit the last news page
    Then I should not see the 'Older' button
    And I should see the 'Newer' button
