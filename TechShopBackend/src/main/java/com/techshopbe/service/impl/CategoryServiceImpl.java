package com.techshopbe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.techshopbe.entity.Category;
import com.techshopbe.repository.CategoryRepository;
import com.techshopbe.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryRepository categoryRepository;
	@Override
	public List<Category> getAll() {
		return categoryRepository.findAll();
	}

}
