package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.AdminUser;
import com.PG64.RoomReservation.model.Staff;
import com.PG64.RoomReservation.model.User;
import com.PG64.RoomReservation.model.Manager;
import com.PG64.RoomReservation.model.Receptionist;
import com.PG64.RoomReservation.model.Housekeeping;
import com.PG64.RoomReservation.model.Maintenance;
import com.PG64.RoomReservation.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/staff")
public class StaffController {

    @Autowired
    private StaffService staffService;

    // View all staff members (admin only)
    @GetMapping("/list")
    public String listStaff(Model model, HttpSession session) {
        // Check if user is admin
        User user = (User) session.getAttribute("user");
        if (!(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        model.addAttribute("staffMembers", staffService.getActiveStaff());
        return "staff/list";
    }

    // Show add staff form (admin only)
    @GetMapping("/register")
    public String showAddForm(Model model, HttpSession session) {
        // Check if user is admin
        User user = (User) session.getAttribute("user");
        if (!(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        model.addAttribute("staff", new Manager(0, "", "", "", "", true));
        return "staff/register";
    }

    // Process new staff member (admin only)
    @PostMapping("/register")
    public String registerStaff(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String position,
            @RequestParam String department,
            @RequestParam String contactNumber,
            Model model,
            HttpSession session) {

        // Check if user is admin
        User user = (User) session.getAttribute("user");
        if (!(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        Staff newStaff;
        int staffId = staffService.generateStaffId();
        switch (position) {
            case "MANAGER":
                newStaff = new Manager(staffId, name, email, department, contactNumber, true);
                break;
            case "RECEPTIONIST":
                newStaff = new Receptionist(staffId, name, email, department, contactNumber, true);
                break;
            case "HOUSEKEEPING":
                newStaff = new Housekeeping(staffId, name, email, department, contactNumber, true);
                break;
            case "MAINTENANCE":
                newStaff = new Maintenance(staffId, name, email, department, contactNumber, true);
                break;
            default:
                newStaff = new Manager(staffId, name, email, department, contactNumber, true);
        }

        if (staffService.addStaff(newStaff)) {
            return "redirect:/staff/list";
        } else {
            model.addAttribute("error", "Failed to register staff member");
            return "staff/register";
        }
    }

    // Show edit form (admin only)
    @GetMapping("/edit/{staffId}")
    public String showEditForm(@PathVariable int staffId, Model model, HttpSession session) {
        // Check if user is admin
        User user = (User) session.getAttribute("user");
        if (!(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        Staff staff = staffService.getStaffById(staffId);
        if (staff != null) {
            model.addAttribute("staff", staff);
            return "staff/edit";
        }
        return "redirect:/staff/list";
    }

    // Update staff information (admin only)
    @PostMapping("/update")
    public String updateStaff(
            @RequestParam int staffId,
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String position,
            @RequestParam String department,
            @RequestParam String contactNumber,
            Model model,
            HttpSession session) {

        // Check if user is admin
        User user = (User) session.getAttribute("user");
        if (!(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        Staff updatedStaff;
        switch (position) {
            case "MANAGER":
                updatedStaff = new Manager(staffId, name, email, department, contactNumber, true);
                break;
            case "RECEPTIONIST":
                updatedStaff = new Receptionist(staffId, name, email, department, contactNumber, true);
                break;
            case "HOUSEKEEPING":
                updatedStaff = new Housekeeping(staffId, name, email, department, contactNumber, true);
                break;
            case "MAINTENANCE":
                updatedStaff = new Maintenance(staffId, name, email, department, contactNumber, true);
                break;
            default:
                updatedStaff = new Manager(staffId, name, email, department, contactNumber, true);
        }

        if (staffService.updateStaff(updatedStaff)) {
            return "redirect:/staff/list";
        } else {
            model.addAttribute("error", "Failed to update staff information");
            return "staff/edit";
        }
    }

    // Delete staff (admin only)
    @PostMapping("/deactivate/{staffId}")
    public String deactivateStaff(@PathVariable int staffId, HttpSession session) {
        // Check if user is admin
        User user = (User) session.getAttribute("user");
        if (!(user instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        staffService.deleteStaff(staffId);
        return "redirect:/staff/list";
    }
}