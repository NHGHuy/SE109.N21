package com.techshopbe.dto;

public class ReviewDTO {
	private int reviewID;
	private int productID;
	private String fullname;
	private String reviewDate;
	private String reviewContent;
	private float rate;

	public ReviewDTO() {
	}

	public ReviewDTO(int reviewID, int productID, String fullname, String reviewDate, String reviewContent,
			float rate) {
		super();
		this.reviewID = reviewID;
		this.productID = productID;
		this.fullname = fullname;
		this.reviewDate = reviewDate;
		this.reviewContent = reviewContent;
		this.rate = rate;
	}

	public int getReviewID() {
		return reviewID;
	}

	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
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

}
