package com.PG64.RoomReservation.model;

public class Receptionist extends Staff {
    public Receptionist(int staffId, String name, String email, String department, String contactNumber, boolean isActive) {
        super(staffId, name, email, department, contactNumber, isActive);
    }

    @Override
    public String getDuties() {
        return "Handle check-ins/outs, manage reservations, assist guests.";
    }

    @Override
    public String getRole() {
        return "Receptionist";
    }
} 