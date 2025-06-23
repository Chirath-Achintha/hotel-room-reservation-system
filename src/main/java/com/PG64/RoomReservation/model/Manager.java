package com.PG64.RoomReservation.model;

public class Manager extends Staff {
    public Manager(int staffId, String name, String email, String department, String contactNumber, boolean isActive) {
        super(staffId, name, email, department, contactNumber, isActive);
    }

    @Override
    public String getDuties() {
        return "Manage department, supervise staff, ensure quality service.";
    }

    @Override
    public String getRole() {
        return "Manager";
    }
} 