Feature: Action Plan SEO
  As a marketeer
  I want our content to include clear meta data
  So that search engines can decide what meets the needs of their customers

  Scenario Outline: Action Plan include a canonical tag
    Given I view an action plan in <locale>
    Then the action plan should have a canonical tag for that language version

  Examples:
    | locale  |
    | English |
    | Welsh   |
