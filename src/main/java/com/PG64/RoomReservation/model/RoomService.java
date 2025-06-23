package com.PG64.RoomReservation.model;

public class RoomService extends Service {
    public RoomService(int serviceId, String name, String description, double price, boolean available) {
        super(serviceId, name, description, price, available);
    }
    @Override
    public String getServiceDetails() {
        return "Room Service: " + getName() + " - " + getDescription() + " ($" + getPrice() + ")";
    }
} 