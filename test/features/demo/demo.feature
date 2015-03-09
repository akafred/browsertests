# encoding: UTF-8
# language: en

Feature: Demonstration
  As a Test-Driven Developer
  In order to improve the world
  I want to demonstrate a way to automate browser-based feature tests

  Scenario: Search on koha
    Given I am on the koha front page
    When I search for "Cucumber"
    Then I should find it in the results

  Scenario: Search on DuckDuckGo which does not track you
    Given I am on the DuckDuckGo front page
    When I search for "Cucumber" without being tracked
    Then I should find it in the results without being tracked

  # coming up ... but hard because they have language dependent pages
  @wip
  Scenario: Search on Google
    Given I am on the Google front page
    When I search for "Cucumber" in Google
    Then I should find it in the Google results

  # will probably never be implemented ...
  @ignore
  Scenario: Search on Bing

