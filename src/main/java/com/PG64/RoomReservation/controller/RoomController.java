package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.*;
import com.PG64.RoomReservation.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    // Admin: Manage rooms
    @GetMapping("/manage")
    public String manageRooms(@RequestParam(value = "searchQuery", required = false) String searchQuery, Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        List<Room> rooms;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            rooms = new java.util.ArrayList<>();
            // Try to parse as ID
            try {
                int id = Integer.parseInt(searchQuery.trim());
                Room room = roomService.getRoomById(id);
                if (room != null) rooms.add(room);
            } catch (NumberFormatException e) {
                // Not an ID, search by room number
                for (Room r : roomService.getAllRooms()) {
                    if (r.getRoomNumber().equalsIgnoreCase(searchQuery.trim())) {
                        rooms.add(r);
                    }
                }
            }
        } else {
            rooms = roomService.getAllRooms();
        }
        model.addAttribute("rooms", rooms);
        return "room/manage";
    }

    // Add new room
    @PostMapping("/add")
    public String addRoom(
            @RequestParam String roomNumber,
            @RequestParam String roomType,
            @RequestParam double price,
            @RequestParam(required = false) Integer numberOfBeds,
            @RequestParam(required = false) Boolean hasBalcony,
            @RequestParam(required = false) Boolean hasJacuzzi,
            @RequestParam(required = false) Boolean hasMinibar,
            HttpSession session,
            Model model) {

        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        Room newRoom;
        int roomId = roomService.generateRoomId();

        if ("DELUXE".equals(roomType)) {
            newRoom = new DeluxeRoom(
                    roomId,
                    roomNumber,
                    price,
                    true,
                    hasJacuzzi != null && hasJacuzzi,
                    hasMinibar != null && hasMinibar
            );
        } else {
            newRoom = new StandardRoom(
                    roomId,
                    roomNumber,
                    price,
                    true,
                    numberOfBeds != null ? numberOfBeds : 1,
                    hasBalcony != null && hasBalcony
            );
        }

        if (roomService.addRoom(newRoom)) {
            model.addAttribute("success", "Room added successfully");
        } else {
            model.addAttribute("error", "Failed to add room");
        }

        return "redirect:/room/manage";
    }

    // Toggle room availability
    @PostMapping("/toggle/{roomId}")
    public String toggleAvailability(@PathVariable int roomId, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        Room room = roomService.getRoomById(roomId);
        if (room != null) {
            room.setAvailable(!room.isAvailable());
            roomService.updateRoom(room);
        }

        return "redirect:/room/manage";
    }

    // Delete room
    @PostMapping("/delete/{roomId}")
    public String deleteRoom(@PathVariable int roomId, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        roomService.deleteRoom(roomId);
        return "redirect:/room/manage";
    }

    // Display room catalog
    @GetMapping("/catalog")
    public String showRoomCatalog(Model model, HttpSession session) {
        List<Room> rooms = roomService.getAllRooms();
        model.addAttribute("rooms", rooms);
        
        // Add user to model to check admin status in view
        User currentUser = (User) session.getAttribute("user");
        model.addAttribute("user", currentUser);
        
        return "room/catalog";
    }

    // Edit room (admin only)
    @GetMapping("/edit/{roomId}")
    public String editRoom(@PathVariable int roomId, Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }
        Room room = roomService.getRoomById(roomId);
        if (room == null) {
            return "redirect:/room/manage";
        }
        model.addAttribute("room", room);
        return "room/edit";
    }

    // Update room (admin only)
    @PostMapping("/update")
    public String updateRoom(
            @RequestParam int roomId,
            @RequestParam String roomNumber,
            @RequestParam double price,
            @RequestParam boolean available,
            @RequestParam String roomType,
            @RequestParam(required = false) Integer numberOfBeds,
            @RequestParam(required = false) Boolean hasBalcony,
            @RequestParam(required = false) Boolean hasJacuzzi,
            @RequestParam(required = false) Boolean hasMinibar,
            HttpSession session,
            Model model) {
        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }
        Room updatedRoom;
        if ("DELUXE".equals(roomType)) {
            updatedRoom = new DeluxeRoom(
                roomId,
                roomNumber,
                price,
                available,
                hasJacuzzi != null && hasJacuzzi,
                hasMinibar != null && hasMinibar
            );
        } else {
            updatedRoom = new StandardRoom(
                roomId,
                roomNumber,
                price,
                available,
                numberOfBeds != null ? numberOfBeds : 1,
                hasBalcony != null && hasBalcony
            );
        }
        roomService.updateRoom(updatedRoom);
        return "redirect:/room/manage";
    }

    // Search rooms
    @GetMapping("/search")
    public String searchRooms(
            @RequestParam(required = false) String roomType,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            Model model) {

        List<Room> results;
        if (minPrice != null && maxPrice != null) {
            // Use BST for price range search
            results = roomService.searchRooms(roomType, minPrice, maxPrice);
        } else {
            // Use BST for type-only search
            results = roomService.searchRooms(roomType, null);
        }

        model.addAttribute("results", results);
        model.addAttribute("roomType", roomType);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        return "room/search";
    }

    // Show room details
    @GetMapping("/details/{roomId}")
    public String showRoomDetails(@PathVariable int roomId, Model model) {
        Room room = roomService.getRoomById(roomId);
        if (room != null) {
            model.addAttribute("room", room);
            return "room/details";
        }
        return "redirect:/room/catalog";
    }
}