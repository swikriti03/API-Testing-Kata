@booking_regression @update_booking
Feature: Update Booking

  Background:
    Given User wants to do a booking with below booking details
      | firstname | lastname | depositpaid | email            | phone         | checkin    | checkout   |
      | Micheal   | Jordan   | true        | michael@test.com | 0123456789545 | 2025-08-10 | 2025-08-15 |
    When User sends a POST request to "CreateBookingAPI" with the booking details
    Then the response status code should be 200
    When User sends a GET request to "GetBookingsByRoomIDAPI"
    Then the response status code should be 200

  Scenario: Update a booking by booking ID
    When User sends a PUT request to "UpdateBookingAPI" with the following details
      | firstname | lastname | depositpaid | email            | phone       | checkin    | checkout   |
      | John      | Cena     | true        | john@example.com | 12345678901 | 2025-10-01 | 2025-10-05 |
    Then the response status code should be 200
    And the response should match the "CreateUpdateBookingSchema.json" json schema
    And the response should contain the updated booking details

  Scenario: User should get error when trying to update a booking with invalid booking ID
    When User sends a PUT request to "UpdateBookingAPI" with the following details with invalid booking ID
      | firstname | lastname | depositpaid | email            | phone       | checkin    | checkout   |
      | John      | Cena     | true        | john@example.com | 12345678901 | 2025-10-01 | 2025-10-05 |
    Then the response status code should be 500

  Scenario: User should not be authorised to update booking details with an invalid token
    When User sends a PUT request to "UpdateBookingAPI" with an invalid token and the following details
      | firstname | lastname | depositpaid | email            | phone       | checkin    | checkout   |
      | John      | Cena     | true        | john@example.com | 12345678901 | 2025-10-01 | 2025-10-05 |
    Then the response status code should be 500

  Scenario: User should not be authorised to update booking details without a valid token
    When User sends a PUT request to "UpdateBookingAPI" without a token and the following details
      | firstname | lastname | depositpaid | email            | phone       | checkin    | checkout   |
      | John      | Cena     | true        | john@example.com | 12345678901 | 2025-10-01 | 2025-10-05 |
    Then the response status code should be 401

  @test
  Scenario Outline: Updating an existing booking should fail if mandatory fields are missing or invalid values are passed
    When User sends a PUT request to "UpdateBookingAPI" with the following details to check error responses
      | firstname   | lastname   | depositpaid   | email   | phone   | checkin   | checkout   | roomid   |
      | <firstname> | <lastname> | <depositpaid> | <email> | <phone> | <checkin> | <checkout> | <roomid> |
    Then the response status code should be 400
    And the response should contain the error message "<errorMsg>"

    Examples:
      | firstname | lastname | depositpaid | email           | phone        | checkin    | checkout   | roomid | errorMsg                                                                                             |
      |           | Anguez   | true        | Rocky@test.com  | 787865432213 | 2025-08-10 | 2025-08-17 | 3001   | size must be between 3 and 18, Firstname should not be blank                                         |
      | Rocky     |          | true        | Rocky@test.com  | 787865432213 | 2025-08-10 | 2025-08-12 | 3001   | size must be between 3 and 30, Lastname should not be blank                                          |
      | 123@/     | Anguez   | true        | Rocky@test.com  | 787865432213 | 2025-08-10 | 2025-08-17 | 3001   | Firstname should be a valid string                                                                   |
      | Rocky     | 123@/    | true        | Rocky@test.com  | 787865432213 | 2025-08-10 | 2025-08-12 | 3001   | Lastname should be a valid string                                                                    |
      | j         | Anguez   | false       | Rocky@test.com  | 787865432213 | 2025-08-10 | 2025-08-15 | 3001   | size must be between 3 and 18                                                                        |
      | Rocky     | v        | false       | Rocky@test.com  | 787865432213 | 2025-08-10 | 2025-08-15 | 3001   | size must be between 3 and 30                                                                        |
      | Rocky     | Anguez   | false       | jvik!gmail.com  | 787865432213 | 2025-08-10 | 2025-08-15 | 3001   | must be a well-formed email address                                                                  |
      | Rocky     | Anguez   | false       | Rocky@test.com  | 123          | 2025-08-10 | 2025-08-15 | 3001   | size must be between 11 and 21                                                                       |
      | Rocky     | Anguez   | false       | jRocky@test.com | 787865432213 |            | 2025-08-15 | 3001   | must not be null                                                                                     |
      | Rocky     | Anguez   | false       | Rocky@test.com  | 787865432213 | 2025-08-10 |            | 3001   | must not be null                                                                                     |
      | Rocky     | Anguez   | false       |                 | 787865432213 | 2025-08-10 | 2025-08-12 | 3001   | must not be empty                                                                                    |
      | Rocky     | Anguez   | false       |                 |              | 2025-08-10 | 2025-08-12 | 3001   | must not be empty, size must be between 11 and 21, must not be empty                                 |
      |           |          | false       | Rocky@test.com  | 787865432213 | 2025-08-10 | 2025-08-15 | 3001   | Lastname should not be blank, Firstname should not be blank, size must be between 3 and 30, 3 and 18 |
      | Rocky     | Anguez   | dsd         | Rocky@test.com  | 66765451326  | 2025-08-10 | 2025-08-12 | 3041   | depositpaid should be a boolean value                                                                |
      | Rocky     | Anguez   |             | Rocky@test.com  | 66765451326  | 2025-08-10 | 2025-08-12 | 3041   | depositpaid should not be blank                                                                      |
      | Rocky     | Anguez   | true        | Rocky@test.com  | 66765451326  | 2025-08-10 | 2025-08-12 | 0      | must be greater than or equal to 1                                                                   |

