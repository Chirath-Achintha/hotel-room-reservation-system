package com.PG64.RoomReservation.model;

import java.time.LocalDate;

public class Booking {
    private String bookingId;
    private String username;
    private int roomId;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private double totalPrice;
    private String status; // "CONFIRMED", "CANCELLED", "COMPLETED"
    private String specialRequests;

    // Default constructor for form binding
    public Booking() {
        this.status = "PENDING";
        this.specialRequests = "";
    }

    public Booking(String bookingId, String username, int roomId, LocalDate checkInDate, 
                  LocalDate checkOutDate, double totalPrice, String status, String specialRequests) {
        this.bookingId = bookingId;
        this.username = username;
        this.roomId = roomId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.specialRequests = specialRequests;
    }

    // Calculate number of nights
    public int getNumberOfNights() {
        return checkOutDate.compareTo(checkInDate);
    }

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public LocalDate getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDate checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDate getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDate checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    @Override
    public String toString() {
        return String.format("Booking ID: %s | User ID: %s | Room ID: %d | Dates: %s to %s | Price: $%.2f",
                bookingId, username, roomId, checkInDate, checkOutDate, totalPrice);
    }
}