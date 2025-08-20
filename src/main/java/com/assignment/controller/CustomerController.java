package com.assignment.controller;

import java.io.IOException;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.assignment.model.Customer;

import com.assignment.service.CustomerService;

/**
 * Servlet implementation class CustomerController
 */
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CustomerService customerService;

	public void init() throws ServletException {
		customerService = CustomerService.getInstance();
	}
	
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String action = request.getParameter("action");
		
		if (action == null || action.equals("list")) {
			viewAccountDetails(request, response);
		} else if (action.equals("addCustomer")) {
			request.getRequestDispatcher("WEB-INF/View/AddCustomer.jsp").forward(request, response);
		} else if (action.equals("editCustomer")) {
			showEditForm(request, response);
		} else if (action.equals("deleteCustomer")) {
			deleteCustomer(request, response);
		} else {
			response.sendRedirect("CustomerController?action=list");
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action.equals("addCustomer")) {
			addCustomer(request, response);
		} else if (action.equals("updateCustomer")) {
			updateCustomer(request, response);
		}
	}

	private void addCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String account_no = request.getParameter("account_no");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String telephone = request.getParameter("telephone");
		String email = request.getParameter("email");
//		
		// Create current timestamp for registration date
		Timestamp registration_date = new Timestamp(System.currentTimeMillis());

		Customer customer = new Customer();
		customer.setAccountNumber(account_no);
		customer.setName(name);
		customer.setAddress(address);
		customer.setTelephone(telephone); // Fixed: was setPhone(phone)
		customer.setEmail(email); // Added missing email
		customer.setRegistrationDate(registration_date); // Added missing registration date
//
		customerService.addCustomer(customer);
		request.getSession().setAttribute("successMessage", "Customer added successfully!");
		response.sendRedirect("CustomerController?action=list"); // Redirect to list instead of AddCustomer.jsp
	}
	
	

	private void viewAccountDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Customer> AccountList = new ArrayList<Customer>();
		try {
			AccountList = customerService.ViewAccountDetails();
			request.setAttribute("account_list", AccountList);
		} catch (SQLException e) {
			e.printStackTrace(); // Added error handling
		}
		request.getRequestDispatcher("WEB-INF/View/ViewAccountDetails.jsp").forward(request, response);
	}
	
	private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String account_no = request.getParameter("account_no");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String telephone = request.getParameter("telephone");
		String email = request.getParameter("email");

		Customer customer = new Customer();
		customer.setAccountNumber(account_no);
		customer.setName(name);
		customer.setAddress(address);
		customer.setTelephone(telephone);
		customer.setEmail(email);

		customerService.updateCustomer(customer);
		response.sendRedirect("CustomerController?action=list");
	}
	
	private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accountNumber = request.getParameter("id");
		customerService.deleteCustomer(accountNumber);
		response.sendRedirect("CustomerController?action=list");
	}
	
	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accountNumber = request.getParameter("id");
		try {
			Customer customer = customerService.getCustomerByAccountNumber(accountNumber);
			request.setAttribute("customer", customer);
			request.getRequestDispatcher("WEB-INF/View/EditCustomer.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("CustomerController?action=list");
		}
	}
}


