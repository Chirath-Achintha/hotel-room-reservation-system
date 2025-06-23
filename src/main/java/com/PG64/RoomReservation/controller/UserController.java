package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.*;
import com.PG64.RoomReservation.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;


    @GetMapping("/list")
    public String listUsers(Model model, HttpSession session) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "user/list";
    }


    @GetMapping("/profile")
    public String viewProfile(Model model, HttpSession session, @RequestParam(required = false) Integer userId) {
        User user;
        if (userId != null) {

            User currentUser = (User) session.getAttribute("user");
            if (!(currentUser instanceof AdminUser)) {
                return "redirect:/auth/login";
            }
            user = userService.getUserById(userId);
        } else {

            user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/auth/login";
            }
        }

        model.addAttribute("user", user);
        return "user/profile";
    }


    @GetMapping("/edit/{userId}")
    public String showEditForm(@PathVariable int userId, Model model, HttpSession session) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }


        if (currentUser.getId() != userId && !(currentUser instanceof AdminUser)) {
            return "redirect:/user/profile";
        }

        User userToEdit = userService.getUserById(userId);
        if (userToEdit == null) {
            return "redirect:/user/list";
        }

        model.addAttribute("user", userToEdit);
        return "user/edit";
    }


    @PostMapping("/update")
    public String updateProfile(
            @RequestParam int id,
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam(required = false) String newPassword,
            @RequestParam(required = false) String adminLevel,
            @RequestParam(required = false, defaultValue = "false") boolean premium,
            HttpSession session,
            Model model) {

        // Check if user is logged in
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }


        if (currentUser.getId() != id && !(currentUser instanceof AdminUser)) {
            return "redirect:/user/profile";
        }

        User userToUpdate = userService.getUserById(id);
        if (userToUpdate == null) {
            model.addAttribute("error", "User not found");
            return "user/edit";
        }


        userToUpdate.setUsername(username);
        userToUpdate.setEmail(email);
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            userToUpdate.setPassword(newPassword);
        }

        // Update type-specific fields
        if (userToUpdate instanceof AdminUser && adminLevel != null) {
            ((AdminUser) userToUpdate).setAdminLevel(adminLevel);
        } else if (userToUpdate instanceof RegularUser) {
            ((RegularUser) userToUpdate).setPremium(premium);
        }

        if (userService.updateUser(userToUpdate)) {
            // Update session if the user is updating their own profile
            if (currentUser.getId() == id) {
                session.setAttribute("user", userToUpdate);
            }
            return "redirect:/user/profile" + (currentUser.getId() != id ? "?userId=" + id : "");
        } else {
            model.addAttribute("error", "Failed to update profile");
            model.addAttribute("user", userToUpdate);
            return "user/edit";
        }
    }

    // Delete user (admin only)
    @PostMapping("/delete/{userId}")
    public String deleteUser(@PathVariable int userId, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        // Allow self-deletion or admin deletion
        if (currentUser == null) {
            return "redirect:/auth/login";
        }
        boolean isSelf = currentUser.getId() == userId;
        boolean isAdmin = currentUser instanceof AdminUser;
        if (!isSelf && !isAdmin) {
            return "redirect:/user/profile";
        }
        userService.deleteUser(userId);
        if (isSelf) {
            session.invalidate();
            return "redirect:/auth/login";
        } else {
            return "redirect:/user/list";
        }
    }

    // Upgrade to premium (admin only or self)
    @PostMapping("/upgrade/{userId}")
    public String upgradeToPremium(@PathVariable int userId, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        // Only allow users to upgrade themselves unless they're an admin
        if (currentUser.getId() != userId && !(currentUser instanceof AdminUser)) {
            return "redirect:/user/profile";
        }

        userService.upgradeToPremium(userId);
        return "redirect:/user/list";
    }

    // Edit admin user form (admin only)
    @GetMapping("/edit/admin/{userId}")
    public String showEditAdminForm(@PathVariable int userId, Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }
        User userToEdit = userService.getUserById(userId);
        if (userToEdit == null) {
            return "redirect:/user/list";
        }
        model.addAttribute("user", userToEdit);
        return "user/edit";
    }
}