package com.techshopbe.dto;

public class ProductDTO {

	private int productID;
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
	private String categorySlug;
	private String images;
	
	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	public String getCategorySlug() {
		return categorySlug;
	}

	public void setCategorySlug(String categorySlug) {
		this.categorySlug = categorySlug;
	}

	public ProductDTO() {}

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

	public ProductDTO(int productID, String categoryName, String brandName, float productRate, String productName,
			int productPrice, String shortDescrip, String longDescrip, int stock, int warranty, int purchased,
			String specs, String categorySlug, String images) {
		super();
		this.productID = productID;
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
		this.categorySlug = categorySlug;
		this.images = images;
	}

	
	
	
	
	
}
