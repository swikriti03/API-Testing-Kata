package com.booking.utils;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.HashMap;
import java.util.Map;

public class TestContext {
    public RequestSpecification requestSpec;
    public Response response;
    public Map<String, Object> session = new HashMap<>();
    public Response getResponse() {
        return response;
    }
    public void setResponse(Response response) {
        this.response = response;
    }
}
