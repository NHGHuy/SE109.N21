package com.techshopbe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.techshopbe.dto.InvoiceDTO;
import com.techshopbe.entity.Invoice;
import com.techshopbe.service.InvoiceService;

@RestController
@RequestMapping("api/v1/invoice")

public class InvoiceController {
	@Autowired
	InvoiceService invoiceService;
	
	@PostMapping(value = "")
	public Object add(@RequestBody String invoice) {
		try {
			invoiceService.add(invoice);
			return new ResponseEntity<String>("Order Successfully!", HttpStatus.CREATED);
		} catch(Exception e) {
			
			return new ResponseEntity<String>("Order Failed", HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping(value = "/user")
	public Object getAllUserInvoices() {
		
		try {
			List<Invoice> userInvoices = invoiceService.getAllUserInvoices();
			return new ResponseEntity<List<Invoice>>(userInvoices, HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<String>("Failed", HttpStatus.BAD_REQUEST);
		}
	}
	@GetMapping(value = "/{invoiceID}")
	public Object getByInvoiceID(@PathVariable int invoiceID) {
		
		try {
			InvoiceDTO invoice = invoiceService.getByInvoiceID(invoiceID);
			return new ResponseEntity<InvoiceDTO>(invoice, HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<String>("Failed", HttpStatus.BAD_REQUEST);
		}
	}
	

}
