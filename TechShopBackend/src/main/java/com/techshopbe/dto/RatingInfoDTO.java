package com.techshopbe.dto;

public class RatingInfoDTO {
	private float productRate;
	private int totalReviews;
	public float getProductRate() {
		return productRate;
	}
	public void setProductRate(float productRate) {
		this.productRate = productRate;
	}
	public int getTotalReviews() {
		return totalReviews;
	}
	public void setTotalReviews(int totalReviews) {
		this.totalReviews = totalReviews;
	}
	public RatingInfoDTO(float productRate, int totalReviews) {
		super();
		this.productRate = productRate;
		this.totalReviews = totalReviews;
	}
	
}
