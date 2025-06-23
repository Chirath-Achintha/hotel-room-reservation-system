package com.PG64.RoomReservation.model;

public class SpaService extends Service {
    public SpaService(int serviceId, String name, String description, double price, boolean available) {
        super(serviceId, name, description, price, available);
    }
    @Override
    public String getServiceDetails() {
        return "Spa Service: " + getName() + " - " + getDescription() + " ($" + getPrice() + ")";
    }
} 