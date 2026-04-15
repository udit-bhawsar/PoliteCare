package com.politecare.repository;

import com.politecare.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    
    // Specific Category ke products dhundne ke liye
    List<Product> findByCategory(String category);

    // Sidebar ke liye saari unique categories laane ke liye (Duplicate nahi ayenge)
    @Query("SELECT DISTINCT p.category FROM Product p")
    List<String> findDistinctCategories();
    
    List<Product> findByNameContainingIgnoreCase(String keyword);
}