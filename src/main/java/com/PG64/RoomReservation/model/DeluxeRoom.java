package com.PG64.RoomReservation.model;

public class DeluxeRoom extends Room {
    private boolean hasJacuzzi;
    private boolean hasMinibar;

    public DeluxeRoom(int roomId, String roomNumber, double price, boolean available,
                     boolean hasJacuzzi, boolean hasMinibar) {
        super(roomId, roomNumber, price, available);
        this.hasJacuzzi = hasJacuzzi;
        this.hasMinibar = hasMinibar;
    }

    @Override
    public String getRoomDetails() {
        return String.format("Deluxe Room %s - Jacuzzi: %s, Minibar: %s - $%.2f/night",
            getRoomNumber(),
            hasJacuzzi ? "Yes" : "No",
            hasMinibar ? "Yes" : "No",
            getPrice());
    }

    public boolean hasJacuzzi() {
        return hasJacuzzi;
    }

    public void setHasJacuzzi(boolean hasJacuzzi) {
        this.hasJacuzzi = hasJacuzzi;
    }

    public boolean hasMinibar() {
        return hasMinibar;
    }

    public void setHasMinibar(boolean hasMinibar) {
        this.hasMinibar = hasMinibar;
    }

    @Override
    public String getRoomType() {
        return "DELUXE";
    }

    @Override
    public String toString() {
        return String.format("%s,%b,%b", super.toString(), hasJacuzzi, hasMinibar);
    }
}