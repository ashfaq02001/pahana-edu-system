package com.assignment.service;

import java.sql.SQLException;
import java.util.List;

import com.assignment.dao.CustomerDAO;
import com.assignment.model.Customer;


public class CustomerService {

	private static CustomerService instance;
	private CustomerDAO customerDAO;
	
	private CustomerService() {
		this.customerDAO = new CustomerDAO();
	}
	
	public static CustomerService getInstance() {
		if (instance == null) {
			synchronized (CustomerService.class) {
				if(instance == null) {
					instance = new CustomerService();
				}
			}
		}
		return instance;
	}
	
	public void addCustomer (Customer customer) {
		customerDAO.addCustomer(customer);
	}
	
	public List<Customer> ViewAccountDetails() throws SQLException {
		return customerDAO.ViewAccountDetails();
	}
	
	public Customer getCustomerByAccountNumber(String accountNumber) throws SQLException{
		return customerDAO.getCustomerByAccountNumber(accountNumber);
	}
	
	public void updateCustomer(Customer customer) {
		customerDAO.updateCustomer(customer);
	}
	
	public void deleteCustomer(String accountNumber) {
		customerDAO.deleteCustomer(accountNumber);
	}
	
	public int getCustomerCount() throws SQLException {
	    return customerDAO.getCustomerCount();
	}
}
