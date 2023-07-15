package com.techshopbe.dto;

// chi tiet hoa don
public class DetailedInvoiceDTO {
	private int productID;
	private int productPrice;
	private int quantity;
	private int totalPrice;
	private String productName;
	private boolean isReviewed;
	private String images;
	private String categorySlug;

	public String getCategorySlug() {
		return categorySlug;
	}

	public void setCategorySlug(String categorySlug) {
		this.categorySlug = categorySlug;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	public void setReviewed(boolean isReviewed) {
		this.isReviewed = isReviewed;
	}

	public boolean getIsReviewed() {
		return isReviewed;
	}

	public void setIsReviewed(boolean isReviewed) {
		this.isReviewed = isReviewed;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public DetailedInvoiceDTO() {
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public DetailedInvoiceDTO(int productID, int productPrice, int quantity, int totalPrice, String productName,
			boolean isReviewed, String images, String categorySlug) {
		super();
		this.productID = productID;
		this.productPrice = productPrice;
		this.quantity = quantity;
		this.totalPrice = totalPrice;
		this.productName = productName;
		this.isReviewed = isReviewed;
		this.images = images;
		this.categorySlug = categorySlug;
	}

}
