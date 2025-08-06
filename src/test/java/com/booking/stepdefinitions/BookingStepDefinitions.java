package com.booking.stepdefinitions;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.json.JSONObject;

public class BookingStepDefinitions {
    @Given("User wants to do a booking with below booking details")
    public void userWantsToDoABookingWithBelowBookingDetails() {
    private JSONObject createBookingRequestBody(Map<String, String> row, int roomid) {
        int bookingid = 456;
        return new JSONObject()
                .put("bookingid", bookingid)
                .put("roomid", roomid)
                .put("firstname", safeValue(row.get("firstname")))
                .put("lastname", safeValue(row.get("lastname")))
                .put("depositpaid", true)
                .put("email", safeValue(row.get("email")))
                .put("phone", safeValue(row.get("phone")))
                .put("bookingdates", new JSONObject()
                        .put("checkin", safeValue(row.get("checkin")))
                        .put("checkout", safeValue(row.get("checkout"))));
    }

    private String safeValue(String value) {
        return value == null ? "" : value;
    }

    @When("User sends a POST request to {string} with the booking details")
    public void userSendsAPOSTRequestToWithTheBookingDetails(String arg0) {
    }

    @Then("the response status code should be {int}")
    public void theResponseStatusCodeShouldBe(int arg0) {
    }

    @And("the response should match the {string} json schema")
    public void theResponseShouldMatchTheJsonSchema(String arg0) {
    }

    @And("the response should contain the created booking details")
    public void theResponseShouldContainTheCreatedBookingDetails() {
    }
}
