package com.PG64.RoomReservation.model;

public class StandardRoom extends Room {
    private int numberOfBeds;
    private boolean hasBalcony;

    public StandardRoom(int roomId, String roomNumber, double price, boolean available, 
                       int numberOfBeds, boolean hasBalcony) {
        super(roomId, roomNumber, price, available);
        this.numberOfBeds = numberOfBeds;
        this.hasBalcony = hasBalcony;
    }

    @Override
    public String getRoomDetails() {
        return String.format("Standard Room %s - %d beds%s - $%.2f/night", 
            getRoomNumber(), 
            numberOfBeds, 
            hasBalcony ? " with balcony" : "",
            getPrice());
    }

    public int getNumberOfBeds() {
        return numberOfBeds;
    }

    public void setNumberOfBeds(int numberOfBeds) {
        this.numberOfBeds = numberOfBeds;
    }

    public boolean hasBalcony() {
        return hasBalcony;
    }

    public void setHasBalcony(boolean hasBalcony) {
        this.hasBalcony = hasBalcony;
    }

    @Override
    public String getRoomType() {
        return "STANDARD";
    }

    @Override
    public String toString() {
        return String.format("%s,%d,%b", super.toString(), numberOfBeds, hasBalcony);
    }
}