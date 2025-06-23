package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.*;
import com.PG64.RoomReservation.service.ReviewService;
import com.PG64.RoomReservation.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;

@Controller
@RequestMapping("/review")
public class ReviewController {

    private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private UserService userService;

    // Get featured reviews for homepage
    @ModelAttribute("featuredReviews")
    public List<ReviewDTO> getFeaturedReviews() {
        return reviewService.getAllReviews().stream()
                .filter(r -> r.getStatus() != null && r.getStatus().equals("APPROVED"))
                .map(review -> {
                    User user = userService.getUserById(review.getUserId());
                    return new ReviewDTO(
                        review.getReviewId(),
                        user != null ? user.getUsername() : "Guest",
                        review.getRating(),
                        review.getComment(),
                        review.getReviewDate(),
                        review.getType()
                    );
                })
                .limit(5)
                .collect(Collectors.toList());
    }

    // Quick review submission from homepage
    @PostMapping("/quick-submit")
    public String quickSubmitReview(
            @RequestParam String type,
            @RequestParam int rating,
            @RequestParam String comment,
            @RequestParam(required = false) Integer roomId,
            @RequestParam(required = false) Integer serviceId,
            @RequestParam(required = false) String cleanliness,
            @RequestParam(required = false) String comfort,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String staffBehavior,
            @RequestParam(required = false) String serviceQuality,
            @RequestParam(required = false) String valueForMoney,
            HttpSession session,
            Model model) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        Review review;
        if ("ROOM".equals(type)) {
            // Use default room ID 1 if not provided
            int actualRoomId = (roomId != null) ? roomId : 1;
            review = new RoomReview(
                0,
                currentUser.getId(),
                actualRoomId,
                rating,
                comment,
                LocalDate.now(),
                "PENDING",
                cleanliness != null ? cleanliness : "Good",
                comfort != null ? comfort : "Good",
                location != null ? location : "Good"
            );
        } else if ("SERVICE".equals(type)) {
            // Use default service ID 1 if not provided
            int actualServiceId = (serviceId != null) ? serviceId : 1;
            review = new ServiceReview(
                0,
                currentUser.getId(),
                actualServiceId,
                rating,
                comment,
                LocalDate.now(),
                "PENDING",
                staffBehavior != null ? staffBehavior : "Good",
                serviceQuality != null ? serviceQuality : "Good",
                valueForMoney != null ? valueForMoney : "Good"
            );
        } else {
            model.addAttribute("error", "Invalid review type");
            return "redirect:/";
        }

