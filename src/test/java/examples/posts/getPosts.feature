Feature: Get All Posts

  Background:
    * url "https://jsonplaceholder.typicode.com/"
    * path 'posts'

  @github_actions
  Scenario: Get All Posts
    Given method get
    Then status 200