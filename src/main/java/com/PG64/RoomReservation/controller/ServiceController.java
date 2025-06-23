package com.PG64.RoomReservation.controller;

import com.PG64.RoomReservation.model.Service;
import com.PG64.RoomReservation.model.RoomService;
import com.PG64.RoomReservation.model.SpaService;
import com.PG64.RoomReservation.model.LaundryService;
import com.PG64.RoomReservation.service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/service")
public class ServiceController {

    @Autowired
    private ServiceService serviceService;

    // View all services
    @GetMapping("/catalog")
    public String viewServices(Model model) {
        model.addAttribute("services", serviceService.getAvailableServices());
        return "service/catalog";
    }

    // Show add service form (admin)
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("service", new Service(0, "", "", 0.0, true) {
            @Override
            public String getServiceDetails() {
                return "";
            }
        });
        return "service/add";
    }

    // Process new service
    @PostMapping("/add")
    public String addService(
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam double price,
            Model model) {

        Service newService = new Service(
                serviceService.generateServiceId(),
                name,
                description,
                price,
                true) {
            @Override
            public String getServiceDetails() {
                return String.format("%s - %s", name, description);
            }
        };

        if (serviceService.addService(newService)) {
            return "redirect:/service/catalog";
        } else {
            model.addAttribute("error", "Failed to add service");
            return "service/add";
        }
    }

    // Show edit form (admin)
    @GetMapping("/edit/{serviceId}")
    public String showEditForm(@PathVariable int serviceId, Model model) {
        Service service = serviceService.getServiceById(serviceId);
        if (service != null) {
            model.addAttribute("service", service);
            return "service/edit";
        }
        return "redirect:/service/catalog";
    }

    // Update service
    @PostMapping("/update")
    public String updateService(
            @RequestParam int serviceId,
            @RequestParam String type,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam double price,
            @RequestParam(required = false) boolean available,
            Model model) {

        Service service;
        switch (type) {
            case "RoomService":
                service = new RoomService(serviceId, name, description, price, available);
                break;
            case "SpaService":
                service = new SpaService(serviceId, name, description, price, available);
                break;
            case "LaundryService":
                service = new LaundryService(serviceId, name, description, price, available);
                break;
            default:
                model.addAttribute("error", "Invalid service type");
                return "service/edit";
        }

        if (serviceService.updateService(service)) {
            return "redirect:/service/catalog";
        } else {
            model.addAttribute("error", "Failed to update service");
            return "service/edit";
        }
    }

    // Delete service (admin)
    @PostMapping("/delete/{serviceId}")
    public String deleteService(@PathVariable int serviceId) {
        serviceService.deleteService(serviceId);
        return "redirect:/service/catalog";
    }
}