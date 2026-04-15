package com.politecare.controller;

import com.politecare.model.User;
import com.politecare.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    @Autowired private UserRepository userRepo;

    @GetMapping("/login")
    public String login() { return "login"; }

    @GetMapping("/register")
    public String register() { return "register"; }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user) {
        user.setRole("USER");
        userRepo.save(user);
        return "redirect:/login?success";
    }

//    @PostMapping("/login")
//    public String doLogin(@RequestParam("email") String email, @RequestParam("password") String password, HttpSession session) {
//        User user = userRepo.findByEmail(email);
//        if (user != null && user.getPassword().equals(password)) {
//            session.setAttribute("user", user);
//            return "ADMIN".equals(user.getRole()) ? "redirect:/admin/dashboard" : "redirect:/";
//        }
//        return "redirect:/login?error";
//    }
    
    @PostMapping("/login")
    public String doLogin(@RequestParam("email") String email, 
                         @RequestParam("password") String password, 
                         HttpSession session) {
        User user = userRepo.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("user", user);
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/";
            }
        }

        return "redirect:/login?error=true";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}