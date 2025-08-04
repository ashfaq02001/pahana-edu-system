package com.assignment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.assignment.model.Customer;


public class CustomerDAO {

	public void addCustomer(Customer customer) {
		String query = "INSERT INTO customers (account_number, name, address, telephone, email, registration_date) VALUES (?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnectionFactory.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, customer.getAccountNumber());
			pstmt.setString(2, customer.getName());
			pstmt.setString(3, customer.getAddress());
			pstmt.setString(4, customer.getTelephone());
			pstmt.setString(5, customer.getEmail());
			pstmt.setTimestamp(6, customer.getRegistrationDate());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public List<Customer> ViewAccountDetails() throws SQLException {
		List<Customer> customers = new ArrayList<>();
		String query = "SELECT * FROM customers";
		Connection connection = null;
		Statement stmt = null;
		ResultSet resultSet = null;
		try {
			connection = DBConnectionFactory.getConnection();
			stmt = connection.createStatement();
			resultSet = stmt.executeQuery(query);
			while (resultSet.next()) {
				String account_no = resultSet.getString("account_number"); 
				String name = resultSet.getString("name");
				String address = resultSet.getString("address");
				String telephone = resultSet.getString("telephone");
				String email = resultSet.getString("email");
				Timestamp registration_date = resultSet.getTimestamp("registration_date");
				// Create and add to list
				Customer customer = new Customer(account_no, name, address, telephone, email, registration_date);
				customers.add(customer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (stmt != null)
					stmt.close();
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return customers;
	}
	
	
	public Customer getCustomerByAccountNumber(String accountNumber) throws SQLException {
		Customer customer = null;
		String query = "SELECT * FROM customers WHERE account_number = ?";
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet resultSet = null;
		try {
			connection = DBConnectionFactory.getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, accountNumber);
			resultSet = pstmt.executeQuery();
			if (resultSet.next()) {
				String account_no = resultSet.getString("account_number");
				String name = resultSet.getString("name");
				String address = resultSet.getString("address");
				String telephone = resultSet.getString("telephone");
				String email = resultSet.getString("email");
				Timestamp registration_date = resultSet.getTimestamp("registration_date");
				customer = new Customer(account_no, name, address, telephone, email, registration_date);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (pstmt != null)
					pstmt.close();
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return customer;
	}
	
	public void updateCustomer(Customer customer) {
		String query = "UPDATE customers SET name = ?, address = ?, telephone = ?, email = ? WHERE account_number = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnectionFactory.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, customer.getName());
			pstmt.setString(2, customer.getAddress());
			pstmt.setString(3, customer.getTelephone());
			pstmt.setString(4, customer.getEmail());
			pstmt.setString(5, customer.getAccountNumber());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void deleteCustomer(String accountNumber) {
		String query = "DELETE FROM customers WHERE account_number = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnectionFactory.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, accountNumber);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public int getCustomerCount() throws SQLException {
	    String query = "SELECT COUNT(*) FROM customers";
	    Connection connection = null;
	    PreparedStatement pstmt = null;
	    ResultSet resultSet = null;
	    try {
	        connection = DBConnectionFactory.getConnection();
	        pstmt = connection.prepareStatement(query);
	        resultSet = pstmt.executeQuery();
	        if (resultSet.next()) {
	            return resultSet.getInt(1);
	        }
	        return 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        // Cleanup code like your existing methods
	        try {
	            if (resultSet != null) resultSet.close();
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

}
