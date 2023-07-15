package com.techshopbe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.techshopbe.entity.Role;
import com.techshopbe.service.RoleService;

@RestController
@RequestMapping("api/v1/role")
public class RoleController {

	@Autowired
	private RoleService roleService;
	
	@GetMapping(value = "")
	public Object index() {
		try {
			List<Role> roleList = roleService.getAll();

			return new ResponseEntity<List<Role>>(roleList, HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<String>("Failed", HttpStatus.BAD_REQUEST);
		}
	}
}
