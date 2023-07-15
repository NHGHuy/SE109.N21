package com.techshopbe.dto;

public class UserDTO {
	private int userID;
	private String fullname;
	private String phone;
	private String address;
	private String email;
	private String gender;
	private String dob;

	public UserDTO() {
	}

	public UserDTO(int userID, String fullname, String phone, String address, String email, String gender, String dob) {
		super();
		this.userID = userID;
		this.fullname = fullname;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.gender = gender;
		this.dob = dob;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

}
