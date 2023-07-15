package com.techshopbe.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "SHIPPINGINFO", schema = "public")
public class ShippingInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int shippingInfoID;
	private int invoiceID;
	private String fullname;
	private String phone;
	private String address;

	public ShippingInfo() {
	}
	

	public ShippingInfo(int shippingInfoID, int invoiceID, String fullname, String phone, String address) {
		super();
		this.shippingInfoID = shippingInfoID;
		this.invoiceID = invoiceID;
		this.fullname = fullname;
		this.phone = phone;
		this.address = address;
	}


	public int getShippingInfoID() {
		return shippingInfoID;
	}

	public void setShippingInfoID(int shippingInfoID) {
		this.shippingInfoID = shippingInfoID;
	}

	public int getInvoiceID() {
		return invoiceID;
	}

	public void setInvoiceID(int invoiceID) {
		this.invoiceID = invoiceID;
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
	
}
