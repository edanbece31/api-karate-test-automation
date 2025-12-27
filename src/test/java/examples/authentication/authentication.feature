Feature: Authentication Examples
Scenario: Basic Authentication
    * def credentials = "admin:password123"
    * def encodedCredentials = java.util.Base64.getEncoder().encodeToString(credentials.getBytes())
    Given url "http://localhost:3000"
    And path "/protected-basic"
    And header Authorization = 'Basic ' + encodedCredentials
    When method get
    Then status 200

Scenario: Basic Authentication Unauthorization
    * def credentials = "admin:password1234"
    * def encodedCredentials = java.util.Base64.getEncoder().encodeToString(credentials.getBytes())
    Given url "http://localhost:3000"
    And path "/protected-basic"
    And header Authorization = 'Basic ' + encodedCredentials
    When method get
    Then status 401

Scenario: Bearer Token Authentication
    Given url "http://localhost:3000"
    And path "/login"
    And request {"username": "automation"}
    When method post
    Then status 200
    And def token = $.data.accessToken
    Given url "http://localhost:3000"
    And path "/protected-bearer"
    And header Authorization = 'Bearer ' + token
    When method get
    Then status 200

Scenario: Bearer Token no Authorization
    Given url "http://localhost:3000"
    And path "/login"
    And request {"username": "automation"}
    When method post
    Then status 200
    And def token = $.data.accessToken
    Given url "http://localhost:3000"
    And path "/protected-bearer"
    And header Authorization = 'Bearer e' + token
    When method get
    Then status 403