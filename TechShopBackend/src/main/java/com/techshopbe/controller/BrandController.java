package com.techshopbe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.techshopbe.entity.Brand;
import com.techshopbe.service.BrandService;

@RestController
@RequestMapping("api/v1/brand")
public class BrandController {
	@Autowired
	BrandService brandService;

	@GetMapping(value = "")
	public Object index() {
		try {
			List<Brand> brandList = brandService.getAll();

			return new ResponseEntity<List<Brand>>(brandList, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<String>("Failed", HttpStatus.BAD_REQUEST);
		}
	}
}
