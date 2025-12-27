Feature: Create new Pets

  Background:
    * url baseUrl
    * path 'pets'

  Scenario: Create a new dog
    Given request {  "name": "Bingo3",   "type": "Perro",   "age": 1}
    When method post
    Then status 201
    And match $.message contains 'Pet created'

  Scenario: Search a new dog
    Given request {  "name": "Bingo4",   "type": "Perro",   "age": 2}
    And method post
    And status 201
    And def petId = $.data.id
    When url "http://localhost:3000/pets/" + petId
    And method get
    Then status 200

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

  Scenario: delete a pet
    Given request {  "name": "Bingo7",   "type": "Perro",   "age": 5}
    And method post
    And status 201
    And def petId = $.data.id
    When url "http://localhost:3000/pets/" + petId
    And method delete
    Then status 204

  Scenario Outline: Create multiple pets
    Given request {  "name": "<name>",   "type": "<type>",   "age": <age>}
    When method post
    Then status 201
    And match $.message contains 'Pet created'

    Examples:
      | name    | type   | age |
      | Max     | Dog    | 2   |
      | Whiskers| Cat    | 3   |
      | Tweety  | Bird   | 1   |


  Scenario Outline: Create multiple pets with <description>
    Given request {  "name": "<name>",   "type": "<type>",   "age": <age>}
    When method post
    Then status 201
    And match $.message contains 'Pet created'

    Examples:
      | name    | type   | age |description|
      | Max hfsjdkhfhjkl<dfghjkshd  | Dog    | 2   |long name|
      | Whiskers /(%/($%| Cat    | 3   |Special characters|

    
    Scenario: Create a new dog reading an external json file
        * def requestCreateNewPet = read('classpath:requests/createNewPet.json')
        * def successfulResponse = read('classpath:responses/successfulCreateNewPet.json')

    Given request requestCreateNewPet
    When method post
    Then status 201
    And match $.message contains 'Pet created'
    And match response == successfulResponse


    Scenario: Create a new dog reading an external json file template

        * def name = 'Coco'
        * def type = 'ballena'
        * def age = 4
        * def requestCreateNewPet = read('classpath:requests/createNewPetTemplate.json')
        * def successfulResponse = read('classpath:responses/successfulCreateNewPet.json')

    Given request requestCreateNewPet
    When method post
    Then status 201
    And match $.message contains 'Pet created'
    And match response == successfulResponse
    And match $.data == { id: '#number', name: '#(name)', type: '#(type)', age: #(age) }
    