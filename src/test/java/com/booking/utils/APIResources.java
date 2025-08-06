package com.booking.utils;

public enum APIResources {
    GetAuthTokenAPI("/api/auth/login"),
    CreateBookingAPI("/api/booking");

    private String resource;

    APIResources(String resource) {
        this.resource = resource;
    }

    public String getResource() {
        return resource;
    }
}
