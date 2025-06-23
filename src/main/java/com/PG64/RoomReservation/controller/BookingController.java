package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.Booking;
import com.PG64.RoomReservation.model.User;
import com.PG64.RoomReservation.service.BookingService;
import com.PG64.RoomReservation.service.RoomService;
import com.PG64.RoomReservation.service.UserService;
import com.PG64.RoomReservation.util.QuickSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/booking")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private UserService userService;

    @Autowired
    private QuickSort quickSort;

    // Handle direct booking from room catalog
    @GetMapping("/create/{roomId}")
    public String initiateBooking(@PathVariable int roomId, Model model) {
        model.addAttribute("booking", new Booking());
        model.addAttribute("preselectedRoomId", roomId);
        model.addAttribute("rooms", roomService.getAllRooms());
        return "booking/book";
    }

    // Show booking form
    @GetMapping("/book")
    public String showBookingForm(
            @RequestParam(required = false) Integer roomId,
            Model model) {

        model.addAttribute("booking", new Booking());
        model.addAttribute("rooms", roomService.getAvailableRooms());

        if (roomId != null) {
            model.addAttribute("preselectedRoomId", roomId);
        }

        return "booking/book";
    }

    // Process new booking
    @PostMapping("/create")
    public String createBooking(
            @RequestParam int roomId,
            @RequestParam LocalDate checkInDate,
            @RequestParam LocalDate checkOutDate,
            @RequestParam(required = false) String specialRequests,
            Model model,
            HttpSession session) {

        try {
            // Get current user from session
            User currentUser = userService.getCurrentUser(session);

            // Create booking (ID is generated in service)
            bookingService.createBooking(
                currentUser.getUsername(),
                roomId,
                checkInDate,
                checkOutDate,
                specialRequests
            );
            return "redirect:/booking/list";

        } catch (Exception e) {
            model.addAttribute("error", "Booking failed: " + e.getMessage());
            model.addAttribute("rooms", roomService.getAvailableRooms());
            return "booking/book";
        }
    }

    // List user's bookings
    @GetMapping("/list")
    public String listBookings(Model model) {
        // Get current user (in a real app, get from session)
        User currentUser = userService.getCurrentUser();

        List<Booking> bookings = bookingService.getBookingsByUsername(currentUser.getUsername());

        // Sort bookings by check-in date using QuickSort
        quickSort.sortByDate(bookings);

        model.addAttribute("bookings", bookings);
        return "booking/list";
    }

    // Admin: List all bookings
    @GetMapping("/manage")
    public String manageBookings(Model model) {
        List<Booking> allBookings = bookingService.getAllBookings();
        quickSort.sortByDate(allBookings);
        model.addAttribute("bookings", allBookings);
        return "booking/manage";
    }

    // Cancel booking
    @PostMapping("/cancel/{bookingId}")
    public String cancelBooking(@PathVariable String bookingId) {
        bookingService.deleteBooking(bookingId);
        return "redirect:/booking/manage";
    }

    // Admin & user: Edit booking
    @GetMapping("/edit/{bookingId}")
    public String showEditForm(@PathVariable String bookingId, Model model) {
        try {
            Booking booking = bookingService.getBookingById(bookingId);
            if (booking == null) {
                return "redirect:/booking/manage?error=Booking not found";
            }
            model.addAttribute("booking", booking);
            model.addAttribute("rooms", roomService.getAllRooms());
            return "booking/edit";
        } catch (Exception e) {
            return "redirect:/booking/manage?error=" + e.getMessage();
        }
    }

    // Process booking update
    @PostMapping("/update")
    public String updateBooking(@ModelAttribute Booking booking, Model model) {
        try {
            double totalPrice = roomService.calculatePrice(booking.getRoomId(), booking.getCheckInDate(), booking.getCheckOutDate());
            booking.setTotalPrice(totalPrice);
            bookingService.updateBooking(booking);
            User currentUser = userService.getCurrentUser();
            if (currentUser instanceof com.PG64.RoomReservation.model.AdminUser) {
                return "redirect:/booking/manage?success=Booking updated successfully";
            } else {
                return "redirect:/booking/list?success=Booking updated successfully";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("booking", booking);
            model.addAttribute("rooms", roomService.getAllRooms());
            return "booking/edit";
        }
    }
}