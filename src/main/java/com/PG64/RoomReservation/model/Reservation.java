package com.PG64.RoomReservation.model;

import java.time.LocalDate;

public class Reservation {
    private int reservationId;
    private int roomId;
    private int userId;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private String status; // PENDING, CONFIRMED, CANCELLED, COMPLETED
    private double totalPrice;

    public Reservation(int reservationId, int roomId, int userId, LocalDate checkInDate, 
                      LocalDate checkOutDate, String status, double totalPrice) {
        this.reservationId = reservationId;
        this.roomId = roomId;
        this.userId = userId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.status = status;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    // Convert reservation to string for file storage
    @Override
    public String toString() {
        return String.format("%d,%d,%d,%s,%s,%s,%.2f",
                reservationId, roomId, userId,
                checkInDate.toString(), checkOutDate.toString(),
                status, totalPrice);
    }

    // Create reservation from string
    public static Reservation fromString(String str) {
        String[] parts = str.split(",");
        return new Reservation(
                Integer.parseInt(parts[0]), // reservationId
                Integer.parseInt(parts[1]), // roomId
                Integer.parseInt(parts[2]), // userId
                LocalDate.parse(parts[3]),  // checkInDate
                LocalDate.parse(parts[4]),  // checkOutDate
                parts[5],                   // status
                Double.parseDouble(parts[6]) // totalPrice
        );
    }
} 