package com.PG64.RoomReservation.model;

public class Housekeeping extends Staff {
    public Housekeeping(int staffId, String name, String email, String department, String contactNumber, boolean isActive) {
        super(staffId, name, email, department, contactNumber, isActive);
    }

    @Override
    public String getDuties() {
        return "Clean rooms, maintain common areas, report issues.";
    }

    @Override
    public String getRole() {
        return "Housekeeping";
    }
} 