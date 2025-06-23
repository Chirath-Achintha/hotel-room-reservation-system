package com.PG64.RoomReservation.model;

import java.time.LocalDate;

public class PremiumUser extends User {
    private int loyaltyPoints;
    private LocalDate premiumStartDate;
    private String premiumBenefits;

    public PremiumUser(int id, String username, String password, String email) {
        super(id, username, password, email);
        this.loyaltyPoints = 0;
        this.premiumStartDate = LocalDate.now();
        this.premiumBenefits = "Free late check-out, 10% discount, VIP support";
    }

    public PremiumUser(int id, String username, String password, String email, int loyaltyPoints, LocalDate premiumStartDate, String premiumBenefits) {
        super(id, username, password, email);
        this.loyaltyPoints = loyaltyPoints;
        this.premiumStartDate = premiumStartDate;
        this.premiumBenefits = premiumBenefits;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void addLoyaltyPoints(int points) {
        this.loyaltyPoints += points;
    }

    public LocalDate getPremiumStartDate() {
        return premiumStartDate;
    }

    public void setPremiumStartDate(LocalDate premiumStartDate) {
        this.premiumStartDate = premiumStartDate;
    }

    public String getPremiumBenefits() {
        return premiumBenefits;
    }

    public void setPremiumBenefits(String premiumBenefits) {
        this.premiumBenefits = premiumBenefits;
    }

    @Override
    public String getUserTypeDescription() {
        return "Premium User";
    }
} 