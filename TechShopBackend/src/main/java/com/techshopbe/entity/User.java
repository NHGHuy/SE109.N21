package com.techshopbe.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;

@Entity
@Table(name = "USER", schema = "public")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userID;
	private String email;
	private String fullname;
	@JsonProperty(access = Access.WRITE_ONLY)
	private String pswd;
	private String DOB;
	private String phone;
	private String address;
	private int roleID;
	private String gender;
	private int totalInvoices = 0;
	
	public User() {};
	public User(int userID, String email, String fullname, String pswd, String dOB, String phone, String address,
			int roleID, String gender, int totalInvoices) {
		super();
		this.userID = userID;
		this.email = email;
		this.fullname = fullname;
		this.pswd = pswd;
		DOB = dOB;
		this.phone = phone;
		this.address = address;
		this.roleID = roleID;
		this.gender = gender;
		this.totalInvoices = totalInvoices;
	}
	
	public int getTotalInvoices() {
		return totalInvoices;
	}
	public void setTotalInvoices(int totalInvoices) {
		this.totalInvoices = totalInvoices;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getPswd() {
		return pswd;
	}
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}
	public String getDOB() {
		return DOB;
	}
	public void setDOB(String dOB) {
		DOB = dOB;
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
	public int getRoleID() {
		return roleID;
	}
	public void setRoleID(int roleID) {
		this.roleID = roleID;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	

	
}
