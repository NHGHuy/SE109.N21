package com.techshopbe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.techshopbe.entity.Role;
import com.techshopbe.repository.RoleRepository;
import com.techshopbe.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleRepository roleRepository;

	@Override
	public Role getById(int id) {
		return roleRepository.findById(id).get();
	}

	@Override
	public List<Role> getAll() {
		return roleRepository.findAll();
	}

}
