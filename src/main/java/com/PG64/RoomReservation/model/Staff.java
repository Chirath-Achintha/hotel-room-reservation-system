package com.PG64.RoomReservation.model;

public abstract class Staff {
    private int staffId;
    private String name;
    private String email;
    private String department;
    private String contactNumber;
    private boolean isActive;

    public Staff(int staffId, String name, String email, String department, String contactNumber, boolean isActive) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.department = department;
        this.contactNumber = contactNumber;
        this.isActive = isActive;
    }

    public Staff() {}

    // Getters and Setters
    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public abstract String getDuties();
    public abstract String getRole();

    @Override
    public String toString() {
        return String.format("%s - %s", name, department);
    }
}