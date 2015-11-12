Feature: Testing storyteller role and permissions

  Background:
    Given pages:
      | title       | url                         |
      | Admin       | /admin                      |
      | Content     | /admin/content              |
      | Add Story   | /node/add/dkan-data-story   |
    Given users:
      | name         | mail                  | status     | roles     |
      | storyteller  | storyteller@test.com  | 1          | storyteller |
    Given "Tags" terms:
      | name    |
      | Health  |
    Given data stories:
      | title           | description | author      | status   | tags     |
      | Data Story 01   | Test post   | storyteller | No       | Health   |

  @api
  Scenario: Can see the administration menu
    Given I am logged in as "storyteller"
    When I am on the homepage
    Then I should see the administration menu

  @api
  Scenario: Can see administration pages
    Given I am logged in as "storyteller"
    When I am on the "Admin" page
    Then I should see "Content"

  @api
  Scenario: Access content overview
    Given I am logged in as "storyteller"
    When I am on the "Content" page
    Then I should see "About"

  @api
  Scenario: Create Story Content
    Given I am logged in as "storyteller"
    When I am on the "Add Story" page
      And I fill in "Title" with "Test Story Post"
      And I fill in "Body" with "Test description"
      And I press "Save"
    Then I should see "DKAN Data Story 'Test Story Post' has been created"

  @api
  Scenario: Delete own story content
    Given I am logged in as "storyteller"
    When I am on the "Data Story 01" page
      And I click "Edit"
      And I press "Delete"
      And I press "Delete"
    Then I should see "DKAN Data Story Data Story 01 has been deleted."

  @api
  Scenario: Edit own story content
    Given I am logged in as "storyteller"
      And I am on the "Data Story 01" page
    When I click "Edit"
      And I fill in "Body" with "Test description Update"
      And I press "Save"
    Then I should see "DKAN Data Story Data Story 01 has been updated"

  @api @javascript
  Scenario: Use text format filtered_html
    Given I am logged in as "storyteller"
    When I am on the "Add Story" page
    Then I should have an "html" text format option 

  @api
  Scenario: View own unpublished content
    Given I am logged in as "storyteller"
    When I am on the "Data Story 01" page
    Then I should see "Test post"
      And I should see "Data Story 01"
