package com.techshopbe.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.techshopbe.dto.ProductDTO;
import com.techshopbe.entity.Brand;
import com.techshopbe.repository.BrandRepository;
import com.techshopbe.service.BrandService;

@Service
public class BrandServiceImpl implements BrandService {
	@Autowired
	private BrandRepository brandRepository;

	@Override
	public List<Brand> getAll() {
		List<Brand> tempBrands = brandRepository.findAll();
		List<Brand> brands = new ArrayList<Brand>();
		for (int i = 0; i < 8; i++) {
			brands.add(tempBrands.get(i));
		}
		return brands;
	}

}
