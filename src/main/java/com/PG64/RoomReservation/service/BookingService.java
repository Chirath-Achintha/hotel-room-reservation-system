package com.PG64.RoomReservation.service;

import com.PG64.RoomReservation.model.Booking;
import com.PG64.RoomReservation.model.Room;
import com.PG64.RoomReservation.util.FileUtil;
import com.PG64.RoomReservation.util.QuickSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Objects;
import java.time.temporal.ChronoUnit;

@Service
public class BookingService {

    @Autowired
    private FileUtil fileUtil;

    @Autowired
    private QuickSort quickSort;

    @Value("${bookings.file.path}")
    private String bookingsFilePath;

    private final RoomService roomService;

    public BookingService(FileUtil fileUtil, RoomService roomService) {
        this.fileUtil = fileUtil;
        this.roomService = roomService;
    }

    public Booking createBooking(String username, int roomId, LocalDate checkInDate, 
                               LocalDate checkOutDate, String specialRequests) {
        try {
            // Generate new booking ID
            String bookingId = generateNewBookingId();
            
            // Calculate total price
            double totalPrice = calculateTotalPrice(roomId, checkInDate, checkOutDate);
            
            // Create booking
            Booking booking = new Booking(bookingId, username, roomId, checkInDate, 
                                        checkOutDate, totalPrice, "PENDING", specialRequests);
            
            // Save to file
            String bookingStr = bookingToString(booking);
            fileUtil.appendLine(bookingsFilePath, bookingStr);
            
            return booking;
        } catch (Exception e) {
            throw new RuntimeException("Error creating booking: " + e.getMessage());
        }
    }

    public List<Booking> getAllBookings() {
        try {
            List<String> lines = fileUtil.readLines(bookingsFilePath);
            return lines.stream()
                    .map(this::parseBookingFromString)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving bookings: " + e.getMessage());
        }
    }

    public List<Booking> getBookingsByUsername(String username) {
        return getAllBookings().stream()
                .filter(b -> b.getUsername().equals(username))
                .collect(Collectors.toList());
    }

    public Booking getBookingById(String bookingId) {
        try {
            List<Booking> bookings = getAllBookings();
            return bookings.stream()
                    .filter(b -> b.getBookingId().equals(bookingId))
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving booking: " + e.getMessage());
        }
    }
    //Update booking
    public boolean updateBooking(Booking booking) {
        try {
            List<Booking> bookings = getAllBookings();
            boolean found = false;
            
            for (int i = 0; i < bookings.size(); i++) {
                if (bookings.get(i).getBookingId().equals(booking.getBookingId())) {
                    bookings.set(i, booking);
                    found = true;
                    break;
                }
            }
            
            if (found) {
                List<String> lines = bookings.stream()
                        .map(this::bookingToString)
                        .collect(Collectors.toList());
                fileUtil.writeLines(bookingsFilePath, lines);
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new RuntimeException("Error updating booking: " + e.getMessage());
        }
    }

    public boolean updateBookingStatus(String bookingId, String newStatus) {
        Booking booking = getBookingById(bookingId);
        if (booking != null) {
            booking.setStatus(newStatus);
            return updateBooking(booking);
        }
        return false;
    }

    private String generateNewBookingId() {
        List<Booking> bookings = getAllBookings();
        if (bookings.isEmpty()) {
            return "B001";
        }
        
        return "B" + String.format("%03d", bookings.size() + 1);
    }

    private double calculateTotalPrice(int roomId, LocalDate checkIn, LocalDate checkOut) {
        Room room = roomService.getRoomById(roomId);
        if (room == null) {
            throw new RuntimeException("Room not found");
        }
        
        long days = ChronoUnit.DAYS.between(checkIn, checkOut);
        return room.getPrice() * days;
    }

    private String bookingToString(Booking booking) {
        return String.format("%s|%s|%d|%s|%s|%.2f|%s|%s",
                booking.getBookingId(),
                booking.getUsername(),
                booking.getRoomId(),
                booking.getCheckInDate(),
                booking.getCheckOutDate(),
                booking.getTotalPrice(),
                booking.getStatus(),
                booking.getSpecialRequests());
    }

    private Booking parseBookingFromString(String line) {
        try {
            String[] parts = line.split("\\|");
            if (parts.length < 7) {
                return null;
            }
            
            return new Booking(
                parts[0], // bookingId
                parts[1], // username
                Integer.parseInt(parts[2]), // roomId
                LocalDate.parse(parts[3]), // checkInDate
                LocalDate.parse(parts[4]), // checkOutDate
                Double.parseDouble(parts[5]), // totalPrice
                parts[6], // status
                parts.length > 7 ? parts[7] : "" // specialRequests
            );
        } catch (Exception e) {
            return null;
        }
    }

    // Get upcoming bookings (sorted by date)
    public List<Booking> getUpcomingBookings() {
        List<Booking> bookings = getAllBookings().stream()
                .filter(b -> b.getCheckInDate().isAfter(LocalDate.now().minusDays(1)))
                .collect(Collectors.toList());
        quickSort.sortByDate(bookings);
        return bookings;
    }

    public boolean deleteBooking(String bookingId) {
        try {
            List<Booking> bookings = getAllBookings();
            boolean removed = bookings.removeIf(b -> b.getBookingId().equals(bookingId));
            if (removed) {
                List<String> lines = bookings.stream()
                        .map(this::bookingToString)
                        .collect(Collectors.toList());
                fileUtil.writeLines(bookingsFilePath, lines);
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new RuntimeException("Error deleting booking: " + e.getMessage());
        }
    }
}