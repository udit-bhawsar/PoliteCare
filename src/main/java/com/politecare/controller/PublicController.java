package com.politecare.controller;

import com.politecare.model.*;
import com.politecare.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.*;

@Controller
public class PublicController {

    @Autowired private ProductRepository productRepo;
    @Autowired private OrderRepository orderRepo;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("products", productRepo.findAll());
        return "index"; // resolves to /WEB-INF/views/index.jsp
    }

    @PostMapping("/order/place")
    public String placeOrder(@RequestParam("productId") Long productId, @RequestParam("quantity") Integer quantity, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Product product = productRepo.findById(productId).orElse(null);
        if (product != null && product.getStockQuantity() >= quantity) {
            Order order = new Order();
            order.setUser(user);
            order.setOrderDate(LocalDateTime.now());
            order.setStatus("PENDING");
            
            OrderItem item = new OrderItem();
            item.setProduct(product);
            item.setQuantity(quantity);
            item.setPriceAtPurchase(product.getPrice());
            
            List<OrderItem> items = new ArrayList<>();
            items.add(item);
            order.setItems(items);
            order.setTotalAmount(product.getPrice() * quantity);
            
            orderRepo.save(order);
        }
        return "redirect:/user/my-orders";
    }

    @GetMapping("/user/my-orders")
    public String myOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        model.addAttribute("orders", orderRepo.findByUserOrderByOrderDateDesc(user));
        return "user/my-orders";
    }
    

    @GetMapping("/products")
    public String viewAllProducts(@RequestParam(value = "category" , required = false) String category, Model model) {
        
        // 1. Sidebar ke liye saari Categories bhejo
        model.addAttribute("categoryList", productRepo.findDistinctCategories());

        // 2. Filter Logic
        List<Product> products;
        if (category != null && !category.isEmpty() && !category.equals("All")) {
            // Agar koi category select ki hai
            products = productRepo.findByCategory(category);
            model.addAttribute("activeCategory", category);
        } else {
            // Agar "All" select kiya ya first time page khola
            products = productRepo.findAll();
            model.addAttribute("activeCategory", "All");
        }

        model.addAttribute("products", products);
        return "products"; // Refers to products.jsp
    }
    
 // Ye method pehle se jo PublicController hai usme last mein add kardo
    @GetMapping("/user/order/invoice/{id}")
    public String viewInvoice(@PathVariable("id")Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) return "redirect:/login";

        // Database se specific order nikalna
        Order order = orderRepo.findById(id).orElse(null);
        
        // Security check: Taaki koi aur kisi doosre distributor ka invoice na dekh sake
        if (order != null && order.getUser().getId().equals(user.getId())) {
            model.addAttribute("order", order);
            return "user/invoice"; // Ye JSP hum abhi banayenge
        }
        
        return "redirect:/user/my-orders";
    }
    
}