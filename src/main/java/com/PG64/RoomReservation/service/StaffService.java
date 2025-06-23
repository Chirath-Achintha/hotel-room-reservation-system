package com.PG64.RoomReservation.service;

import com.PG64.RoomReservation.model.Staff;
import com.PG64.RoomReservation.model.Manager;
import com.PG64.RoomReservation.model.Receptionist;
import com.PG64.RoomReservation.model.Housekeeping;
import com.PG64.RoomReservation.model.Maintenance;
import com.PG64.RoomReservation.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import jakarta.annotation.PostConstruct;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class StaffService {

    @Autowired
    private FileUtil fileUtil;

    @Value("${staff.file.path}")
    private String staffFilePath;

    @Value("${app.storage.data-dir}")
    private String dataDir;

    private List<Staff> staffList;

    // Initialize storage on startup
    @PostConstruct
    public void init() {
        try {
            // Create data directory if it doesn't exist
            fileUtil.createDirectoryIfNotExists(dataDir);
            
            // Create staff file if it doesn't exist
            if (!fileUtil.fileExists(staffFilePath)) {
                fileUtil.writeLines(staffFilePath, new ArrayList<>());
            }
            
            // Initialize staff list
            staffList = new ArrayList<>();
            loadStaff();
        } catch (IOException e) {
            e.printStackTrace();
            staffList = new ArrayList<>();
        }
    }

    // Load staff from file
    private void loadStaff() {
        try {
            List<String> lines = fileUtil.readLines(staffFilePath);
            for (String line : lines) {
                if (!line.trim().isEmpty()) {
                    Staff staff = parseStaffFromString(line);
                    if (staff != null) {
                        staffList.add(staff);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Save staff to file
    private void saveStaff() {
        try {
            List<String> lines = staffList.stream()
                    .map(this::convertStaffToFileString)
                    .collect(Collectors.toList());
            fileUtil.writeLines(staffFilePath, lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Add new staff member
    public boolean addStaff(Staff staff) {
        try {
            staff.setStaffId(generateStaffId());
            staffList.add(staff);
            saveStaff();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all staff members
    public List<Staff> getAllStaff() {
        return new ArrayList<>(staffList);
    }

    // Get active staff members
    public List<Staff> getActiveStaff() {
        return staffList.stream()
                .filter(Staff::isActive)
                .collect(Collectors.toList());
    }

    // Get staff by ID
    public Staff getStaffById(int staffId) {
        return staffList.stream()
                .filter(s -> s.getStaffId() == staffId)
                .findFirst()
                .orElse(null);
    }

    // Update staff information
    public boolean updateStaff(Staff updatedStaff) {
        for (int i = 0; i < staffList.size(); i++) {
            if (staffList.get(i).getStaffId() == updatedStaff.getStaffId()) {
                staffList.set(i, updatedStaff);
                saveStaff();
                return true;
            }
        }
        return false;
    }

    // Deactivate staff (soft delete)
    public boolean deactivateStaff(int staffId) {
        Staff staff = getStaffById(staffId);
        if (staff != null) {
            staff.setActive(false);
            return updateStaff(staff);
        }
        return false;
    }

    // Delete staff member
    public boolean deleteStaff(int staffId) {
        try {
            // Remove from staffList
            staffList.removeIf(staff -> staff.getStaffId() == staffId);
            // Save changes to file
            saveStaff();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Generate new staff ID
    public int generateStaffId() {
        return staffList.stream()
                .mapToInt(Staff::getStaffId)
                .max()
                .orElse(0) + 1;
    }

    // Helper methods
    private String convertStaffToFileString(Staff staff) {
        String position;
        if (staff instanceof Manager) {
            position = "MANAGER";
        } else if (staff instanceof Receptionist) {
            position = "RECEPTIONIST";
        } else if (staff instanceof Housekeeping) {
            position = "HOUSEKEEPING";
        } else if (staff instanceof Maintenance) {
            position = "MAINTENANCE";
        } else {
            position = "UNKNOWN";
        }
        return String.format("%d,%s,%s,%s,%s,%s,%b",
                staff.getStaffId(),
                staff.getName(),
                staff.getEmail(),
                position,
                staff.getDepartment(),
                staff.getContactNumber(),
                staff.isActive());
    }

    private Staff parseStaffFromString(String staffStr) {
        try {
            String[] parts = staffStr.split(",");
            String position = parts[3];
            int staffId = Integer.parseInt(parts[0]);
            String name = parts[1];
            String email = parts[2];
            String department = parts[4];
            String contactNumber = parts[5];
            boolean isActive = Boolean.parseBoolean(parts[6]);
            switch (position) {
                case "MANAGER":
                    return new Manager(staffId, name, email, department, contactNumber, isActive);
                case "RECEPTIONIST":
                    return new Receptionist(staffId, name, email, department, contactNumber, isActive);
                case "HOUSEKEEPING":
                    return new Housekeeping(staffId, name, email, department, contactNumber, isActive);
                case "MAINTENANCE":
                    return new Maintenance(staffId, name, email, department, contactNumber, isActive);
                default:
                    return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}