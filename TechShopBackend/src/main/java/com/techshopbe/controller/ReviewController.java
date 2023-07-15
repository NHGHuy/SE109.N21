package com.techshopbe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.techshopbe.dto.PostReviewDTO;
import com.techshopbe.dto.ReviewDTO;
import com.techshopbe.entity.Review;
import com.techshopbe.service.InvoiceService;
import com.techshopbe.service.ProductService;
import com.techshopbe.service.ReviewService;

@RestController
@RequestMapping("api/v1/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	@Autowired
	ProductService productService;
	@Autowired
	InvoiceService invoiceService;

	@GetMapping(value = "/{productID}")
	public Object getAllReviewsByProductID(@PathVariable int productID, @RequestParam int limit,
			@RequestParam int page) {
		try {
			//System.out.println(page);
			List<ReviewDTO> reviewsByProductID = reviewService.getAllReviewsByProductID(productID, PageRequest.of(page,  limit));
			return new ResponseEntity<List<ReviewDTO>>(reviewsByProductID, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<String>("Failed", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping(value = "")
	public Object addReview(@RequestBody PostReviewDTO postReviewDTO) {
		try {
//			System.out.println(postReviewDTO.getOrderID());
//			System.out.println(postReviewDTO.getProductID());
//			System.out.println(postReviewDTO.getReviewContent());
//			System.out.println(postReviewDTO.getRate());
			// add review 
			reviewService.addReview(postReviewDTO);
			
			// recalculate rate in product table
			productService.updateRating(postReviewDTO.getProductID(), postReviewDTO.getRate());
			
			// update isReviewed in DetailedInvoice
			invoiceService.updateReviewStatus(postReviewDTO.getOrderID(), postReviewDTO.getProductID());
			
			
			
			return new ResponseEntity<String>("Add Successfully!", HttpStatus.CREATED);
		} catch(Exception e) {
			
			return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}

}
