Feature: Search Pets

  @search_existing_pet
  Scenario: Search a new dog
    * call read('createPets.feature@create_successful_pet')
    Given url "http://localhost:3000/pets/" + petId
    When method get
    Then status 200
