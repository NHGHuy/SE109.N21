package com.techshopbe.service.impl;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.util.StreamUtils;

import com.techshopbe.dto.DetailedProductDTO;
import com.techshopbe.dto.ProductDTO;
import com.techshopbe.dto.RatingInfoDTO;
import com.techshopbe.repository.ProductRepository;
import com.techshopbe.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductRepository productRepository;

	@Override
	public List<ProductDTO> getAll() {
		return productRepository.getAll();

	}

	@Override
	public List<ProductDTO> getTrendingProducts() {
		List<ProductDTO> products = productRepository.findTrendingProducts();
		List<ProductDTO> trendingProducts = new ArrayList<ProductDTO>();
		for (int i = 0; i < 8; i++) {
			trendingProducts.add(products.get(i));
		}
		return trendingProducts;
	}

	@Override
	public List<ProductDTO> getTopPurchasedProducts(int categoryID) {

		List<ProductDTO> productsByCategory = productRepository.findTopPurchasedByCategoryId(categoryID);
		List<ProductDTO> topPurchasedProducts = new ArrayList<ProductDTO>();
		for (int i = 0; i < 5; i++) {
			topPurchasedProducts.add(productsByCategory.get(i));
		}
		return topPurchasedProducts;

	}

	@Override
	public List<ProductDTO> getProductsByCategory(String categorySlug) {

		return productRepository.findByCategorySlug(categorySlug);

	}

	@Override
	public DetailedProductDTO getDetailedProduct(int productID) {
		DetailedProductDTO detailedProduct = productRepository.findDetailedProductByProductID(productID);
		if (detailedProduct.getStock() > 0)
			detailedProduct.setStockStatus("in-stock");
		else if (detailedProduct.getStock() == 0)
			detailedProduct.setStockStatus("out-of-stock");
		return detailedProduct;
	}

	@Override
	public List<ProductDTO> getRelatedCategoryProducts(int productID) {
		List<ProductDTO> productsByCategory = productRepository.findRelatedProductsByCategory(productID);
		List<ProductDTO> relatedProducts = new ArrayList<ProductDTO>();
		for (int i = 0; i < 4; i++) {
			relatedProducts.add(productsByCategory.get(i));
		}
		return relatedProducts;
	}

	@Override
	public List<ProductDTO> getRelatedBrandProducts(int productID) {
		List<ProductDTO> productsByBrand = productRepository.findRelatedProductsByBrand(productID);
		List<ProductDTO> relatedProducts = new ArrayList<ProductDTO>();
		// System.out.println(productsByBrand.size());
		for (int i = 0; i < productsByBrand.size() && i < 4; i++) {
			relatedProducts.add(productsByBrand.get(i));
		}
		return relatedProducts;
	}

	@Override
	public void updateRating(int productID, float rate) {
		RatingInfoDTO ratingInfoDTO = productRepository.findRatingInfoByProductID(productID);
		int newTotalReviews = ratingInfoDTO.getTotalReviews() + 1;
		float newRating = (ratingInfoDTO.getProductRate() * ratingInfoDTO.getTotalReviews() + rate) / newTotalReviews;
		//System.out.println(newRating);
		//System.out.println(newTotalReviews);
		productRepository.updateRatingInfoByProductID(newRating, newTotalReviews, productID);
	}

}
