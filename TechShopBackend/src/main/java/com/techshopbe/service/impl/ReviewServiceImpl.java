package com.techshopbe.service.impl;


import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.techshopbe.dto.PostReviewDTO;
import com.techshopbe.dto.ReviewDTO;
import com.techshopbe.entity.Review;
import com.techshopbe.repository.ReviewRepository;
import com.techshopbe.security.CustomUserDetails;
import com.techshopbe.service.ReviewService;


@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewRepository reviewRepository;

	@Override
	public List<ReviewDTO> getAllReviewsByProductID(int productID, Pageable page) {
		return reviewRepository.getAllByProductID(productID, page);
		
	}

	@Override
	public void addReview(PostReviewDTO postReviewDTO) {
		
		Review review = new Review();
		// set general info for review
		review.setProductID(postReviewDTO.getProductID());
		review.setRate(postReviewDTO.getRate());
		review.setReviewContent(postReviewDTO.getReviewContent());
		
		LocalDateTime reviewDate = LocalDateTime.now();
		review.setReviewDate(reviewDate.toString());
		
		// set userID for review
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails)auth.getPrincipal();
		
		int userID = userDetails.getUserID();
		review.setUserID(userID);
		
		reviewRepository.save(review);
		
	}

	

}
