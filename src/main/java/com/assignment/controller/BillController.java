package com.assignment.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.assignment.model.Bill;
import com.assignment.model.BillItem;
import com.assignment.model.Customer;
import com.assignment.model.Item;
import com.assignment.service.BillService;
import com.assignment.service.CustomerService;
import com.assignment.service.ItemService;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

/**
 * Servlet implementation class BillController
 */
public class BillController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BillService billService;
	private CustomerService customerService;
	private ItemService itemService;

	public void init() throws ServletException {
		billService = BillService.getInstance();
		customerService = CustomerService.getInstance();
		itemService = ItemService.getInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String action = request.getParameter("action");
        if (action == null || action.equals("dashboard")) {
            showBillingDashboard(request, response);
        } else if (action.equals("printReceipt")) {
            printReceipt(request, response);    
        } else if (action.equals("viewBills")) {
        	viewBills(request, response);
        } else if (action.equals("deleteBill")) {
        	deleteBill(request, response);
        }
        else {
            response.sendRedirect("BillController?action=dashboard");
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action.equals("generateBill")) {
			generateBill(request, response);
		}
	}
	

	private void showBillingDashboard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Customer> customers = customerService.ViewAccountDetails();
			List<Item> items = itemService.ViewItems();

			request.setAttribute("customers", customers);
			request.setAttribute("items", items);
			request.getRequestDispatcher("WEB-INF/View/BillingDashboard.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}
	
	
	private void viewBills(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        List<Bill> bills = billService.getAllBills(); // You need to add this to service
	        List<Customer> customers = customerService.ViewAccountDetails();
	        
	        request.setAttribute("bills", bills);
	        request.setAttribute("customers", customers);
	        request.getRequestDispatcher("WEB-INF/View/ViewBills.jsp").forward(request, response);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.sendRedirect("BillController?action=dashboard&error=true");
	    }
	}

	private void generateBill(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accountNo = request.getParameter("customer");
		String[] itemIds = request.getParameterValues("itemId");
		String[] quantities = request.getParameterValues("quantity");
		String discountStr = request.getParameter("discount");

		System.out.println("=== Generate Bill Debug ===");
		System.out.println("Account No from form: '" + accountNo + "'");
		System.out.println("Account No length: " + (accountNo != null ? accountNo.length() : "null"));
		System.out.println("Discount: " + discountStr);

		// Check if customer exists
		try {
			Customer customer = customerService.getCustomerByAccountNumber(accountNo);
			if (customer == null) {
				System.out.println("ERROR: Customer not found for account: " + accountNo);
				response.sendRedirect("BillController?action=dashboard&error=customer_not_found");
				return;
			} else {
				System.out.println("Customer found: " + customer.getName());
			}
		} catch (SQLException e) {
			System.out.println("Error checking customer: " + e.getMessage());
			response.sendRedirect("BillController?action=dashboard&error=customer_check_failed");
			return;
		}

		if (itemIds != null) {
			System.out.println("Number of items: " + itemIds.length);
			for (int i = 0; i < itemIds.length; i++) {
				System.out.println("Item " + i + ": ID=" + itemIds[i] + ", Qty="
						+ (quantities != null && i < quantities.length ? quantities[i] : "null"));
			}
		} else {
			System.out.println("No items received");
		}

		// Generate Bill ID
		String billId = "BILL/" + System.currentTimeMillis();
		System.out.println("Generated Bill ID: " + billId);

		try {
			// Get all items for price lookup
			List<Item> allItems = itemService.ViewItems();

			// Calculate totals
			double subTotal = 0;

			// Process each selected item
			if (itemIds != null && quantities != null) {
				for (int i = 0; i < itemIds.length; i++) {
					if (itemIds[i] != null && !itemIds[i].isEmpty() && quantities[i] != null && !quantities[i].isEmpty()
							&& Integer.parseInt(quantities[i]) > 0) {

						String itemId = itemIds[i];
						int quantity = Integer.parseInt(quantities[i]);

						System.out.println("Processing item: " + itemId + " with quantity: " + quantity);

						// Find item price
						double unitPrice = 0;
						for (Item item : allItems) {
							if (item.getItem_Id().equals(itemId)) {
								unitPrice = item.getUnit_Price();
								break;
							}
						}

						System.out.println("Unit price found: " + unitPrice);

						double totalPrice = quantity * unitPrice;
						subTotal += totalPrice;

						// Save bill item
						BillItem billItem = new BillItem();
						billItem.setBillId(billId);
						billItem.setItemId(itemId);
						billItem.setQuantity(quantity);

						System.out.println("Adding bill item: " + billId + ", " + itemId + ", " + quantity);
						billService.addBillItem(billItem);

						// Update stock
						billService.updateItemStock(itemId, quantity);
					}
				}
			}

			// Calculate discount and total
			double discount = Double.parseDouble(discountStr != null ? discountStr : "0");
			double discountAmount = (subTotal * discount) / 100;
			double totalAmount = subTotal - discountAmount;

			System.out.println("Subtotal: " + subTotal + ", Total: " + totalAmount);

			// Create and save bill
			Bill bill = new Bill();
			bill.setBillId(billId);
			bill.setAccountNo(accountNo); // Use setAccountNumber instead of setAccountNo
			bill.setBillDate(new Date(System.currentTimeMillis()));
			bill.setDiscount(discount);
			bill.setTotalAmount(totalAmount);

			System.out.println("Saving bill with account number: '" + accountNo + "'");
			billService.addBill(bill);

			// Store bill data in session to preserve form
			request.getSession().setAttribute("lastBillId", billId);
			request.getSession().setAttribute("lastCustomer", accountNo);
			request.getSession().setAttribute("lastDiscount", discount);
			request.getSession().setAttribute("lastTotal", totalAmount);

			// Redirect back to dashboard with success message (preserving the form data)
			response.sendRedirect("BillController?action=dashboard&success=true&billId=" + billId);

		} catch (Exception e) {
			System.out.println("Error in generateBill: " + e.getMessage());
			e.printStackTrace();
			response.sendRedirect("BillController?action=dashboard&error=true");
		}
	}
	
	private void deleteBill(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
		
	    String billId = request.getParameter("billId");
	    try {
	        billService.deleteBill(billId);
	        response.sendRedirect("BillController?action=viewBills&success=deleted");
	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.sendRedirect("BillController?action=viewBills&error=delete_failed");
	    }
	}

	private void printReceipt(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String billId = request.getParameter("billId");

		try {
			Bill bill = billService.getBillById(billId);
			List<BillItem> billItems = billService.getBillItems(billId);
			Customer customer = customerService.getCustomerByAccountNumber(bill.getAccountNo());
			List<Item> allItems = itemService.ViewItems();

			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename=\"receipt_" + billId + ".pdf\"");

			Document document = new Document();
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			PdfWriter.getInstance(document, baos);
			document.open();

			// Shop Header
			Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
			Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 10);
			Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);

			Paragraph title = new Paragraph("PAHANA EDU Book Shop", titleFont);
			title.setAlignment(Element.ALIGN_CENTER);
			document.add(title);

			Paragraph address = new Paragraph("No, 123 Galle Road, Colombo 03, Sri Lanka", normalFont);
			address.setAlignment(Element.ALIGN_CENTER);
			document.add(address);

			Paragraph contact = new Paragraph("Tel: +94 77 12 34567 | Email: info@pahana.edu.lk", normalFont);
			contact.setAlignment(Element.ALIGN_CENTER);
			document.add(contact);

			document.add(new Paragraph(" "));

			// Receipt Title
			Paragraph receiptTitle = new Paragraph("SALES Bill", boldFont);
			receiptTitle.setAlignment(Element.ALIGN_CENTER);
			document.add(receiptTitle);

			document.add(new Paragraph(" "));

			// Bill Info
			PdfPTable infoTable = new PdfPTable(2);
			infoTable.setWidthPercentage(100);

			infoTable.addCell(new PdfPCell(new Phrase("Receipt No:", boldFont)));
			infoTable.addCell(new PdfPCell(new Phrase(bill.getBillId(), normalFont)));
			infoTable.addCell(new PdfPCell(new Phrase("Date:", boldFont)));
			infoTable.addCell(new PdfPCell(new Phrase(bill.getBillDate().toString(), normalFont)));
			infoTable.addCell(new PdfPCell(new Phrase("Customer:", boldFont)));
			infoTable.addCell(new PdfPCell(new Phrase(customer.getName(), normalFont)));
			infoTable.addCell(new PdfPCell(new Phrase("Account No:", boldFont)));
			infoTable.addCell(new PdfPCell(new Phrase(customer.getAccountNumber(), normalFont)));

			document.add(infoTable);
			document.add(new Paragraph(" "));

			// Items Table
			PdfPTable itemsTable = new PdfPTable(4);
			itemsTable.setWidthPercentage(100);
			itemsTable.setWidths(new float[] { 3, 1, 1.5f, 1.5f });

			// Headers
			itemsTable.addCell(new PdfPCell(new Phrase("Item", boldFont)));
			itemsTable.addCell(new PdfPCell(new Phrase("Qty", boldFont)));
			itemsTable.addCell(new PdfPCell(new Phrase("Price", boldFont)));
			itemsTable.addCell(new PdfPCell(new Phrase("Total", boldFont)));

			// Items
			double subTotal = 0;
			for (BillItem item : billItems) {
				String itemName = "";
				double unitPrice = 0;
				for (Item allItem : allItems) {
					if (allItem.getItem_Id().equals(item.getItemId())) {
						itemName = allItem.getItemName();
						unitPrice = allItem.getUnit_Price();
						break;
					}
				}
				double lineTotal = item.getQuantity() * unitPrice;
				subTotal += lineTotal;

				itemsTable.addCell(new PdfPCell(new Phrase(itemName, normalFont)));
				itemsTable.addCell(new PdfPCell(new Phrase(String.valueOf(item.getQuantity()), normalFont)));
				itemsTable.addCell(new PdfPCell(new Phrase("$" + String.format("%.2f", unitPrice), normalFont)));
				itemsTable.addCell(new PdfPCell(new Phrase("$" + String.format("%.2f", lineTotal), normalFont)));
			}

			document.add(itemsTable);
			document.add(new Paragraph(" "));

			// Summary
			PdfPTable summaryTable = new PdfPTable(2);
			summaryTable.setWidthPercentage(50);
			summaryTable.setHorizontalAlignment(Element.ALIGN_RIGHT);

			summaryTable.addCell(new PdfPCell(new Phrase("Subtotal:", boldFont)));
			summaryTable.addCell(new PdfPCell(new Phrase("Rs. " + String.format("%.2f", subTotal), normalFont)));

			double discountAmount = (subTotal * bill.getDiscount()) / 100;
			summaryTable.addCell(new PdfPCell(new Phrase("Discount (" + bill.getDiscount() + "%):", boldFont)));
			summaryTable.addCell(new PdfPCell(new Phrase("Rs. " + String.format("%.2f", discountAmount), normalFont)));

			summaryTable.addCell(new PdfPCell(new Phrase("TOTAL:", boldFont)));
			summaryTable
					.addCell(new PdfPCell(new Phrase("Rs. " + String.format("%.2f", bill.getTotalAmount()), boldFont)));

			document.add(summaryTable);

			// Footer
			document.add(new Paragraph(" "));
			Paragraph thanks = new Paragraph("Thank you for your business!", boldFont);
			thanks.setAlignment(Element.ALIGN_CENTER);
			document.add(thanks);

			document.close();

			byte[] pdfBytes = baos.toByteArray();
			response.setContentLength(pdfBytes.length);
			response.getOutputStream().write(pdfBytes);
			response.getOutputStream().flush();

		} catch (SQLException | DocumentException e) {
			e.printStackTrace();
			response.sendRedirect("BillController?action=dashboard");
		}
	}
}
