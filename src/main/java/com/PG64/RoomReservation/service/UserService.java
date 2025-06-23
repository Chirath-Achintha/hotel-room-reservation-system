package com.PG64.RoomReservation.service;

import com.PG64.RoomReservation.model.*;
import com.PG64.RoomReservation.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import jakarta.servlet.http.HttpSession;

@Service
public class UserService {

    @Autowired
    private FileUtil fileUtil;

    @Value("${users.file.path}")
    private String usersFilePath;

    @Value("${app.storage.data-dir}")
    private String dataDir;

    // Initialize storage on startup
    @PostConstruct
    public void init() {
        try {

            fileUtil.createDirectoryIfNotExists(dataDir);
            

            if (!fileUtil.fileExists(usersFilePath)) {
                Files.createFile(Paths.get(usersFilePath));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    private User currentUser;

    public User getCurrentUser() {

        if (currentUser == null) {
            currentUser = new RegularUser(1, "defaultUser", "password", "user@example.com");
        }
        return currentUser;
    }

    public void setCurrentUser(User user) {
        this.currentUser = user;
    }

    public User getCurrentUser(HttpSession session) {
        return (User) session.getAttribute("user");
    }

    public User getUserByUsername(String username) {
        try {
            List<String> users = fileUtil.readLines(usersFilePath);
            Optional<User> user = users.stream()
                    .map(this::parseUserFromString)
                    .filter(u -> u.getUsername().equals(username))
                    .findFirst();
            return user.orElse(null);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Create a new user
    public boolean registerUser(User user) {
        try {
            // Ensure data directory exists
            fileUtil.createDirectoryIfNotExists(dataDir);
            
            // Read existing users or create empty list if file doesn't exist
            List<String> users = new ArrayList<>();
            if (fileUtil.fileExists(usersFilePath)) {
                users = fileUtil.readLines(usersFilePath);
            }
            
            // Add new user
            users.add(convertUserToFileString(user));
            
            // Write back to file
            return fileUtil.writeLines(usersFilePath, users);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }


    public User authenticate(String username, String password) {
        try {
            List<String> users = fileUtil.readLines(usersFilePath);
            for (String userStr : users) {
                User user = parseUserFromString(userStr);
                if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                    return user;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    public User getUserById(int userId) {
        try {
            List<String> users = fileUtil.readLines(usersFilePath);
            Optional<User> user = users.stream()
                    .map(this::parseUserFromString)
                    .filter(u -> u.getId() == userId)
                    .findFirst();
            return user.orElse(null);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }


    public boolean updateUser(User user) {
        try {
            List<String> users = fileUtil.readLines(usersFilePath);
            List<String> updatedUsers = new ArrayList<>();
            boolean found = false;

            for (String userStr : users) {
                User existingUser = parseUserFromString(userStr);
                if (existingUser.getId() == user.getId()) {
                    updatedUsers.add(convertUserToFileString(user));
                    found = true;
                } else {
                    updatedUsers.add(userStr);
                }
            }

            if (found) {
                return fileUtil.writeLines(usersFilePath, updatedUsers);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean deleteUser(int userId) {
        try {
            List<String> users = fileUtil.readLines(usersFilePath);
            List<String> updatedUsers = users.stream()
                    .filter(u -> parseUserFromString(u).getId() != userId)
                    .toList();

            if (updatedUsers.size() < users.size()) {
                return fileUtil.writeLines(usersFilePath, updatedUsers);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }


    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            List<String> userStrings = fileUtil.readLines(usersFilePath);
            for (String userStr : userStrings) {
                users.add(parseUserFromString(userStr));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public void upgradeToPremium(int userId) {
        User user = getUserById(userId);
        if (user instanceof RegularUser) {
            RegularUser regularUser = (RegularUser) user;
            // Convert RegularUser to PremiumUser
            PremiumUser premiumUser = new PremiumUser(
                regularUser.getId(),
                regularUser.getUsername(),
                regularUser.getPassword(),
                regularUser.getEmail()
            );
            updateUser(premiumUser);
        }
    }

    public void changeAdminLevel(int userId, String newLevel) {
        User user = getUserById(userId);
        if (user instanceof AdminUser) {
            AdminUser adminUser = (AdminUser) user;
            adminUser.setAdminLevel(newLevel);
            updateUser(adminUser);
        }
    }

    // Helper methods
    private String convertUserToFileString(User user) {
        String userType;
        String additionalInfo = "";
        if (user instanceof AdminUser) {
            userType = "ADMIN";
            additionalInfo = "," + ((AdminUser) user).getAdminLevel();
        } else if (user instanceof PremiumUser) {
            userType = "PREMIUM";
            PremiumUser pu = (PremiumUser) user;
            additionalInfo = String.format(",%d,%s,%s",
                pu.getLoyaltyPoints(),
                pu.getPremiumStartDate(),
                pu.getPremiumBenefits().replace(",", ";") // avoid comma issues
            );
        } else if (user instanceof RegularUser) {
            userType = "REGULAR";
            additionalInfo = "," + ((RegularUser) user).isPremium();
        } else {
            userType = "REGULAR";
            additionalInfo = ",false";
        }
        return String.format("%d,%s,%s,%s,%s%s",
                user.getId(),
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                userType,
                additionalInfo);
    }

    private User parseUserFromString(String userStr) {
        String[] parts = userStr.split(",");
        int id = Integer.parseInt(parts[0]);
        String username = parts[1];
        String password = parts[2];
        String email = parts[3];
        String type = parts[4];
        if ("ADMIN".equals(type)) {
            String adminLevel = parts[5];
            return new AdminUser(id, username, password, email, adminLevel);
        } else if ("PREMIUM".equals(type)) {
            int loyaltyPoints = parts.length > 5 ? Integer.parseInt(parts[5]) : 0;
            java.time.LocalDate premiumStartDate = parts.length > 6 ? java.time.LocalDate.parse(parts[6]) : java.time.LocalDate.now();
            String premiumBenefits = parts.length > 7 ? parts[7].replace(";", ",") : "Free late check-out, 10% discount, VIP support";
            return new PremiumUser(id, username, password, email, loyaltyPoints, premiumStartDate, premiumBenefits);
        } else {
            boolean isPremium = parts.length > 5 && Boolean.parseBoolean(parts[5]);
            return new RegularUser(id, username, password, email, isPremium);
        }
    }

    public int generateId() {
        List<User> users = getAllUsers();
        return users.stream().mapToInt(User::getId).max().orElse(0) + 1;
    }
}