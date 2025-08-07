package com.booking.stepdefinitions;

import com.POJO.AuthAPIReq;
import com.booking.utils.APIResources;
import com.booking.utils.JsonLoggingFilter;
import com.booking.utils.ReadProperties;
import com.booking.utils.TestContext;
import io.cucumber.java.Before;
import io.cucumber.java.BeforeAll;
import io.cucumber.java.Scenario;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.builder.ResponseSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;

import java.io.File;

import static io.restassured.RestAssured.given;

public class Hooks {
    private TestContext context;

    public Hooks(TestContext context) {
        this.context = context;
    }

    @BeforeAll
    public static void before_or_after_all() {
        ReadProperties.PropertyReader();
        new File("target/logs").mkdirs();
    }

    @Before(value = "not @noAuth", order = 0)
    public void beforeScenario(Scenario scenario) {
        RestAssured.reset();
        RestAssured.filters(new JsonLoggingFilter());
        AuthAPIReq authAPIReq = new AuthAPIReq();
        authAPIReq.setUsername(ReadProperties.getValue("user.username"));
        authAPIReq.setPassword(ReadProperties.getValue("user.password"));

        APIResources resourceAPI = APIResources.valueOf("GetAuthTokenAPI");

        RequestSpecification request = new RequestSpecBuilder().setBaseUri(ReadProperties.getValue("application.baseURI")).
                setContentType(ContentType.JSON).build();
        RequestSpecification res = given().spec(request).body(authAPIReq);
        ResponseSpecification responseSpecification = new ResponseSpecBuilder().
                expectStatusCode(200).expectContentType(ContentType.JSON).build();
        Response response = res.when().post(resourceAPI.getResource())
                .then().spec(responseSpecification).extract().response();

        String token = response.path("token");
        context.setSessionContext("token", token);
    }

    @Before(order = 1)
    public void setup() {
        RestAssured.reset();
        RestAssured.filters(new JsonLoggingFilter());
        RequestSpecification request = new RequestSpecBuilder()
                .setBaseUri(ReadProperties.getValue("application.baseURI"))
                .setContentType(ContentType.JSON)
                .setAccept(ReadProperties.getValue("accept"))
                .build();

        context.requestSpec = given().spec(request);
    }

}
