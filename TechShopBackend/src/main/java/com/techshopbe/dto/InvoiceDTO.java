package com.techshopbe.dto;

import java.util.List;

// hoa don
public class InvoiceDTO {
	List<DetailedInvoiceDTO> detailedInvoices;
	ShippingInfoDTO shippingInfo;

	private String email;

	private int totalPrice;

	private String note;
	private String statusInvoice;
	
	private String shippingDate;
	private String invoiceDate;
	

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getShippingDate() {
		return shippingDate;
	}

	public void setShippingDate(String shippingDate) {
		this.shippingDate = shippingDate;
	}

	public InvoiceDTO() {

	}

	public String getStatusInvoice() {
		return statusInvoice;
	}

	public void setStatusInvoice(String statusInvoice) {
		this.statusInvoice = statusInvoice;
	}

	public ShippingInfoDTO getShippingInfo() {
		return shippingInfo;
	}

	public void setShippingInfo(ShippingInfoDTO shippingInfo) {
		this.shippingInfo = shippingInfo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public List<DetailedInvoiceDTO> getDetailedInvoices() {
		return detailedInvoices;
	}

	public void setDetailedInvoices(List<DetailedInvoiceDTO> detailedInvoices) {
		this.detailedInvoices = detailedInvoices;
	}

	public InvoiceDTO(List<DetailedInvoiceDTO> detailedInvoices, ShippingInfoDTO shippingInfo, String email,
			int totalPrice, String note, String statusInvoice, String shippingDate, String invoiceDate) {
		super();
		this.detailedInvoices = detailedInvoices;
		this.shippingInfo = shippingInfo;
		this.email = email;
		this.totalPrice = totalPrice;
		this.note = note;
		this.statusInvoice = statusInvoice;
		this.shippingDate = shippingDate;
		this.invoiceDate = invoiceDate;
	}

	
	

}
