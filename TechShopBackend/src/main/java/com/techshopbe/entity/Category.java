package com.techshopbe.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "CATEGORY", schema = "public")
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@JsonIgnore
	private int categoryID;
	private String categoryName;
	private String categorySlug;
	private boolean categoryExact;
	
	public Category() {
	}

	public Category(int categoryID, String categoryName, String categorySlug, boolean categoryExact) {
		super();
		this.categoryID = categoryID;
		this.categoryName = categoryName;
		this.categorySlug = categorySlug;
		this.categoryExact = categoryExact;
	}

	public int getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCategorySlug() {
		return categorySlug;
	}

	public void setCategorySlug(String categorySlug) {
		this.categorySlug = categorySlug;
	}

	public boolean isCategoryExact() {
		return categoryExact;
	}

	public void setCategoryExact(boolean categoryExact) {
		this.categoryExact = categoryExact;
	}

}
