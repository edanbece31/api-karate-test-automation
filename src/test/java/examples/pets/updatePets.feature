 Feature: Update Pets

  Background:
    * url baseUrl
    * path 'pets'
 
 Scenario: update a pet
    Given request {  "name": "Bingo5",   "type": "Perro",   "age": 3}
    And method post
    And status 201
    And def petId = $.data.id
    When url "http://localhost:3000/pets/" + petId
    And request {  "name": "coco2",   "type": "gato",   "age": 30}
    And method put
    Then status 200
    And match $.data == { id: '#(petId)', name: 'coco2', type: 'gato', age: 30 }

  Scenario: update a resource from a pet
    Given request {  "name": "Bingo6",   "type": "Perro",   "age": 4}
    And method post
    And status 201
    And def petId = $.data.id
    When url "http://localhost:3000/pets/" + petId
    And request {  "type": "Gato",   "age": 40}
    And method patch
    Then status 200
    And match $.data == { id: '#(petId)', name: 'Bingo6', type: 'Gato', age: 40 }