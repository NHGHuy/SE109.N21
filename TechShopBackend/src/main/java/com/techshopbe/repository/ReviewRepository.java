package com.techshopbe.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.techshopbe.dto.ReviewDTO;
import com.techshopbe.entity.Review;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer>  {
	
	@Query("SELECT new com.techshopbe.dto.ReviewDTO(r.reviewID, r.productID, u.fullname, r.reviewDate, r.reviewContent, r.rate) FROM Review r, Product p, User u WHERE r.productID = p.productID AND r.userID = u.userID AND r.productID = ?1 ORDER BY r.reviewDate DESC")
	public List<ReviewDTO> getAllByProductID(int productID, Pageable page);

}
