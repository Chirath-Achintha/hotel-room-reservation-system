package com.PG64.RoomReservation.service;

import com.PG64.RoomReservation.model.Review;
import com.PG64.RoomReservation.model.RoomReview;
import com.PG64.RoomReservation.model.ServiceReview;
import com.PG64.RoomReservation.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import jakarta.annotation.PostConstruct;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReviewService {

    @Autowired
    private FileUtil fileUtil;

    @Value("${reviews.file.path}")
    private String reviewsFilePath;

    @Value("${app.storage.data-dir}")
    private String dataDir;

    private List<Review> reviews;

    private static final String ROOM_REVIEWS_FILE = "data/room-reviews.txt";

    @PostConstruct
    public void init() {
        try {
            // Create data directory if it doesn't exist
            fileUtil.createDirectoryIfNotExists(dataDir);
            
            // Create reviews file if it doesn't exist
            if (!fileUtil.fileExists(reviewsFilePath)) {
                fileUtil.writeLines(reviewsFilePath, new ArrayList<>());
            }
            
            reviews = new ArrayList<>();
            loadReviews();
        } catch (IOException e) {
            e.printStackTrace();
            reviews = new ArrayList<>();
        }
    }

    private void loadReviews() {
        try {
            List<String> lines = fileUtil.readLines(reviewsFilePath);
            for (String line : lines) {
                if (!line.trim().isEmpty()) {
                    Review review = parseReviewFromString(line);
                    if (review != null) {
                        reviews.add(review);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void saveReviews() {
        try {
            List<String> lines = reviews.stream()
                    .map(this::convertReviewToFileString)
                    .collect(Collectors.toList());
            fileUtil.writeLines(reviewsFilePath, lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Create new review
    public boolean createReview(Review review) {
        review.setReviewId(generateReviewId());
        reviews.add(review);
        saveReviews();
        return true;
    }

    // Get review by ID
    public Review getReviewById(int reviewId) {
        return reviews.stream()
                .filter(r -> r.getReviewId() == reviewId)
                .findFirst()
                .orElse(null);
    }

    // Get reviews by room
    public List<Review> getReviewsByRoom(int roomId) {
        return reviews.stream()
                .filter(r -> r instanceof RoomReview && ((RoomReview) r).getRoomId() == roomId)
                .collect(Collectors.toList());
    }

    // Get reviews by service
    public List<Review> getReviewsByService(int serviceId) {
        return reviews.stream()
                .filter(r -> r instanceof ServiceReview && ((ServiceReview) r).getServiceId() == serviceId)
                .collect(Collectors.toList());
    }

    // Get reviews by user
    public List<Review> getReviewsByUser(int userId) {
        return reviews.stream()
                .filter(r -> r.getUserId() == userId)
                .collect(Collectors.toList());
    }

    // Get all reviews
    public List<Review> getAllReviews() {
        return new ArrayList<>(reviews);
    }

    // Update review
    public boolean updateReview(Review updatedReview) {
        for (int i = 0; i < reviews.size(); i++) {
            if (reviews.get(i).getReviewId() == updatedReview.getReviewId()) {
                reviews.set(i, updatedReview);
                saveReviews();
                return true;
            }
        }
        return false;
    }

    // Delete review
    public boolean deleteReview(int reviewId) {
        boolean removed = reviews.removeIf(r -> r.getReviewId() == reviewId);
        if (removed) {
            saveReviews();
        }
        return removed;
    }

    // Update review status
    public boolean updateReviewStatus(int reviewId, String newStatus) {
        Review review = getReviewById(reviewId);
        if (review != null) {
            review.setStatus(newStatus);
            saveReviews();
            return true;
        }
        return false;
    }

    // Generate new review ID
    public int generateReviewId() {
        return reviews.stream()
                .mapToInt(Review::getReviewId)
                .max()
                .orElse(0) + 1;
    }

    // Helper methods for file operations
    private String convertReviewToFileString(Review review) {
        String baseInfo = String.format("%d,%d,%d,%s,%s,%s,%s",
                review.getReviewId(),
                review.getUserId(),
                review.getRating(),
                review.getComment(),
                review.getReviewDate(),
                review.getStatus(),
                review.getType());

        if (review instanceof RoomReview) {
            RoomReview roomReview = (RoomReview) review;
            return String.format("%s,ROOM,%d,%s,%s,%s",
                    baseInfo,
                    roomReview.getRoomId(),
                    roomReview.getCleanliness(),
                    roomReview.getComfort(),
                    roomReview.getLocation());
        } else {
            ServiceReview serviceReview = (ServiceReview) review;
            return String.format("%s,SERVICE,%d,%s,%s,%s",
                    baseInfo,
                    serviceReview.getServiceId(),
                    serviceReview.getStaffBehavior(),
                    serviceReview.getServiceQuality(),
                    serviceReview.getValueForMoney());
        }
    }

    private Review parseReviewFromString(String str) {
        // Handle both comma and pipe delimiters
        String[] parts = str.contains(",") ? str.split(",") : str.split("\\|");
        
        try {
            // For legacy format with just basic fields
            if (parts.length <= 3) {
                int reviewId = generateReviewId();
                String userId = parts[0];
                int rating = Integer.parseInt(parts[1]);
                String comment = parts[2];
                
                // Create a basic room review
                return new RoomReview(
                    reviewId,
                    1, // default user ID
                    1, // default room ID
                    rating,
                    comment,
                    LocalDate.now(),
                    "PENDING",
                    "Good", // default cleanliness
                    "Good", // default comfort
                    "Good"  // default location
                );
            }
            
            // For full format
            int reviewId = Integer.parseInt(parts[0]);
            int userId = Integer.parseInt(parts[1]);
            int rating = Integer.parseInt(parts[2]);
            String comment = parts[3];
            LocalDate reviewDate = LocalDate.parse(parts[4]);
            String status = parts[5];
            String type = parts[6];

            if ("ROOM".equals(type)) {
                return new RoomReview(
                        reviewId,
                        userId,
                        Integer.parseInt(parts[8]), // roomId
                        rating,
                        comment,
                        reviewDate,
                        status,
                        parts[9],  // cleanliness
                        parts[10], // comfort
                        parts[11]  // location
                );
            } else {
                return new ServiceReview(
                        reviewId,
                        userId,
                        Integer.parseInt(parts[8]), // serviceId
                        rating,
                        comment,
                        reviewDate,
                        status,
                        parts[9],  // staffBehavior
                        parts[10], // serviceQuality
                        parts[11]  // valueForMoney
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Save a room review to the dedicated file
    public void saveRoomReview(RoomReview review) {
        try (java.io.FileWriter fw = new java.io.FileWriter(ROOM_REVIEWS_FILE, true)) {
            String line = String.format("%d,%d,%d,%s,%s,%s,%s,%d,%s,%s,%s\n",
                review.getReviewId(),
                review.getUserId(),
                review.getRating(),
                review.getComment(),
                review.getReviewDate(),
                review.getStatus(),
                review.getType(),
                review.getRoomId(),
                review.getCleanliness(),
                review.getComfort(),
                review.getLocation()
            );
            fw.write(line);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get all reviews for a room from the dedicated file
    public List<RoomReview> getRoomReviews(int roomId) {
        List<RoomReview> result = new ArrayList<>();
        try {
            java.nio.file.Path path = java.nio.file.Paths.get(ROOM_REVIEWS_FILE);
            if (!java.nio.file.Files.exists(path)) return result;
            List<String> lines = java.nio.file.Files.readAllLines(path);
            for (String line : lines) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length < 11) continue;
                int parsedRoomId = Integer.parseInt(parts[7]);
                if (parsedRoomId == roomId) {
                    RoomReview review = new RoomReview(
                        Integer.parseInt(parts[0]),
                        Integer.parseInt(parts[1]),
                        parsedRoomId,
                        Integer.parseInt(parts[2]),
                        parts[3],
                        java.time.LocalDate.parse(parts[4]),
                        parts[5],
                        parts[8],
                        parts[9],
                        parts[10]
                    );
                    result.add(review);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Update a room review in room-reviews.txt
    public boolean updateRoomReview(RoomReview updatedReview) {
        List<RoomReview> allReviews = new ArrayList<>();
        boolean updated = false;
        try {
            java.nio.file.Path path = java.nio.file.Paths.get(ROOM_REVIEWS_FILE);
            if (!java.nio.file.Files.exists(path)) return false;
            List<String> lines = java.nio.file.Files.readAllLines(path);
            for (String line : lines) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length < 11) continue;
                int reviewId = Integer.parseInt(parts[0]);
                int roomId = Integer.parseInt(parts[7]);
                if (reviewId == updatedReview.getReviewId() && roomId == updatedReview.getRoomId()) {
                    allReviews.add(updatedReview);
                    updated = true;
                } else {
                    RoomReview review = new RoomReview(
                        Integer.parseInt(parts[0]),
                        Integer.parseInt(parts[1]),
                        roomId,
                        Integer.parseInt(parts[2]),
                        parts[3],
                        java.time.LocalDate.parse(parts[4]),
                        parts[5],
                        parts[8],
                        parts[9],
                        parts[10]
                    );
                    allReviews.add(review);
                }
            }
            // Write all reviews back
            try (java.io.FileWriter fw = new java.io.FileWriter(ROOM_REVIEWS_FILE, false)) {
                for (RoomReview r : allReviews) {
                    String line = String.format("%d,%d,%d,%s,%s,%s,%s,%d,%s,%s,%s\n",
                        r.getReviewId(), r.getUserId(), r.getRating(), r.getComment(), r.getReviewDate(), r.getStatus(), r.getType(), r.getRoomId(), r.getCleanliness(), r.getComfort(), r.getLocation());
                    fw.write(line);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return updated;
    }

    // Delete a room review in room-reviews.txt
    public boolean deleteRoomReview(int reviewId, int roomId) {
        List<RoomReview> allReviews = new ArrayList<>();
        boolean deleted = false;
        try {
            java.nio.file.Path path = java.nio.file.Paths.get(ROOM_REVIEWS_FILE);
            if (!java.nio.file.Files.exists(path)) return false;
            List<String> lines = java.nio.file.Files.readAllLines(path);
            for (String line : lines) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length < 11) continue;
                int rid = Integer.parseInt(parts[0]);
                int rmid = Integer.parseInt(parts[7]);
                if (rid == reviewId && rmid == roomId) {
                    deleted = true;
                    continue;
                }
                RoomReview review = new RoomReview(
                    Integer.parseInt(parts[0]),
                    Integer.parseInt(parts[1]),
                    rmid,
                    Integer.parseInt(parts[2]),
                    parts[3],
                    java.time.LocalDate.parse(parts[4]),
                    parts[5],
                    parts[8],
                    parts[9],
                    parts[10]
                );
                allReviews.add(review);
            }
            // Write all reviews back
            try (java.io.FileWriter fw = new java.io.FileWriter(ROOM_REVIEWS_FILE, false)) {
                for (RoomReview r : allReviews) {
                    String line = String.format("%d,%d,%d,%s,%s,%s,%s,%d,%s,%s,%s\n",
                        r.getReviewId(), r.getUserId(), r.getRating(), r.getComment(), r.getReviewDate(), r.getStatus(), r.getType(), r.getRoomId(), r.getCleanliness(), r.getComfort(), r.getLocation());
                    fw.write(line);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return deleted;
    }
}