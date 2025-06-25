package com.PG64.RoomReservation.model;

public class ExecutiveSuite extends Room {
    private boolean hasSeparateLivingRoom;
    private boolean hasWorkspace;
    private boolean hasKitchenette;

    public ExecutiveSuite(int roomId, String roomNumber, double price, boolean available, 
                         boolean hasSeparateLivingRoom, boolean hasWorkspace, boolean hasKitchenette) {
        super(roomId, roomNumber, price, available);
        this.hasSeparateLivingRoom = hasSeparateLivingRoom;
        this.hasWorkspace = hasWorkspace;
        this.hasKitchenette = hasKitchenette;
    }

    @Override
    public String getRoomType() {
        return "EXECUTIVE";
    }

    @Override
    public String getRoomDetails() {
        return String.format("Executive Suite - Room %s: Separate Living Room: %s, Workspace: %s, Kitchenette: %s", 
            getRoomNumber(), hasSeparateLivingRoom ? "Yes" : "No", 
            hasWorkspace ? "Yes" : "No", hasKitchenette ? "Yes" : "No");
    }

    @Override
    public String toString() {
        return String.format("%s,%b,%b,%b", super.toString(), hasSeparateLivingRoom, hasWorkspace, hasKitchenette);
    }

    // Getters and setters
    public boolean isHasSeparateLivingRoom() {
        return hasSeparateLivingRoom;
    }

    public void setHasSeparateLivingRoom(boolean hasSeparateLivingRoom) {
        this.hasSeparateLivingRoom = hasSeparateLivingRoom;
    }

    public boolean isHasWorkspace() {
        return hasWorkspace;
    }

    public void setHasWorkspace(boolean hasWorkspace) {
        this.hasWorkspace = hasWorkspace;
    }

    public boolean isHasKitchenette() {
        return hasKitchenette;
    }

    public void setHasKitchenette(boolean hasKitchenette) {
        this.hasKitchenette = hasKitchenette;
    }
} 