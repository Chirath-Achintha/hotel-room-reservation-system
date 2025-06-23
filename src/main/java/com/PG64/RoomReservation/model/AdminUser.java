package com.PG64.RoomReservation.model;

public class AdminUser extends User {
    private String adminLevel; // e.g., "SUPER_ADMIN", "MANAGER", etc.

    public AdminUser(int id, String username, String password, String email, String adminLevel) {
        super(id, username, password, email);
        this.adminLevel = adminLevel;
    }

    // Polymorphic method
    public String getAccessLevel() {
        return "Admin Access: " + this.adminLevel;
    }

    // Getters and Setters
    public String getAdminLevel() {
        return adminLevel;
    }

    public void setAdminLevel(String adminLevel) {
        this.adminLevel = adminLevel;
    }

    @Override
    public String getUserTypeDescription() {
        return "Administrator (" + adminLevel + ")";
    }
}