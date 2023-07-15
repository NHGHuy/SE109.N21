package com.techshopbe.dto;

public class PostReviewDTO {
	private int orderID;
	private int productID;
	private String reviewContent;
	private float rate;
	public int getOrderID() {
		return orderID;
	}
	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public float getRate() {
		return rate;
	}
	public void setRate(float rate) {
		this.rate = rate;
	}
	public PostReviewDTO(int orderID, int productID, String reviewContent, float rate) {
		super();
		this.orderID = orderID;
		this.productID = productID;
		this.reviewContent = reviewContent;
		this.rate = rate;
	}
	
}
