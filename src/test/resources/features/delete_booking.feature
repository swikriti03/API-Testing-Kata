@booking_regression @delete_booking
Feature: Delete Booking

  Background:
    Given User wants to do a booking with below booking details
      | firstname | lastname | depositpaid | email            | phone         | checkin    | checkout   |
      | Micheal   | Jordan   | true        | michael@test.com | 0123456789545 | 2025-08-10 | 2025-08-15 |
    When User sends a POST request to "CreateBookingAPI" with the booking details
    Then the response status code should be 200
    When User sends a GET request to "GetBookingsByRoomIDAPI"
    Then the response status code should be 200

  Scenario: User should be able to delete a booking using valid booking ID
    When User sends a DELETE request to "DeleteBookingAPI"
    Then the response status code should be 200
    And the response should match the "DeleteBookingSchema.json" json schema

  @error_validation
  Scenario: User should not be authorised to delete booking details with an invalid token
    When User sends a DELETE request to "DeleteBookingAPI" with an invalid token
    Then the response status code should be 500

  @error_validation
  Scenario: User should not be authorised to delete booking details without a valid token
    When User sends a DELETE request to "DeleteBookingAPI" without a token
    Then the response status code should be 401
