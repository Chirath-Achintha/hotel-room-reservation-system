package com.PG64.RoomReservation.model;

public class LaundryService extends Service {
    public LaundryService(int serviceId, String name, String description, double price, boolean available) {
        super(serviceId, name, description, price, available);
    }
    @Override
    public String getServiceDetails() {
        return "Laundry Service: " + getName() + " - " + getDescription() + " ($" + getPrice() + ")";
    }
} 