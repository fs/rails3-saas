Feature: Sign up
  In order to use service
  As a user
  I want to create account

  Scenario: New user creates account with valid data
    When I go to the sign up page
    And I submit valid user and credit card registration information
    Then account should be created
    And I should be signed in
    And I should receive an email with a link to a confirmation page
    And I should be on the home page
    When I click on the confirmation link in the confirmation email
    Then I should be signed in
    And I should be on the home page

  Scenario: New user creates account with invalid user data
    When I go to the sign up page
    And I submit invalid user registration information
    Then I should see errors for the user registration information

  Scenario: New user creates account with invalid credit card data
    When I go to the sign up page
    And I submit invalid credit card registration information
    Then I should see errors for the credit card registration information

  Scenario: Authenticated user creates account with credit card data
    When I go to the sign up page
    Then I should see my user credentials will be used for new account
    When I submit valid credit card information
    Then account should be created
    And I should be on the home page