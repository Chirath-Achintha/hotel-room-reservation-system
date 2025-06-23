package com.PG64.RoomReservation.model;

import java.time.LocalDate;

public abstract class Review {
    private int reviewId;
    private int userId;
    private int rating;
    private String comment;
    private LocalDate reviewDate;
    private String status; // PENDING, APPROVED, REJECTED
    protected String type; // ROOM, SERVICE

    public Review() {
        this.reviewDate = LocalDate.now();
        this.status = "PENDING";
    }

    public Review(int reviewId, int userId, int rating, String comment, 
                 LocalDate reviewDate, String status, String type) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.status = status;
        this.type = type;
    }

    // Abstract method to be implemented by subclasses
    public abstract String getReviewDetails();

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDate getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(LocalDate reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return String.format("Review ID: %d | User ID: %d | Rating: %d | Date: %s",
                reviewId, userId, rating, reviewDate);
    }
}