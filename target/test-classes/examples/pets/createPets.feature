Feature: Create new Pets

  Background:
    * url baseUrl
    * path 'pets'

  @create_successful_pet
  Scenario: Create a new dog
    Given request {  "name": "Bingo5",   "type": "Perro",   "age": 1}
    When method post
    Then status 201
    And match $.message contains 'Pet created'
    * def petId = $.data.id