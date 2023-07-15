package com.techshopbe.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.techshopbe.entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {

}
