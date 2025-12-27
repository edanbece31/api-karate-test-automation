Feature: Delete Pets

  Background:
    * url baseUrl
    * path 'pets'

  Scenario: delete a pet
    Given request {  "name": "Bingo7",   "type": "Perro",   "age": 5}
    And method post
    And status 201
    And def petId = $.data.id
    When url "http://localhost:3000/pets/" + petId
    And method delete
    Then status 204