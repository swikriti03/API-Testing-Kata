@booking_regression @create_booking @noAuth
Feature: Create Booking

  Scenario: User should be able to create booking with valid details
    Given User wants to do a booking with below booking details
      | firstname | lastname | depositpaid | email            | phone         | checkin    | checkout   |
      | Micheal   | Jordan   | true        | michael@test.com | 0123456789545 | 2025-08-10 | 2025-08-15 |
    When User sends a POST request to "CreateBookingAPI" with the booking details
    Then the response status code should be 200
    And the response should match the "CreateUpdateBookingSchema.json" json schema
    And the response should contain the created booking details

  Scenario Outline: Booking should fail if mandatory fields are missing or invalid values are passed
    Given User wants to do a booking with below booking details to check error responses
      | firstname   | lastname   | depositpaid   | email   | phone   | checkin   | checkout   | roomid   |
      | <firstname> | <lastname> | <depositpaid> | <email> | <phone> | <checkin> | <checkout> | <roomid> |
    When User sends a POST request to "CreateBookingAPI" with the booking details
    Then the response status code should be 400
    And the response should contain the error message "<expectedErrorMessage>"

    Examples:
      | firstname | lastname | depositpaid | email                  | phone        | checkin    | checkout   | roomid | expectedErrorMessage                                                                                                      |
      |           | Sylvan   | true        | kate_merlin@gmail.com  | 908979675645 | 2025-08-10 | 2025-08-15 | 123    | size must be between 3 and 18, Firstname should not be blank                                                              |
      | Micheal   |          | true        | jack_sparrow@gmail.com | 554167891099 | 2025-08-10 | 2025-08-15 | 125    | size must be between 3 and 30, Lastname should not be blank                                                               |
      | 123@/     | Sylvan   | true        | kate_merlin@gmail.com  | 908979675645 | 2025-08-10 | 2025-08-15 | 121    | Firstname should be a valid string                                                                                        |
      | Jack      | 123@/    | true        | jack_sparrow@gmail.com | 554167891099 | 2025-08-10 | 2025-08-15 | 129    | Lastname should be a valid string                                                                                         |
      | m         | Jordan   | false       | Jordan_vinc@gmail.com  | 545478786543 | 2025-08-10 | 2025-08-15 | 133    | size must be between 3 and 18                                                                                             |
      | Micheal   | v        | false       | Jordan_vinc@gmail.com  | 545478786543 | 2025-08-10 | 2025-08-15 | 11     | size must be between 3 and 30                                                                                             |
      | Micheal   | Jordan   | false       | Jordan!gmail.com       | 545478786543 | 2025-08-10 | 2025-08-15 | 103    | must be a well-formed email address                                                                                       |
      | Micheal   | Jordan   | false       | Jordan@gmail.com       | 121212       | 2025-08-10 | 2025-08-15 | 23     | size must be between 11 and 21                                                                                            |
      | Micheal   | Jordan   | false       | Jordan@gmail.com       | 545478786543 |            | 2025-08-15 | 53     | must not be null                                                                                                          |
      | Micheal   | Jordan   | false       | Jordan@gmail.com       | 545478786543 | 2025-06-12 |            | 45     | must not be null                                                                                                          |
      | Micheal   | Jordan   | false       |                        | 545478786543 | 2025-06-12 | 2025-06-12 | 63     | must not be empty                                                                                                         |
      | Micheal   | Jordan   | false       |                        |              | 2025-06-12 | 2025-06-12 | 19     | must not be empty, size must be between 11 and 21, must not be empty                                                      |
      |           |          | false       | Jordan_vinc@gmail.com  | 545478786543 | 2025-06-12 | 2025-06-15 | 78     | Lastname should not be blank, Firstname should not be blank, size must be between 3 and 30, size must be between 3 and 18 |
      | Musk      | Elon     |             | TONY@test.com          | 48447654513  | 2025-06-11 | 2025-06-12 | 47     | Depositpaid should not be blank                                                                                           |
      | Tony      | Blair    | false       | TONY@test.com          | 48447654513  | 2020-12-11 | 2020-12-12 | 100    | Invalid booking dates                                                                                                     |
      | John      | Blair    | false       | john@test.com          | 48447654513  | 2020-12-11 | 2020-12-12 | 0      | must be greater than or equal to 1                                                                                        |

