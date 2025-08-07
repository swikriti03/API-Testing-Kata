@booking_regression @get_booking_by_roomID
Feature: Get booking by room id

  Background:
    Given User wants to do a booking with below booking details
      | firstname | lastname | depositpaid | email            | phone         | checkin    | checkout   |
      | Micheal   | Jordan   | true        | michael@test.com | 0123456789545 | 2025-08-10 | 2025-08-15 |
    When User sends a POST request to "CreateBookingAPI" with the booking details
    Then the response status code should be 200

  Scenario: User should be able to retrieve booking details using room ID
    When User sends a GET request to "GetBookingsByRoomIDAPI"
    Then the response status code should be 200
    And the response should match the "RetrieveBookingByRoomIDSchema.json" json schema
    And the response should contain the created booking details

  Scenario: User should not get any booking details for a room that is not booked
    When User sends a GET request to "GetBookingsByRoomIDAPI" with unbooked room ID
    Then the response status code should be 200
    And the response should contain empty booking details

  Scenario: User should be informed of bad request when he tries to get a booking using invalid room ID
    When User sends a GET request to "GetBookingsByRoomIDAPI" with invalid room ID as ""
    Then the response status code should be 400
    And the error response should say "Room ID is required"

  @noAuth
  Scenario: User should not be authorised to get booking details with an invalid token
    When User sends a GET request to "GetBookingsByRoomIDAPI" with an invalid token
    Then the response status code should be 500

  @noAuth
  Scenario: User should not be authorised to get booking details without a valid token
    When User sends a GET request to "GetBookingsByRoomIDAPI" without a token
    Then the response status code should be 401
