package com.techshopbe.service;

import java.util.List;

import com.techshopbe.dto.InvoiceDTO;
import com.techshopbe.entity.Invoice;

public interface InvoiceService {
	public void add(String invoice);
	public List<Invoice> getAllUserInvoices();
	public InvoiceDTO getByInvoiceID(int invoiceID);
	public void updateReviewStatus(int invoiceID, int productID);

}
