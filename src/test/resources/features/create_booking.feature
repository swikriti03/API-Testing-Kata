@booking_regression @create_booking
Feature: Create Booking

  Scenario: User should be able to create booking with valid details
    Given User wants to do a booking with below booking details
      | firstname | lastname | depositpaid | email            | phone      | checkin    | checkout   |
      | Micheal   | Jordan   | true        | michael@test.com | 0123456789 | 2025-08-10 | 2025-08-15 |
    When User sends a POST request to "CreateBookingAPI" with the booking details
    Then the response status code should be 200
    And the response should match the "CreateUpdateBookingSchema.json" json schema
    And the response should contain the created booking details