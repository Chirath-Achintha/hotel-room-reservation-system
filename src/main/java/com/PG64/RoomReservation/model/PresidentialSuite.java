package com.PG64.RoomReservation.model;

public class PresidentialSuite extends Room {
    private boolean hasPrivatePool;
    private boolean hasButlerService;
    private boolean hasPanoramicView;
    private boolean hasPrivateDining;

    public PresidentialSuite(int roomId, String roomNumber, double price, boolean available,
                            boolean hasPrivatePool, boolean hasButlerService, 
                            boolean hasPanoramicView, boolean hasPrivateDining) {
        super(roomId, roomNumber, price, available);
        this.hasPrivatePool = hasPrivatePool;
        this.hasButlerService = hasButlerService;
        this.hasPanoramicView = hasPanoramicView;
        this.hasPrivateDining = hasPrivateDining;
    }

    @Override
    public String getRoomType() {
        return "PRESIDENTIAL";
    }

    @Override
    public String getRoomDetails() {
        return String.format("Presidential Suite - Room %s: Private Pool: %s, Butler Service: %s, Panoramic View: %s, Private Dining: %s",
            getRoomNumber(), hasPrivatePool ? "Yes" : "No",
            hasButlerService ? "Yes" : "No", hasPanoramicView ? "Yes" : "No",
            hasPrivateDining ? "Yes" : "No");
    }

    @Override
    public String toString() {
        return String.format("%s,%b,%b,%b,%b", super.toString(), 
            hasPrivatePool, hasButlerService, hasPanoramicView, hasPrivateDining);
    }

    // Getters and setters
    public boolean isHasPrivatePool() {
        return hasPrivatePool;
    }

    public void setHasPrivatePool(boolean hasPrivatePool) {
        this.hasPrivatePool = hasPrivatePool;
    }

    public boolean isHasButlerService() {
        return hasButlerService;
    }

    public void setHasButlerService(boolean hasButlerService) {
        this.hasButlerService = hasButlerService;
    }

    public boolean isHasPanoramicView() {
        return hasPanoramicView;
    }

    public void setHasPanoramicView(boolean hasPanoramicView) {
        this.hasPanoramicView = hasPanoramicView;
    }

    public boolean isHasPrivateDining() {
        return hasPrivateDining;
    }

    public void setHasPrivateDining(boolean hasPrivateDining) {
        this.hasPrivateDining = hasPrivateDining;
    }
} 