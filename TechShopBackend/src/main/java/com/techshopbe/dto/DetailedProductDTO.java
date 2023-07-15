package com.techshopbe.dto;

public class DetailedProductDTO {
	private int productID;
	private int categoryID;
	private int brandID;
	private String categoryName;
	private String brandName;
	private float productRate;
	private String productName;
	private int productPrice;
	private String shortDescrip;
	private String longDescrip;
	private int stock;
	private int warranty;
	private int purchased;
	private String specs;
	private String stockStatus;
	private String shortTech;
	private int totalReviews;
	private String images;
	
	
	public int getTotalReviews() {
		return totalReviews;
	}

	public void setTotalReviews(int totalReviews) {
		this.totalReviews = totalReviews;
	}

	public DetailedProductDTO() {}

	public DetailedProductDTO(int productID, int categoryID, int brandID, String categoryName, String brandName, float productRate,
			String productName, int productPrice, String shortDescrip, String longDescrip, int stock, int warranty,
			int purchased, String specs, String shortTech,int totalReviews, String images) {
		super();
		this.productID = productID;
		this.categoryID = categoryID;
		this.brandID = brandID;
		this.categoryName = categoryName;
		this.brandName = brandName;
		this.productRate = productRate;
		this.productName = productName;
		this.productPrice = productPrice;
		this.shortDescrip = shortDescrip;
		this.longDescrip = longDescrip;
		this.stock = stock;
		this.warranty = warranty;
		this.purchased = purchased;
		this.specs = specs;
		this.shortTech = shortTech;
		this.totalReviews = totalReviews;
		this.images = images;
	}
	
	

	public String getShortTech() {
		return shortTech;
	}

	public void setShortTech(String shortTech) {
		this.shortTech = shortTech;
	}

	public int getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}

	public int getBrandID() {
		return brandID;
	}

	public void setBrandID(int brandID) {
		this.brandID = brandID;
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public float getProductRate() {
		return productRate;
	}

	public void setProductRate(float productRate) {
		this.productRate = productRate;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getShortDescrip() {
		return shortDescrip;
	}

	public void setShortDescrip(String shortDescrip) {
		this.shortDescrip = shortDescrip;
	}

	public String getLongDescrip() {
		return longDescrip;
	}

	public void setLongDescrip(String longDescrip) {
		this.longDescrip = longDescrip;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getWarranty() {
		return warranty;
	}

	public void setWarranty(int warranty) {
		this.warranty = warranty;
	}

	public int getPurchased() {
		return purchased;
	}

	public void setPurchased(int purchased) {
		this.purchased = purchased;
	}

	public String getSpecs() {
		return specs;
	}

	public void setSpecs(String specs) {
		this.specs = specs;
	}

	public String getStockStatus() {
		return stockStatus;
	}

	public void setStockStatus(String stockStatus) {
		this.stockStatus = stockStatus;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	};
	
	
	
}
