package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.User;
import com.PG64.RoomReservation.model.AdminUser;
import com.PG64.RoomReservation.model.RegularUser;
import com.PG64.RoomReservation.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // Login Page
    @GetMapping("/auth/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/user/profile";
        }
        return "auth/login";
    }

    // Login Processing
    @PostMapping("/auth/login")
    public String processLogin(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        // Hardcoded admin login
        if ("admin".equals(username) && "admin123".equals(password)) {
            AdminUser admin = new AdminUser(0, "admin", "admin123", "admin@hotel.com", "MANAGER");
            session.setAttribute("user", admin);
            return "redirect:/admin/dashboard";
        }

        User user = userService.authenticate(username, password);
        if (user != null) {
            session.setAttribute("user", user);
            if (user instanceof AdminUser) {
                return "redirect:/admin/dashboard";
            }
            return "redirect:/user/profile";
        }

        model.addAttribute("error", "Invalid username or password");
        return "auth/login";
    }

    // Registration Page
    @GetMapping("/auth/register")
    public String showRegisterPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/user/profile";
        }
        return "auth/register";
    }

    // Registration Processing
    @PostMapping("/auth/register")
    public String processRegister(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String email,
            @RequestParam(defaultValue = "REGULAR") String role,
            Model model) {

        // Check if username already exists
        if (userService.getUserByUsername(username) != null) {
            model.addAttribute("error", "Username already exists");
            return "auth/register";
        }

        User newUser;
        if ("ADMIN".equals(role)) {
            newUser = new AdminUser(
                    userService.generateId(),
                    username,
                    password,
                    email,
                    "MANAGER" // Default admin level
            );
        } else if ("PREMIUM".equals(role)) {
            newUser = new com.PG64.RoomReservation.model.PremiumUser(
                    userService.generateId(),
                    username,
                    password,
                    email
            );
        } else {
            newUser = new RegularUser(
                    userService.generateId(),
                    username,
                    password,
                    email,
                    false // isPremium = false
            );
        }

        if (userService.registerUser(newUser)) {
            return "redirect:/auth/login";
        } else {
            model.addAttribute("error", "Registration failed");
            return "auth/register";
        }
    }

    // Logout
    @GetMapping("/auth/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }
}