package com.PG64.RoomReservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
public class FeedbackController {
    private static final String FEEDBACK_FILE = "data/reviews.txt";

    @GetMapping("/feedback")
    public String showFeedbackPage(Model model, HttpSession session, @RequestParam(value = "edit", required = false) Integer editIndex) {
        List<String> rawList = readFeedback();
        List<FeedbackEntry> feedbackList = parseFeedbackList(rawList);
        model.addAttribute("feedbackList", feedbackList);
        model.addAttribute("editIndex", editIndex);
        if (editIndex != null && editIndex >= 0 && editIndex < feedbackList.size()) {
            model.addAttribute("editFeedback", feedbackList.get(editIndex));
        }
        model.addAttribute("currentUser", getCurrentUsername(session));
        return "review/feedback";
    }

    @PostMapping("/feedback")
    public String addFeedback(@RequestParam("feedback") String feedback,
                              @RequestParam("rating") int rating,
                              HttpSession session,
                              Model model) {
        String username = getCurrentUsername(session);
        if ("Unknown".equals(username)) {
            // Not logged in, redirect to login
            return "redirect:/auth/login";
        }
        String entry = username + "|" + rating + "|" + feedback.replace("\n", " ");
        try (java.io.FileWriter fw = new java.io.FileWriter(FEEDBACK_FILE, true)) {
            fw.write(entry + System.lineSeparator());
            model.addAttribute("message", "Thank you for your feedback!");
        } catch (java.io.IOException e) {
            model.addAttribute("message", "Error saving feedback.");
        }
        model.addAttribute("feedbackList", parseFeedbackList(readFeedback()));
        model.addAttribute("currentUser", username);
        return "review/feedback";
    }

    @PostMapping("/feedback/delete")
    public String deleteFeedback(@RequestParam("index") int index, HttpSession session, Model model) {
        List<String> rawList = new ArrayList<>(readFeedback());
        List<FeedbackEntry> feedbackList = parseFeedbackList(rawList);
        String username = getCurrentUsername(session);
        if (index >= 0 && index < feedbackList.size() && username.equals(feedbackList.get(index).username)) {
            rawList.remove(index);
            try {
                Files.write(Paths.get(FEEDBACK_FILE), rawList);
                model.addAttribute("message", "Feedback deleted.");
            } catch (java.io.IOException e) {
                model.addAttribute("message", "Error deleting feedback.");
            }
        }
        model.addAttribute("feedbackList", parseFeedbackList(rawList));
        model.addAttribute("currentUser", username);
        return "review/feedback";
    }

    @PostMapping("/feedback/edit")
    public String editFeedback(@RequestParam("index") int index,
                               @RequestParam("feedback") String feedback,
                               @RequestParam("rating") int rating,
                               HttpSession session,
                               Model model) {
        List<String> rawList = new ArrayList<>(readFeedback());
        List<FeedbackEntry> feedbackList = parseFeedbackList(rawList);
        String username = getCurrentUsername(session);
        if (index >= 0 && index < feedbackList.size() && username.equals(feedbackList.get(index).username)) {
            String newEntry = username + "|" + rating + "|" + feedback.replace("\n", " ");
            rawList.set(index, newEntry);
            try {
                Files.write(Paths.get(FEEDBACK_FILE), rawList);
                model.addAttribute("message", "Feedback updated.");
            } catch (java.io.IOException e) {
                model.addAttribute("message", "Error updating feedback.");
            }
        }
        model.addAttribute("feedbackList", parseFeedbackList(rawList));
        model.addAttribute("currentUser", username);
        return "review/feedback";
    }

    private List<String> readFeedback() {
        try {
            return Files.readAllLines(Paths.get(FEEDBACK_FILE));
        } catch (java.io.IOException e) {
            return new ArrayList<>();
        }
    }

    private List<FeedbackEntry> parseFeedbackList(List<String> rawList) {
        List<FeedbackEntry> result = new ArrayList<>();
        for (String line : rawList) {
            if (line == null || line.trim().isEmpty()) continue; // skip empty lines
            String[] parts = line.split("\\|", 3);
            if (parts.length == 3) {
                try {
                    int rating = Integer.parseInt(parts[1]);
                    result.add(new FeedbackEntry(parts[0], rating, parts[2]));
                } catch (NumberFormatException e) {
                    // skip lines with invalid rating
                }
            }
            // skip lines that don't match the format
        }
        return result;
    }

    private String getCurrentUsername(HttpSession session) {
        Object userObj = session.getAttribute("user");
        if (userObj != null) {
            try {
                java.lang.reflect.Method m = userObj.getClass().getMethod("getUsername");
                return (String) m.invoke(userObj);
            } catch (Exception e) {
                return "Unknown";
            }
        }
        return "Unknown";
    }

    public static class FeedbackEntry {
        private String username;
        private int rating;
        private String feedback;
        public FeedbackEntry(String username, int rating, String feedback) {
            this.username = username;
            this.rating = rating;
            this.feedback = feedback;
        }
        public String getUsername() { return username; }
        public int getRating() { return rating; }
        public String getFeedback() { return feedback; }
    }
} 