package com.PG64.RoomReservation.model;

import java.time.LocalDate;

public class ServiceReview extends Review {
    private int serviceId;
    private String staffBehavior;
    private String serviceQuality;
    private String valueForMoney;

    public ServiceReview() {
        super();
        this.type = "SERVICE";
    }

    public ServiceReview(int reviewId, int userId, int serviceId, int rating, 
                        String comment, LocalDate reviewDate, String status,
                        String staffBehavior, String serviceQuality, String valueForMoney) {
        super(reviewId, userId, rating, comment, reviewDate, status, "SERVICE");
        this.serviceId = serviceId;
        this.staffBehavior = staffBehavior;
        this.serviceQuality = serviceQuality;
        this.valueForMoney = valueForMoney;
    }

    @Override
    public String getReviewDetails() {
        return String.format("Service Review - Rating: %d/5\nStaff Behavior: %s\nService Quality: %s\nValue for Money: %s\nComment: %s",
                getRating(), staffBehavior, serviceQuality, valueForMoney, getComment());
    }

    // Getters and Setters
    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getStaffBehavior() {
        return staffBehavior;
    }

    public void setStaffBehavior(String staffBehavior) {
        this.staffBehavior = staffBehavior;
    }

    public String getServiceQuality() {
        return serviceQuality;
    }

    public void setServiceQuality(String serviceQuality) {
        this.serviceQuality = serviceQuality;
    }

    public String getValueForMoney() {
        return valueForMoney;
    }

    public void setValueForMoney(String valueForMoney) {
        this.valueForMoney = valueForMoney;
    }
} 