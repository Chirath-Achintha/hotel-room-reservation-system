package com.PG64.RoomReservation.model;

import java.time.LocalDate;

public class RoomReview extends Review {
    private int roomId;
    private String cleanliness;
    private String comfort;
    private String location;

    public RoomReview() {
        super();
        this.type = "ROOM";
    }

    public RoomReview(int reviewId, int userId, int roomId, int rating, 
                     String comment, LocalDate reviewDate, String status,
                     String cleanliness, String comfort, String location) {
        super(reviewId, userId, rating, comment, reviewDate, status, "ROOM");
        this.roomId = roomId;
        this.cleanliness = cleanliness;
        this.comfort = comfort;
        this.location = location;
    }

    @Override
    public String getReviewDetails() {
        return String.format("Room Review - Rating: %d/5\nCleanliness: %s\nComfort: %s\nLocation: %s\nComment: %s",
                getRating(), cleanliness, comfort, location, getComment());
    }

    // Getters and Setters
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getCleanliness() {
        return cleanliness;
    }

    public void setCleanliness(String cleanliness) {
        this.cleanliness = cleanliness;
    }

    public String getComfort() {
        return comfort;
    }

    public void setComfort(String comfort) {
        this.comfort = comfort;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
} 