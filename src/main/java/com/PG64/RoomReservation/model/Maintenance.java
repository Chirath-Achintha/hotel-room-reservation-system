package com.PG64.RoomReservation.model;

public class Maintenance extends Staff {
    public Maintenance(int staffId, String name, String email, String department, String contactNumber, boolean isActive) {
        super(staffId, name, email, department, contactNumber, isActive);
    }

    @Override
    public String getDuties() {
        return "Perform repairs, maintain equipment, ensure safety.";
    }

    @Override
    public String getRole() {
        return "Maintenance";
    }
} 