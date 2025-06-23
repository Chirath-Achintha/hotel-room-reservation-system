package com.PG64.RoomReservation.service;

import com.PG64.RoomReservation.model.Service;
import com.PG64.RoomReservation.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@org.springframework.stereotype.Service
public class ServiceService {

    @Autowired
    private FileUtil fileUtil;

    @Value("${services.file.path}")
    private String servicesFilePath;

    // Create new service
    public boolean addService(Service service) {
        try {
            List<String> services = fileUtil.readLines(servicesFilePath);
            services.add(convertServiceToFileString(service));
            return fileUtil.writeLines(servicesFilePath, services);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all services
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        try {
            List<String> serviceStrings = fileUtil.readLines(servicesFilePath);
            for (String serviceStr : serviceStrings) {
                services.add(parseServiceFromString(serviceStr));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Get available services
    public List<Service> getAvailableServices() {
        return getAllServices().stream()
                .filter(Service::isAvailable)
                .collect(Collectors.toList());
    }

    // Get service by ID
    public Service getServiceById(int serviceId) {
        return getAllServices().stream()
                .filter(s -> s.getServiceId() == serviceId)
                .findFirst()
                .orElse(null);
    }

    // Update service
    public boolean updateService(Service updatedService) {
        try {
            List<String> services = fileUtil.readLines(servicesFilePath);
            List<String> updatedServices = services.stream()
                .map(serviceStr -> {
                    Service service = parseServiceFromString(serviceStr);
                    return service.getServiceId() == updatedService.getServiceId() 
                           ? convertServiceToFileString(updatedService) 
                           : serviceStr;
                })
                .collect(Collectors.toList());

            return fileUtil.writeLines(servicesFilePath, updatedServices);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete service
    public boolean deleteService(int serviceId) {
        try {
            List<String> services = fileUtil.readLines(servicesFilePath);
            List<String> updatedServices = services.stream()
                    .filter(s -> parseServiceFromString(s).getServiceId() != serviceId)
                    .collect(Collectors.toList());

            if (updatedServices.size() < services.size()) {
                return fileUtil.writeLines(servicesFilePath, updatedServices);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Generate new service ID
    public int generateServiceId() {
        List<Service> services = getAllServices();
        return services.stream()
                .mapToInt(Service::getServiceId)
                .max()
                .orElse(0) + 1;
    }

    // Helper methods
    private String convertServiceToFileString(Service service) {
        return String.format("%d,%s,%s,%.2f,%b",
                service.getServiceId(),
                service.getName(),
                service.getDescription(),
                service.getPrice(),
                service.isAvailable());
    }

    private Service parseServiceFromString(String serviceStr) {
        String[] parts = serviceStr.split(",");
        final int id = Integer.parseInt(parts[0]);
        final String name = parts[1];
        final String desc = parts[2];
        final double price = Double.parseDouble(parts[3]);
        final boolean available = Boolean.parseBoolean(parts[4]);

        return new Service(id, name, desc, price, available) {
            @Override
            public String getServiceDetails() {
                return String.format("%s - %s ($%.2f)", name, desc, price);
            }
        };
    }
}