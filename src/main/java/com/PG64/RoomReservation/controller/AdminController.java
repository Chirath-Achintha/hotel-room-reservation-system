package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.AdminUser;
import com.PG64.RoomReservation.model.User;
import com.PG64.RoomReservation.service.BookingService;
import com.PG64.RoomReservation.service.StaffService;
import com.PG64.RoomReservation.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;
import com.PG64.RoomReservation.service.ReservationService;
import com.PG64.RoomReservation.model.Reservation;
import java.util.List;
import com.PG64.RoomReservation.util.QuickSort;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private StaffService staffService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private QuickSort quickSort;

    // Admin dashboard
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        // Check if user is logged in and is admin
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        // Add counts for dashboard
        model.addAttribute("userCount", userService.getAllUsers().size());
        model.addAttribute("staffCount", staffService.getActiveStaff().size());
        model.addAttribute("bookingCount", bookingService.getAllBookings().stream()
                .filter(booking -> "PENDING".equals(booking.getStatus()) || "CONFIRMED".equals(booking.getStatus()))
                .count());
        model.addAttribute("user", user);

        return "admin/dashboard";
    }

    // Admin: View all bookings sorted by check-in date
    @GetMapping("/reservations")
    public String viewReservations(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }
        List<com.PG64.RoomReservation.model.Booking> bookings = bookingService.getAllBookings();
        quickSort.sortByDate(bookings); // Ensure sorted by check-in date
        model.addAttribute("bookings", bookings);
        return "admin/reservations";
    }
} 