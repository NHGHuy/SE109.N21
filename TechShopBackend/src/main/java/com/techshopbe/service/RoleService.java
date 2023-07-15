package com.techshopbe.service;

import java.util.List;

import com.techshopbe.entity.Role;


public interface RoleService {
	Role getById(int id);
	List<Role> getAll();
}
