package com.techshopbe.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.techshopbe.dto.DetailedInvoiceDTO;
import com.techshopbe.entity.DetailedInvoice;

@Repository
public interface DetailedInvoiceRepository extends JpaRepository<DetailedInvoice, Integer>{

	@Query("SELECT new com.techshopbe.dto.DetailedInvoiceDTO(p.productID, d.price, d.quantity, d.totalPrice, p.productName, d.isReviewed, p.images, c.categorySlug) FROM Product p, DetailedInvoice d, Category c WHERE p.productID = d.productID AND d.invoiceID = ?1 AND p.categoryID = c.categoryID")
	List<DetailedInvoiceDTO> findAllByInvoiceID(int invoiceID);
	
	@Transactional
	@Modifying
    @Query("UPDATE DetailedInvoice d SET d.isReviewed = true WHERE d.invoiceID = ?1 AND d.productID = ?2")
    int updateRatingInfoByProductID(int invoiceID, int productID);
	

}
