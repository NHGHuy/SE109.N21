package com.techshopbe.dto;

public class AuthenticationDTO {
	public String email;
	public String pswd;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPswd() {
		return pswd;
	}
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}
	public AuthenticationDTO(String email, String pswd) {
		super();
		this.email = email;
		this.pswd = pswd;
	}
	
	
}
