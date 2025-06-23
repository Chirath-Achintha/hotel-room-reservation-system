package com.PG64.RoomReservation.service;

import com.PG64.RoomReservation.model.*;
import com.PG64.RoomReservation.util.BST;
import com.PG64.RoomReservation.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
public class RoomService {

    @Autowired
    private FileUtil fileUtil;

    @Value("${rooms.file.path}")
    private String roomsFilePath;

    private BST roomBST;
    private AtomicInteger lastRoomId;

    @PostConstruct
    public void init() {
        roomBST = new BST();
        lastRoomId = new AtomicInteger(0);
        loadRooms();
    }

    // Load rooms from file and build BST
    private void loadRooms() {
        try {
            List<String> lines = fileUtil.readLines(roomsFilePath);
            for (String line : lines) {
                Room room = Room.fromString(line);
                if (room != null) {
                    roomBST.insert(room);
                    if (room.getRoomId() > lastRoomId.get()) {
                        lastRoomId.set(room.getRoomId());
                    }
                }
            }
        } catch (IOException e) {
            // First time running, create empty file
            saveRooms(new ArrayList<>());
        }
    }

    // Save rooms to file
    private void saveRooms(List<Room> rooms) {
        try {
            List<String> lines = new ArrayList<>();
            for (Room room : rooms) {
                lines.add(room.toString());
            }
            fileUtil.writeLines(roomsFilePath, lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Generate new room ID
    public int generateRoomId() {
        return lastRoomId.incrementAndGet();
    }

    // Add a new room
    public boolean addRoom(Room room) {
        roomBST.insert(room);
        saveRooms(roomBST.inOrderTraversal());
        return true;
    }

    // Get room by ID
    public Room getRoomById(int roomId) {
        return roomBST.search(roomId);
    }

    // Update existing room
    public boolean updateRoom(Room room) {
        // Since BST is organized by ID, we need to delete and reinsert
        roomBST.delete(room.getRoomId());
        roomBST.insert(room);
        saveRooms(roomBST.inOrderTraversal());
        return true;
    }

    // Delete room
    public void deleteRoom(int roomId) {
        roomBST.delete(roomId);
        saveRooms(roomBST.inOrderTraversal());
    }

    // Get all rooms
    public List<Room> getAllRooms() {
        return roomBST.inOrderTraversal();
    }

    // Get available rooms
    public List<Room> getAvailableRooms() {
        return roomBST.getAvailableRooms();
    }

    // Search rooms by type and price range
    public List<Room> searchRooms(String roomType, Double minPrice, Double maxPrice) {
        List<Room> rooms = roomBST.searchByPriceRange(minPrice != null ? minPrice : 0.0, maxPrice != null ? maxPrice : Double.MAX_VALUE);
        
        if (roomType != null && !roomType.isEmpty()) {
            rooms.removeIf(room -> !room.getClass().getSimpleName().toUpperCase().startsWith(roomType.toUpperCase()));
        }
        
        return rooms;
    }

    // Search rooms by type only
    public List<Room> searchRooms(String roomType, Double maxPrice) {
        return searchRooms(roomType, 0.0, maxPrice != null ? maxPrice : Double.MAX_VALUE);
    }

    // Calculate price for a stay
    public double calculatePrice(int roomId, LocalDate checkIn, LocalDate checkOut) {
        Room room = getRoomById(roomId);
        if (room != null) {
            long nights = checkOut.compareTo(checkIn);
            return room.getPrice() * nights;
        }
        return 0.0;
    }

    public Room getRoomByNumber(String roomNumber) {
        for (Room room : getAllRooms()) {
            if (room.getRoomNumber().equalsIgnoreCase(roomNumber)) {
                return room;
            }
        }
        return null;
    }
}