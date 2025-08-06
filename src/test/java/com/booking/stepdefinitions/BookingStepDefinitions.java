package com.booking.stepdefinitions;

import com.booking.utils.APIResources;
import com.booking.utils.TestContext;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.module.jsv.JsonSchemaValidator;
import io.restassured.response.Response;
import org.json.JSONObject;

import java.util.Map;
import java.util.Random;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class BookingStepDefinitions {
    private JSONObject requestBody;
    private TestContext context;
    private Response response;

    public BookingStepDefinitions(TestContext context) {
        this.context = context;
    }

    private static int generateRandomRoomId() {
        final Random random = new Random();
        return (3000 + random.nextInt(900)); // Generates a number between 3000 and 3999
    }

    @Given("User wants to do a booking with below booking details")
    public void userWantsToDoABookingWithBelowBookingDetails(DataTable bookingDetails) {
        for (Map<String, String> row : bookingDetails.asMaps(String.class, String.class)) {
            final int roomId = generateRandomRoomId();
            context.setSessionContext("roomId", String.valueOf(roomId));

            requestBody = createBookingRequestBody(row, roomId);
            row.forEach((key, value) -> {
                context.setSessionContext(key, value);
            });
        }
    }

    private JSONObject createBookingRequestBody(Map<String, String> row, int roomid) {
        int bookingid = generateRandomRoomId();
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
    public void userSendsAPOSTRequestToWithTheBookingDetails(String endpoint) {
        APIResources resourceAPI = APIResources.valueOf(endpoint);
        response = context.requestSpec.body(requestBody.toString()).when().post(resourceAPI.getResource());
        context.setResponse(response);
    }

    @Then("the response status code should be {int}")
    public void theResponseStatusCodeShouldBe(int statusCode) {
        response.then().statusCode(statusCode);
    }

    @Then("the response should match the {string} json schema")
    public void theResponseShouldMatchTheJsonSchema(final String schemaFileName) {
        response.then()
                .assertThat()
                .body(JsonSchemaValidator.matchesJsonSchemaInClasspath("schemas/" + schemaFileName));
    }

    @And("the response should contain the created booking details")
    public void theResponseShouldContainTheCreatedBookingDetails() {
        assertEquals(context.getSessionContext("firstname"), response.jsonPath().getString("bookings[0].firstname"), "Mismatch in firstname value");
        assertEquals(context.getSessionContext("lastname"), response.jsonPath().getString("bookings[0].lastname"), "Mismatch in lastname value");
        assertEquals(context.getSessionContext("depositpaid"), response.jsonPath().getString("bookings[0].depositpaid"), "Mismatch in depositpaid value");
        assertEquals(context.getSessionContext("checkin"), response.jsonPath().getString("bookings[0].bookingdates.checkin"), "Mismatch in checkin value");
        assertEquals(context.getSessionContext("checkout"), response.jsonPath().getString("bookings[0].bookingdates.checkout"), "Mismatch in checkout value");
        assertEquals(context.getSessionContext("email"), response.jsonPath().getString("bookings[0].email"), "Mismatch in email value");
        assertEquals(context.getSessionContext("phone"), response.jsonPath().getString("bookings[0].phone"), "Mismatch in phone value");
    }
}
