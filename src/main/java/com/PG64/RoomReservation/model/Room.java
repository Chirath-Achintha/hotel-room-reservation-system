package com.PG64.RoomReservation.model;

public abstract class Room {
    private int roomId;
    private String roomNumber;
    private double price;
    private boolean available;

    public Room(int roomId, String roomNumber, double price, boolean available) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.price = price;
        this.available = available;
    }

    // Getters and setters
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    // Abstract methods
    public abstract String getRoomType();
    
    // Abstract method for getting room details
    public abstract String getRoomDetails();

    // Static factory method to create room from string
    public static Room fromString(String str) {
        String[] parts = str.split(",");
        int id = Integer.parseInt(parts[0]);
        String number = parts[1];
        double price = Double.parseDouble(parts[2]);
        boolean available = Boolean.parseBoolean(parts[3]);
        String type = parts[4];

        switch (type) {
            case "DELUXE":
                boolean hasJacuzzi = Boolean.parseBoolean(parts[5]);
                boolean hasMinibar = Boolean.parseBoolean(parts[6]);
                return new DeluxeRoom(id, number, price, available, hasJacuzzi, hasMinibar);
            case "EXECUTIVE":
                boolean hasSeparateLivingRoom = Boolean.parseBoolean(parts[5]);
                boolean hasWorkspace = Boolean.parseBoolean(parts[6]);
                boolean hasKitchenette = Boolean.parseBoolean(parts[7]);
                return new ExecutiveSuite(id, number, price, available, hasSeparateLivingRoom, hasWorkspace, hasKitchenette);
            case "PRESIDENTIAL":
                boolean hasPrivatePool = Boolean.parseBoolean(parts[5]);
                boolean hasButlerService = Boolean.parseBoolean(parts[6]);
                boolean hasPanoramicView = Boolean.parseBoolean(parts[7]);
                boolean hasPrivateDining = Boolean.parseBoolean(parts[8]);
                return new PresidentialSuite(id, number, price, available, hasPrivatePool, hasButlerService, hasPanoramicView, hasPrivateDining);
            default: // STANDARD
                int beds = Integer.parseInt(parts[5]);
                boolean hasBalcony = Boolean.parseBoolean(parts[6]);
                return new StandardRoom(id, number, price, available, beds, hasBalcony);
        }
    }

    // Convert room to string for file storage
    @Override
    public String toString() {
        return String.format("%d,%s,%.2f,%b,%s", roomId, roomNumber, price, available, getRoomType());
    }
}