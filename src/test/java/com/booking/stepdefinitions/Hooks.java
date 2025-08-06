package com.booking.stepdefinitions;

import com.booking.utils.TestContext;
import io.cucumber.java.Before;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;

import static io.restassured.RestAssured.given;

public class Hooks {
    private TestContext context;

    public Hooks(TestContext context) {
        this.context = context;
    }

    @Before
    public void setup() {
        RestAssured.reset();
        RequestSpecification request = new RequestSpecBuilder()
                .setBaseUri("https://automationintesting.online")
                .setContentType(ContentType.JSON)
                .setAccept("application/json")
                .build();

        context.requestSpec = given().spec(request);
    }
}
