package com.techshopbe.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "SALEPRODUCT", schema = "public")
public class SaleProduct {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int productID;
	private String startSale;
	private String endSale;
	private int productPrice;

	public SaleProduct() {
	}
	

	public SaleProduct(int productID, String startSale, String endSale, int productPrice) {
		super();
		this.productID = productID;
		this.startSale = startSale;
		this.endSale = endSale;
		this.productPrice = productPrice;
	}


	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getStartSale() {
		return startSale;
	}

	public void setStartSale(String startSale) {
		this.startSale = startSale;
	}

	public String getEndSale() {
		return endSale;
	}

	public void setEndSale(String endSale) {
		this.endSale = endSale;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	
}
