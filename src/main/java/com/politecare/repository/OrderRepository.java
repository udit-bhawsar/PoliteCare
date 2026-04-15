package com.politecare.repository;

import com.politecare.model.Order;
import com.politecare.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    // Is method ko add karna zaroori hai (Fixes the undefined error)
    List<Order> findByUserOrderByOrderDateDesc(User user);

    // Pehle wale saare orders (Admin ke liye)
    List<Order> findAllByOrderByOrderDateDesc();

    // --- Reports ke liye Queries ---

    // 1. Product-wise Sales (Kaunsi medicine kitni biki)
    @Query("SELECT p.name, SUM(oi.quantity) FROM Order o JOIN o.items oi JOIN oi.product p WHERE o.status = 'APPROVED' GROUP BY p.name")
    List<Object[]> getProductWiseSalesReport();

    // 2. Stockist-wise Sales (Kis distributor ne kitna business diya)
    @Query("SELECT u.fullName, SUM(o.totalAmount) FROM Order o JOIN o.user u WHERE o.status = 'APPROVED' GROUP BY u.fullName")
    List<Object[]> getStockistWiseSalesReport();

    // 3. Overall Sales Revenue
    @Query("SELECT SUM(o.totalAmount) FROM Order o WHERE o.status = 'APPROVED'")
    Double getTotalRevenue();
}