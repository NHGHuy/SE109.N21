package com.techshopbe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.techshopbe.entity.Brand;

public interface BrandRepository  extends JpaRepository<Brand, Integer> {

}
