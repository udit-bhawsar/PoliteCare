package com.politecare.controller;

import com.politecare.model.*;
import com.politecare.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.util.Base64;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private ProductRepository productRepo;
    @Autowired private OrderRepository orderRepo;

    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getRole());
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("products", productRepo.findAll());
        return "admin/dashboard";
    }

    @PostMapping("/add-product")
    public String addProduct(@RequestParam("name") String name,
                             @RequestParam("category") String category,
                             @RequestParam("price") Double price,
                             @RequestParam("stock") Integer stock,
                             @RequestParam("desc") String desc,
                             @RequestParam("image") MultipartFile file) throws Exception {
        
        Product p = new Product();
        p.setName(name); p.setCategory(category); p.setPrice(price);
        p.setStockQuantity(stock); p.setDescription(desc);
        
        if (!file.isEmpty()) {
            // Image bytes ko Base64 text me convert kiya aur DB me dalo
            String base64Image = Base64.getEncoder().encodeToString(file.getBytes());
            p.setImageBase64(base64Image);
        }

        productRepo.save(p);
        return "redirect:/admin/dashboard";
    }
    
    
    @GetMapping("/delete-product/{id}")
    public String deleteProduct(@PathVariable("id") Long id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        productRepo.deleteById(id);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/orders")
    public String manageOrders(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("orders", orderRepo.findAllByOrderByOrderDateDesc());
        return "admin/orders";
    }

    @GetMapping("/order-action/{id}/{status}")
    public String orderAction(@PathVariable("id") Long id, @PathVariable("status") String status, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        Order order = orderRepo.findById(id).orElse(null);
        if (order != null && "PENDING".equals(order.getStatus())) {
            if ("APPROVED".equals(status)) {
                for (OrderItem item : order.getItems()) {
                    Product p = item.getProduct();
                    p.setStockQuantity(Math.max(0, p.getStockQuantity() - item.getQuantity()));
                    productRepo.save(p);
                }
                order.setStatus("APPROVED");
            } else if ("REJECTED".equals(status)) {
                order.setStatus("REJECTED");
            }
            orderRepo.save(order);
        }
        return "redirect:/admin/orders";
    }
    
    @GetMapping("/reports")
    public String viewReports(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        // Data for Summary Cards
        model.addAttribute("totalRevenue", orderRepo.getTotalRevenue());
        model.addAttribute("totalProducts", productRepo.count());
        model.addAttribute("totalOrders", orderRepo.count());

        // Detailed Data for Tables
        model.addAttribute("productSales", orderRepo.getProductWiseSalesReport());
        model.addAttribute("stockistSales", orderRepo.getStockistWiseSalesReport());
        model.addAttribute("inventory", productRepo.findAll());

        return "admin/reports";
    }
    
    @PostMapping("/add-stock")
    public String addStock(@RequestParam("id") Long id, @RequestParam("refillQty") Integer refillQty, HttpSession session) {
        // Admin validation
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) return "redirect:/login";

        Product product = productRepo.findById(id).orElse(null);
        if (product != null) {
            // Nayi production batch add ho rahi hai (Add to existing)
            product.setStockQuantity(product.getStockQuantity() + refillQty);
            productRepo.save(product);
        }
        return "redirect:/admin/dashboard?msg=Stock Updated Successfully";
    }
}