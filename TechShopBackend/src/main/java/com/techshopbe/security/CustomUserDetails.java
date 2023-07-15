package com.techshopbe.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUserDetails extends User {
	
	private static final long serialVersionUID = 1L;
	private final int userID;

	public int getUserID() {
		return userID;
	}

	public CustomUserDetails(String username, String password, int userID, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities );
		this.userID = userID;
		// TODO Auto-generated constructor stub
	}

	
	
}
