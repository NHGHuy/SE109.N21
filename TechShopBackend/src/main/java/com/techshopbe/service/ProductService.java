package com.techshopbe.service;

import java.util.List;

import javax.swing.SortOrder;

import com.techshopbe.dto.DetailedProductDTO;
import com.techshopbe.dto.ProductDTO;

public interface ProductService {
	public List<ProductDTO> getAll();
	public List<ProductDTO> getTrendingProducts();
	public List<ProductDTO> getProductsByCategory(String categorySlug);
	public List<ProductDTO> getTopPurchasedProducts(int categoryID);
	public DetailedProductDTO getDetailedProduct(int productID);
	public List<ProductDTO> getRelatedCategoryProducts(int productID);
	public List<ProductDTO> getRelatedBrandProducts(int productID);
	public void updateRating(int productID, float rate);
}
