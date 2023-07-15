package com.techshopbe.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.techshopbe.dto.ShippingInfoDTO;
import com.techshopbe.entity.ShippingInfo;

@Repository
public interface ShippingInfoRepository extends JpaRepository<ShippingInfo, Integer> {

	@Query("SELECT new com.techshopbe.dto.ShippingInfoDTO(s.fullname, s.phone, s.address) FROM ShippingInfo s WHERE s.invoiceID = ?1")
	ShippingInfoDTO findByInvoiceID(int invoiceID);
}
