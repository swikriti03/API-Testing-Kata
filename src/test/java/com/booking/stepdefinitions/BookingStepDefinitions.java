package com.booking.stepdefinitions;

import com.booking.utils.APIResources;
import com.booking.utils.TestContext;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.json.JSONObject;
import java.util.Map;
import java.util.Random;

import static io.restassured.RestAssured.given;

public class BookingStepDefinitions {
    private JSONObject requestBody;
    private TestContext context;
    private Response response;

    @Given("User wants to do a booking with below booking details")
    public void userWantsToDoABookingWithBelowBookingDetails(DataTable bookingDetails) {
        for (Map<String, String> row : bookingDetails.asMaps(String.class, String.class)) {
            final int roomId = generateRandomRoomId();
            System.out.println("Row = " + row);
            requestBody = createBookingRequestBody(row, roomId);
            System.out.println("requestBody = " + requestBody);

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

    private static int generateRandomRoomId() {
        final Random random = new Random();
        return (3000 + random.nextInt(900)); // Generates a number between 3000 and 3999
    }
    @When("User sends a POST request to {string} with the booking details")
    public void userSendsAPOSTRequestToWithTheBookingDetails(String endpoint) {
        RequestSpecification request = new RequestSpecBuilder()
                .setBaseUri("https://automationintesting.online")
                .setContentType(ContentType.JSON)
                .setAccept("application/json")
                .build();

        context.requestSpec = given().spec(request);

        APIResources resourceAPI = APIResources.valueOf(endpoint);
        response = context.requestSpec.body(requestBody.toString()).when().post(resourceAPI.getResource());
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
