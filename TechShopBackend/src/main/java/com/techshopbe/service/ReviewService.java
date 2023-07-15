package com.techshopbe.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.techshopbe.dto.PostReviewDTO;
import com.techshopbe.dto.ReviewDTO;



public interface ReviewService {
	List<ReviewDTO> getAllReviewsByProductID(int productID, Pageable page);
	void addReview(PostReviewDTO postReviewDTO);

}
