package com.booking.stepdefinitions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class BookingStepDefinitions {
    @Given("User wants to do a booking with below booking details")
    public void userWantsToDoABookingWithBelowBookingDetails() {
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