        if (reviewService.createReview(review)) {
            // Write to reviews.txt as well
            try (java.io.FileWriter fw = new java.io.FileWriter("data/reviews.txt", true)) {
                fw.write(comment + System.lineSeparator());
            } catch (java.io.IOException e) {
                // Optionally log error
            }
            return "redirect:/?reviewSubmitted=true";
        } else {
            model.addAttribute("error", "Failed to submit review");
            return "redirect:/";
        }
    }

    // Show room review form
    @GetMapping("/room/{roomId}")
    public String showRoomReviewForm(@PathVariable int roomId, Model model) {
        model.addAttribute("review", new RoomReview());
        model.addAttribute("roomId", roomId);
        model.addAttribute("type", "ROOM");
        return "review/room-form";
    }

    // Show service review form
    @GetMapping("/service/{serviceId}")
    public String showServiceReviewForm(@PathVariable int serviceId, Model model) {
        model.addAttribute("review", new ServiceReview());
        model.addAttribute("serviceId", serviceId);
        model.addAttribute("type", "SERVICE");
        return "review/service-form";
    }

    // Submit room review
    @PostMapping("/room/submit")
    public String submitRoomReview(
            @RequestParam int roomId,
            @RequestParam int rating,
            @RequestParam String comment,
            @RequestParam String cleanliness,
            @RequestParam String comfort,
            @RequestParam String location,
            HttpSession session,
            Model model) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        RoomReview review = new RoomReview(
                0, // ID will be generated by service
                currentUser.getId(),
                roomId,
                rating,
                comment,
                java.time.LocalDate.now(),
                "PENDING",
                cleanliness,
                comfort,
                location
        );

        reviewService.saveRoomReview(review);
        return "redirect:/review/room/list/" + roomId;
    }

    // Submit service review
    @PostMapping("/service/submit")
    public String submitServiceReview(
            @RequestParam int serviceId,
            @RequestParam int rating,
            @RequestParam String comment,
            @RequestParam String staffBehavior,
            @RequestParam String serviceQuality,
            @RequestParam String valueForMoney,
            HttpSession session,
            Model model) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        ServiceReview review = new ServiceReview(
                0, // ID will be generated by service
                currentUser.getId(),
                serviceId,
                rating,
                comment,
                LocalDate.now(),
                "PENDING",
                staffBehavior,
                serviceQuality,
                valueForMoney
        );

        if (reviewService.createReview(review)) {
            return "redirect:/service/details/" + serviceId;
        } else {
            model.addAttribute("error", "Failed to submit review");
            return "review/service-form";
        }
    }

    // View reviews for a room
    @GetMapping("/room/list/{roomId}")
    public String listRoomReviews(@PathVariable int roomId, Model model) {
        java.util.List<RoomReview> reviews = reviewService.getRoomReviews(roomId);
        model.addAttribute("reviews", reviews);
        model.addAttribute("type", "ROOM");
        model.addAttribute("roomId", roomId);
        return "review/list";
    }

    // View reviews for a service
    @GetMapping("/service/list/{serviceId}")
    public String listServiceReviews(@PathVariable int serviceId, Model model) {
        List<Review> reviews = reviewService.getReviewsByService(serviceId);
        model.addAttribute("reviews", reviews);
        model.addAttribute("type", "SERVICE");
        return "review/list";
    }

    // List all reviews for /review/list
    @GetMapping("/list")
    public String listAllReviews(Model model) {
        List<Review> reviews = reviewService.getAllReviews();
        model.addAttribute("reviews", reviews);
        model.addAttribute("type", "ALL");
        return "review/list";
    }

    // Admin: Moderate reviews
    @GetMapping("/moderate")
    public String showModerationPanel(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        List<Review> pendingReviews = reviewService.getAllReviews().stream()
                .filter(r -> "PENDING".equals(r.getStatus()))
                .toList();
        model.addAttribute("reviews", pendingReviews);
        return "review/moderate";
    }

    // Admin: Approve/Reject review
    @PostMapping("/moderate/{reviewId}")
    public String moderateReview(
            @PathVariable int reviewId,
            @RequestParam String action,
            HttpSession session) {

        User currentUser = (User) session.getAttribute("user");
        if (!(currentUser instanceof AdminUser)) {
            return "redirect:/auth/login";
        }

        String newStatus = "APPROVED";
        if ("reject".equals(action)) {
            newStatus = "REJECTED";
        }

        reviewService.updateReviewStatus(reviewId, newStatus);
        return "redirect:/review/moderate";
    }

    // Edit review form
    @GetMapping("/edit/{reviewId}")
    public String showEditForm(
            @PathVariable int reviewId,
            @RequestParam(required = false) Integer roomId,
            Model model,
            HttpSession session) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }

        RoomReview review = null;
        if (roomId != null) {
            // Try to find the room review in room-reviews.txt
            java.util.List<RoomReview> reviews = reviewService.getRoomReviews(roomId);
            for (RoomReview r : reviews) {
                if (r.getReviewId() == reviewId && r.getUserId() == currentUser.getId()) {
                    review = r;
                    break;
                }
            }
        }
        if (review == null) {
            // fallback to main reviews file
            Review fallback = reviewService.getReviewById(reviewId);
            if (fallback == null || (fallback.getUserId() != currentUser.getId() && !(currentUser instanceof AdminUser))) {
                return "redirect:/";
            }
            model.addAttribute("review", fallback);
            return "review/" + (fallback instanceof RoomReview ? "room-form" : "service-form");
        }
        model.addAttribute("review", review);
        model.addAttribute("roomId", review.getRoomId());
        return "review/room-form";
    }

    // Update review (room)
    @PostMapping("/room/update")
    public String updateRoomReview(
            @RequestParam int reviewId,
            @RequestParam int roomId,
            @RequestParam int rating,
            @RequestParam String comment,
            @RequestParam String cleanliness,
            @RequestParam String comfort,
            @RequestParam String location,
            HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }
        RoomReview updated = new RoomReview(
            reviewId,
            currentUser.getId(),
            roomId,
            rating,
            comment,
            java.time.LocalDate.now(),
            "PENDING",
            cleanliness,
            comfort,
            location
        );
        reviewService.updateRoomReview(updated);
        return "redirect:/review/room/list/" + roomId;
    }

    // Delete review (room)
    @PostMapping("/delete/{reviewId}")
    public String deleteReview(
            @PathVariable int reviewId,
            @RequestParam(required = false) Integer roomId,
            HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/auth/login";
        }
        if (roomId != null) {
            reviewService.deleteRoomReview(reviewId, roomId);
            return "redirect:/review/room/list/" + roomId;
        }
        Review review = reviewService.getReviewById(reviewId);
        if (review == null || (review.getUserId() != currentUser.getId() && !(currentUser instanceof AdminUser))) {
            return "redirect:/";
        }
        reviewService.deleteReview(reviewId);
        return "redirect:/user/profile";
    }

    // Show feedback form
    @GetMapping("/feedback")
    public String showFeedbackForm() {
        return "review/feedback";
    }

    // Handle feedback submission
    @PostMapping("/feedback")
    public String submitFeedback(@RequestParam("feedback") String feedback, Model model) {
        logger.info("Received feedback: {}", feedback);
        try (java.io.FileWriter fw = new java.io.FileWriter("data/reviews.txt", true)) {
            fw.write(feedback + System.lineSeparator());
            model.addAttribute("message", "Thank you for your feedback!");
            logger.info("Feedback written to data/reviews.txt");
        } catch (java.io.IOException e) {
            model.addAttribute("message", "Error saving feedback.");
            logger.error("Error writing feedback to file", e);
        }
        return "review/feedback";
    }
}

// DTO for featured reviews
class ReviewDTO {
    private int reviewId;
    private String userName;
    private int rating;
    private String comment;
    private LocalDate reviewDate;
    private String type;

    public ReviewDTO(int reviewId, String userName, int rating, String comment, LocalDate reviewDate, String type) {
        this.reviewId = reviewId;
        this.userName = userName;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.type = type;
    }

    // Getters
    public int getReviewId() { return reviewId; }
    public String getUserName() { return userName; }
    public int getRating() { return rating; }
    public String getComment() { return comment; }
    public LocalDate getReviewDate() { return reviewDate; }
    public String getType() { return type; }
}