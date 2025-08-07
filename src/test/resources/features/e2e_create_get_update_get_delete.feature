@e2e_scenario
Feature: End to end booking journey

  Background:
    Given User wants to do a booking with below booking details
      | firstname | lastname | depositpaid | email              | phone        | checkin    | checkout   |
      | Salman    | Khan     | true        | salman@example.com | 987654321444 | 2025-10-01 | 2025-10-15 |
    When User sends a POST request to "CreateBookingAPI" with the booking details
    Then the response status code should be 200
    When User sends a GET request to "GetBookingsByRoomIDAPI"
    Then the response status code should be 200

  @sanity
  Scenario: User should be able to create a booking, fetch its details, update its details, fetch updated details and finally delete the booking
    When User sends a PUT request to "UpdateBookingAPI" with the following details
      | firstname | lastname | depositpaid | email            | phone       | checkin    | checkout   |
      | John      | Cena     | true        | john@example.com | 12345678901 | 2025-12-01 | 2025-12-05 |
    Then the response status code should be 200
    When User sends a GET request to "GetBookingsByRoomIDAPI"
    Then the response status code should be 200
    When User sends a DELETE request to "DeleteBookingAPI"
    Then the response status code should be 200
