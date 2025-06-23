package com.PG64.RoomReservation.service;

import com.PG64.RoomReservation.model.Reservation;
import com.PG64.RoomReservation.model.Room;
import com.PG64.RoomReservation.util.FileUtil;
import com.PG64.RoomReservation.util.ReservationSorter;
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
public class ReservationService {

    @Autowired
    private FileUtil fileUtil;

    @Autowired
    private RoomService roomService;

    @Value("${reservations.file.path}")
    private String reservationsFilePath;

    private List<Reservation> reservations;
    private AtomicInteger lastReservationId;

    @PostConstruct
    public void init() {
        reservations = new ArrayList<>();
        lastReservationId = new AtomicInteger(0);
        loadReservations();
    }

    private void loadReservations() {
        try {
            List<String> lines = fileUtil.readLines(reservationsFilePath);
            for (String line : lines) {
                Reservation reservation = Reservation.fromString(line);
                reservations.add(reservation);
                if (reservation.getReservationId() > lastReservationId.get()) {
                    lastReservationId.set(reservation.getReservationId());
                }
            }
        } catch (IOException e) {
            // First time running, create empty file
            saveReservations();
        }
    }

    private void saveReservations() {
        try {
            List<String> lines = reservations.stream()
                    .map(Reservation::toString)
                    .collect(Collectors.toList());
            fileUtil.writeLines(reservationsFilePath, lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Create new reservation
    public Reservation createReservation(int roomId, int userId, LocalDate checkInDate, 
                                       LocalDate checkOutDate) {
        // Validate room availability
        Room room = roomService.getRoomById(roomId);
        if (room == null || !room.isAvailable()) {
            return null;
        }

        // Calculate total price
        long nights = checkOutDate.toEpochDay() - checkInDate.toEpochDay();
        double totalPrice = room.getPrice() * nights;

        // Create reservation
        Reservation reservation = new Reservation(
                lastReservationId.incrementAndGet(),
                roomId,
                userId,
                checkInDate,
                checkOutDate,
                "PENDING",
                totalPrice
        );

        reservations.add(reservation);
        room.setAvailable(false);
        roomService.updateRoom(room);
        saveReservations();

        return reservation;
    }

    // Get all reservations (sorted by check-in date)
    public List<Reservation> getAllReservations() {
        List<Reservation> sortedReservations = new ArrayList<>(reservations);
        ReservationSorter.quickSort(sortedReservations);
        return sortedReservations;
    }

    // Get user's reservations (sorted by check-in date)
    public List<Reservation> getUserReservations(int userId) {
        List<Reservation> userReservations = reservations.stream()
                .filter(r -> r.getUserId() == userId)
                .collect(Collectors.toList());
        ReservationSorter.quickSort(userReservations);
        return userReservations;
    }

    // Get upcoming reservations (sorted by check-in date)
    public List<Reservation> getUpcomingReservations() {
        LocalDate today = LocalDate.now();
        List<Reservation> upcomingReservations = reservations.stream()
                .filter(r -> r.getCheckInDate().isAfter(today))
                .collect(Collectors.toList());
        ReservationSorter.quickSort(upcomingReservations);
        return upcomingReservations;
    }

    // Update reservation status
    public boolean updateReservationStatus(int reservationId, String newStatus) {
        for (Reservation reservation : reservations) {
            if (reservation.getReservationId() == reservationId) {
                reservation.setStatus(newStatus);
                
                // If cancelled, make room available again
                if ("CANCELLED".equals(newStatus)) {
                    Room room = roomService.getRoomById(reservation.getRoomId());
                    if (room != null) {
                        room.setAvailable(true);
                        roomService.updateRoom(room);
                    }
                }
                
                saveReservations();
                return true;
            }
        }
        return false;
    }

    // Cancel reservation
    public boolean cancelReservation(int reservationId) {
        return updateReservationStatus(reservationId, "CANCELLED");
    }

    // Get reservation by ID
    public Reservation getReservationById(int reservationId) {
        return reservations.stream()
                .filter(r -> r.getReservationId() == reservationId)
                .findFirst()
                .orElse(null);
    }

    // Get reservations for a specific room (sorted by check-in date)
    public List<Reservation> getRoomReservations(int roomId) {
        List<Reservation> roomReservations = reservations.stream()
                .filter(r -> r.getRoomId() == roomId)
                .collect(Collectors.toList());
        ReservationSorter.quickSort(roomReservations);
        return roomReservations;
    }

    // Get reservations by status (sorted by check-in date)
    public List<Reservation> getReservationsByStatus(String status) {
        List<Reservation> statusReservations = reservations.stream()
                .filter(r -> r.getStatus().equals(status))
                .collect(Collectors.toList());
        ReservationSorter.quickSort(statusReservations);
        return statusReservations;
    }

    // Get latest reservations (sorted by check-in date in descending order)
    public List<Reservation> getLatestReservations(int limit) {
        List<Reservation> sortedReservations = new ArrayList<>(reservations);
        ReservationSorter.quickSortDescending(sortedReservations);
        return sortedReservations.stream()
                .limit(limit)
                .collect(Collectors.toList());
    }
} 