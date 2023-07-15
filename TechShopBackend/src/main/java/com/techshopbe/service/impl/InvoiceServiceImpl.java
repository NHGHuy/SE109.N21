package com.techshopbe.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.techshopbe.dto.DetailedInvoiceDTO;
import com.techshopbe.dto.InvoiceDTO;
import com.techshopbe.dto.ShippingInfoDTO;
import com.techshopbe.entity.DetailedInvoice;
import com.techshopbe.entity.Invoice;
import com.techshopbe.entity.ShippingInfo;
import com.techshopbe.repository.DetailedInvoiceRepository;
import com.techshopbe.repository.InvoiceRepository;
import com.techshopbe.repository.ProductRepository;
import com.techshopbe.repository.ShippingInfoRepository;
import com.techshopbe.repository.UserRepository;
import com.techshopbe.security.CustomUserDetails;
import com.techshopbe.service.InvoiceService;

@Service
public class InvoiceServiceImpl implements InvoiceService {

	@Autowired
	ProductRepository productRepository;
	@Autowired
	UserRepository userRepository;
	@Autowired
	InvoiceRepository invoiceRepository;
	@Autowired
	ShippingInfoRepository shippingInfoRepository;
	@Autowired
	DetailedInvoiceRepository detailedInvoiceRepository;

	@Override
	public void add(String invoice) {
		Gson g = new Gson();
		InvoiceDTO invoiceDTO = g.fromJson(invoice, InvoiceDTO.class);

		boolean otherShippingAddress = true;

		// set email
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();

		String email = userDetails.getUsername();
		invoiceDTO.setEmail(email);

		// set detailed invoice (calculate price and total price)
		invoiceDTO.setDetailedInvoices(getDetailedInvoices(invoiceDTO.getDetailedInvoices()));

		// set shipping info
		if (invoiceDTO.getShippingInfo() == null) {
			invoiceDTO.setShippingInfo(getShippingInfo(email));
			otherShippingAddress = false;
		}

		// set total price of invoice
		invoiceDTO.setTotalPrice(calculateTotalInvoiceCost(invoiceDTO.getDetailedInvoices()));

		/*
		 * Insert new invoice
		 */
		// INVOICE userID, totalCost, invoiceDate, shippingDate, note,
		// otherShippingAddress, statusInvoice
		// shipping Date: now + 10 ngày
		int userID = userDetails.getUserID();
		LocalDateTime invoiceDate = LocalDateTime.now();
		LocalDateTime shippingDate = invoiceDate.plusDays(3);

		// totalInvoices: lưu tổng số hoá đơn của người dùng
		// userInvoiceIndex: là key phân biệt các invoice (không lấy newest id)
		// (userInvoiceIndex = email + totalInvoices)
		int totalInvoices = userRepository.findTotalInvoicesByEmail(email);
		String userInvoiceIndex = email + String.valueOf(totalInvoices);

		Invoice invoiceEntity = new Invoice();
		invoiceEntity.setUserID(userID);
		invoiceEntity.setTotalCost(invoiceDTO.getTotalPrice());
		invoiceEntity.setInvoiceDate(invoiceDate.toString());
		invoiceEntity.setShippingDate(shippingDate.toString());
		invoiceEntity.setNote(invoiceDTO.getNote());
		invoiceEntity.setOtherShippingAddress(otherShippingAddress);
		invoiceEntity.setUserInvoiceIndex(userInvoiceIndex);

		invoiceEntity = invoiceRepository.save(invoiceEntity);
		// after insert invoice, increase totalInvoices of user
		userRepository.updateTotalInvoicesByEmail(totalInvoices + 1, email);

		/*
		 * Insert new shipping
		 */
		// get current invoice ID through userInvoiceIndex
		int invoiceID = invoiceRepository.findInvoiceIDByUserInvoiceIndex(userInvoiceIndex);

		// SHIPPINGINFO invoiceID, fullname, phone, address
		ShippingInfo shippingInfo = new ShippingInfo();
		shippingInfo.setInvoiceID(invoiceID);
		shippingInfo.setAddress(invoiceDTO.getShippingInfo().getAddress());
		shippingInfo.setFullname(invoiceDTO.getShippingInfo().getFullname());
		shippingInfo.setPhone(invoiceDTO.getShippingInfo().getPhone());
		shippingInfoRepository.save(shippingInfo);

		/*
		 * Insert new DETAILED INVOICE
		 */

		// DETAILEDINVOICE (invoiceID, productID, quantity, price)
		for (DetailedInvoiceDTO detailedInvoiceDTO : invoiceDTO.getDetailedInvoices()) {
			DetailedInvoice detailedInvoice = new DetailedInvoice();
			detailedInvoice.setInvoiceID(invoiceID);
			detailedInvoice.setPrice(detailedInvoiceDTO.getProductPrice());
			detailedInvoice.setProductID(detailedInvoiceDTO.getProductID());
			detailedInvoice.setQuantity(detailedInvoiceDTO.getQuantity());
			detailedInvoice.setTotalPrice(detailedInvoiceDTO.getTotalPrice());
			detailedInvoiceRepository.save(detailedInvoice);
		}

	}

	public List<DetailedInvoiceDTO> getDetailedInvoices(List<DetailedInvoiceDTO> detailedInvoices) {

		for (DetailedInvoiceDTO detailedInvoice : detailedInvoices) {
			// System.out.println(detailedInvoice.getProductID());
			int price = productRepository.findProductPriceByProductID(detailedInvoice.getProductID());

			int totalPrice = price * detailedInvoice.getQuantity();

			detailedInvoice.setProductPrice(price);
			detailedInvoice.setTotalPrice(totalPrice);
		}
		return detailedInvoices;
	}

	public ShippingInfoDTO getShippingInfo(String email) {
		return userRepository.findShippingInfoByEmail(email);
	}

	public int calculateTotalInvoiceCost(List<DetailedInvoiceDTO> detailedInvoices) {
		int totalInvoiceCost = 0;
		for (DetailedInvoiceDTO detailedInvoice : detailedInvoices) {
			totalInvoiceCost += detailedInvoice.getTotalPrice();
		}
		return totalInvoiceCost;

	}

	@Override
	public List<Invoice> getAllUserInvoices() {
		// TODO Auto-generated method stub
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();

		return invoiceRepository.findByUserID(userDetails.getUserID());
	}

	@Override
	public InvoiceDTO getByInvoiceID(int invoiceID) {
		List<DetailedInvoiceDTO> detailedInvoices = detailedInvoiceRepository.findAllByInvoiceID(invoiceID);
		ShippingInfoDTO shippingInfo = shippingInfoRepository.findByInvoiceID(invoiceID);
		Invoice invoice = invoiceRepository.findByInvoiceID(invoiceID);

		InvoiceDTO invoiceDTO = new InvoiceDTO();
		invoiceDTO.setDetailedInvoices(detailedInvoices);
		invoiceDTO.setNote(invoice.getNote());
		invoiceDTO.setShippingInfo(shippingInfo);
		invoiceDTO.setStatusInvoice(invoice.getStatusInvoice());
		invoiceDTO.setTotalPrice(invoice.getTotalCost());
		invoiceDTO.setShippingDate(invoice.getShippingDate());
		invoiceDTO.setInvoiceDate(invoice.getInvoiceDate());

		return invoiceDTO;
	}

	@Override
	public void updateReviewStatus(int invoiceID, int productID) {
		detailedInvoiceRepository.updateRatingInfoByProductID(invoiceID, productID);

	}

}
