package com.politecare.controller;

import com.politecare.model.*;
import com.politecare.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired private ProductRepository productRepo;
    @Autowired private OrderRepository orderRepo;

    // 1. View Cart
    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        List<CartItem> cart = getCartFromSession(session);
        model.addAttribute("cartItems", cart);
        model.addAttribute("total", calculateCartTotal(cart));
        return "user/cart"; // We will create this JSP
    }

    // 2. Add Item to Cart
    @PostMapping("/add")
    public String addToCart(@RequestParam("productId") Long productId, @RequestParam("quantity") Integer quantity, HttpSession session) {
        List<CartItem> cart = getCartFromSession(session);
        Product product = productRepo.findById(productId).orElse(null);

        if (product != null) {
            boolean alreadyInCart = false;
            // Check if product already exists, just increase quantity
            for (CartItem item : cart) {
                if (item.getProduct().getId().equals(productId)) {
                    item.setQuantity(item.getQuantity() + quantity);
                    alreadyInCart = true;
                    break;
                }
            }
            if (!alreadyInCart) {
                cart.add(new CartItem(product, quantity));
            }
        }
        return "redirect:/cart"; // Go to cart page after adding
    }

    // 3. Remove Item
    @GetMapping("/remove/{productId}")
    public String removeFromCart(@PathVariable("productId") Long productId, HttpSession session) {
        List<CartItem> cart = getCartFromSession(session);
        // Use Iterator to safely remove while looping
        Iterator<CartItem> iterator = cart.iterator();
        while (iterator.hasNext()) {
            if (iterator.next().getProduct().getId().equals(productId)) {
                iterator.remove();
                break;
            }
        }
        return "redirect:/cart";
    }

    // 4. Checkout (Finalize Order)
    @PostMapping("/checkout")
    public String checkout(@RequestParam("address") String address, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = getCartFromSession(session);
        if (cart.isEmpty()) return "redirect:/cart";

        // Create new Order Object
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("PENDING");
        order.setDeliveryAddress(address);

        List<OrderItem> orderItems = new ArrayList<>();
        double grandTotal = 0.0;

        for (CartItem cartItem : cart) {
            Product p = cartItem.getProduct();
            
            // Check Live Stock again before saving
            if (p.getStockQuantity() < cartItem.getQuantity()) {
                return "redirect:/cart?error=Out of Stock: " + p.getName();
            }

            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(p);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPriceAtPurchase(p.getPrice());
            orderItems.add(orderItem);

            grandTotal += (p.getPrice() * cartItem.getQuantity());
        }

        order.setItems(orderItems);
        order.setTotalAmount(grandTotal);
        orderRepo.save(order);

        // Clear Session Cart after successful order
        session.removeAttribute("cart");

        return "redirect:/user/my-orders";
    }

    // Helper: Get or Create Cart in Session
    @SuppressWarnings("unchecked")
    private List<CartItem> getCartFromSession(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    // Helper: Calculate Total
    private Double calculateCartTotal(List<CartItem> cart) {
        return cart.stream().mapToDouble(CartItem::getTotalPrice).sum();
    }
}