package com.PG64.RoomReservation.model;

public class RegularUser extends User {
    private String membershipType; // e.g., "STANDARD", "PREMIUM"
    private int loyaltyPoints;
    private boolean isPremium;

    public RegularUser(int id, String username, String password, String email) {
        super(id, username, password, email);
        this.membershipType = "STANDARD";
        this.loyaltyPoints = 0; // Initialize with 0 points
        this.isPremium = false;
    }

    public RegularUser(int id, String username, String password, String email, boolean isPremium) {
        super(id, username, password, email);
        this.membershipType = "STANDARD";
        this.loyaltyPoints = 0; // Initialize with 0 points
        this.isPremium = isPremium;
    }

    // Polymorphic method - Custom behavior for regular users
    public String getMembershipBenefits() {
        return switch (membershipType) {
            case "PREMIUM" -> "Premium benefits: Free late check-out, 10% discount";
            default -> "Standard benefits: Basic access";
        };
    }

    // Getters and Setters
    public String getMembershipType() {
        return membershipType;
    }

    public void setMembershipType(String membershipType) {
        this.membershipType = membershipType;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void addLoyaltyPoints(int points) {
        this.loyaltyPoints += points;
    }

    public boolean isPremium() {
        return isPremium;
    }

    public void setPremium(boolean premium) {
        isPremium = premium;
    }

    @Override
    public String getUserTypeDescription() {
        return isPremium ? "Regular User (Premium)" : "Regular User";
    }
}