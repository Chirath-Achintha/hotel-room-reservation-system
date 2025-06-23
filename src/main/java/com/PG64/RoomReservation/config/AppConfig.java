package com.PG64.RoomReservation.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.nio.file.Paths;

@Configuration
public class AppConfig implements WebMvcConfigurer {

    // Configure file paths for data storage
    @Bean
    public String usersFilePath() {
        return Paths.get("src", "main", "data", "users.txt").toString();
    }

    @Bean
    public String roomsFilePath() {
        return Paths.get("src", "main", "data", "rooms.txt").toString();
    }

    @Bean
    public String bookingsFilePath() {
        return Paths.get("src", "main", "data", "bookings.txt").toString();
    }

    @Bean
    public String staffFilePath() {
        return Paths.get("src", "main", "data", "staff.txt").toString();
    }

    @Bean
    public String servicesFilePath() {
        return Paths.get("src", "main", "data", "services.txt").toString();
    }

    @Bean
    public String reviewsFilePath() {
        return Paths.get("src", "main", "data", "reviews.txt").toString();
    }

    // Configure JSP view resolver
    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");  // Note: This should match your actual JSP location
        resolver.setSuffix(".jsp");
        return resolver;
    }

    // Optional: Map default paths to avoid "Whitelabel Error Page"
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/auth/login");
        registry.addViewController("/login").setViewName("auth/login");
        registry.addViewController("/register").setViewName("auth/register");
    }
}