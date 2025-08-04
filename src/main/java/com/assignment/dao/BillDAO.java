package com.assignment.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.assignment.model.Bill;
import com.assignment.model.BillItem;

public class BillDAO {

		public void addBill(Bill bill) {
			// Match your exact table structure
			String query = "INSERT INTO bills (bill_id, account_number, bill_date, discount, total_amount) VALUES (?, ?, ?, ?, ?)";
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				System.out.println("=== Adding Bill Debug ===");
				System.out.println("Bill ID: " + bill.getBillId());
				System.out.println("Account Number: '" + bill.getAccountNo() + "'");
				System.out.println("Bill Date: " + bill.getBillDate());
				System.out.println("Discount: " + bill.getDiscount());
				System.out.println("Total Amount: " + bill.getTotalAmount());
				System.out.println("Query: " + query);

				conn = DBConnectionFactory.getConnection();

				// Customer exists, proceed with bill insertion
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, bill.getBillId());
				pstmt.setString(2, bill.getAccountNo());
				pstmt.setDate(3, bill.getBillDate());
				pstmt.setDouble(4, bill.getDiscount());
				pstmt.setDouble(5, bill.getTotalAmount());

				int rowsAffected = pstmt.executeUpdate();
				System.out.println("Bill inserted successfully. Rows affected: " + rowsAffected);

			} catch (SQLException e) {
				System.out.println("=== SQL Error in addBill ===");
				System.out.println("Error Code: " + e.getErrorCode());
				System.out.println("SQL State: " + e.getSQLState());
				System.out.println("Error Message: " + e.getMessage());
				e.printStackTrace();
				throw new RuntimeException("Failed to insert bill: " + e.getMessage());
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

		public void addBillItem(BillItem billItem) {
			String query = "INSERT INTO bill_items (bill_id, item_id, quantity) VALUES (?, ?, ?)";
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = DBConnectionFactory.getConnection();
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, billItem.getBillId());
				pstmt.setString(2, billItem.getItemId());
				pstmt.setInt(3, billItem.getQuantity());

				int rowsAffected = pstmt.executeUpdate();
				System.out.println("Bill item inserted. Rows affected: " + rowsAffected);

			} catch (SQLException e) {
				System.out.println("Error inserting bill item: " + e.getMessage());
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

		public void updateItemStock(String itemId, int quantity) {
			String query = "UPDATE items SET stock_quantity = stock_quantity - ? WHERE item_id = ?";
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = DBConnectionFactory.getConnection();
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, quantity);
				pstmt.setString(2, itemId);
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

		public Bill getBillById(String billId) throws SQLException {
			Bill bill = null;
			String query = "SELECT * FROM bills WHERE bill_id = ?";
			Connection connection = null;
			PreparedStatement pstmt = null;
			ResultSet resultSet = null;
			try {
				connection = DBConnectionFactory.getConnection();
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, billId);
				resultSet = pstmt.executeQuery();
				if (resultSet.next()) {
					String accountNumber = resultSet.getString("account_number");
					Date billDate = resultSet.getDate("bill_date");
					double discount = resultSet.getDouble("discount");
					double totalAmount = resultSet.getDouble("total_amount");

					bill = new Bill(billId, accountNumber, billDate, discount, totalAmount);
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
			return bill;
		}

		public List<BillItem> getBillItems(String billId) throws SQLException {
			List<BillItem> billItems = new ArrayList<>();
			String query = "SELECT * FROM bill_items WHERE bill_id = ?";
			Connection connection = null;
			PreparedStatement pstmt = null;
			ResultSet resultSet = null;
			try {
				connection = DBConnectionFactory.getConnection();
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, billId);
				resultSet = pstmt.executeQuery();
				while (resultSet.next()) {
					int billItemId = resultSet.getInt("bill_item_id");
					String itemId = resultSet.getString("item_id");
					int quantity = resultSet.getInt("quantity");

					BillItem billItem = new BillItem(billItemId, billId, itemId, quantity);
					billItems.add(billItem);
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
			return billItems;
		}
		
		public List<Bill> getAllBills() throws SQLException {
		    List<Bill> bills = new ArrayList<>();
		    String query = "SELECT * FROM bills ORDER BY bill_date DESC";
		    Connection connection = null;
		    PreparedStatement pstmt = null;
		    ResultSet resultSet = null;
		    try {
		        connection = DBConnectionFactory.getConnection();
		        pstmt = connection.prepareStatement(query);
		        resultSet = pstmt.executeQuery();
		        
		        while (resultSet.next()) {
		            String billId = resultSet.getString("bill_id");
		            String accountNumber = resultSet.getString("account_number");
		            Date billDate = resultSet.getDate("bill_date");
		            double discount = resultSet.getDouble("discount");
		            double totalAmount = resultSet.getDouble("total_amount");

		            Bill bill = new Bill(billId, accountNumber, billDate, discount, totalAmount);
		            bills.add(bill);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		        throw e;
		    } finally {
		        // Same cleanup as your existing methods
		        try {
		            if (resultSet != null) resultSet.close();
		            if (pstmt != null) pstmt.close();
		            if (connection != null) connection.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		    return bills;
		}
	
		
		public void deleteBill(String billId) throws SQLException {
		    String query = "DELETE FROM bills WHERE bill_id = ?";
		    Connection connection = null;
		    PreparedStatement pstmt = null;
		    try {
		        connection = DBConnectionFactory.getConnection();
		        pstmt = connection.prepareStatement(query);
		        pstmt.setString(1, billId);
		        pstmt.executeUpdate();
		    } catch (SQLException e) {
		        e.printStackTrace();
		        throw e;
		    } finally {
		        try {
		            if (pstmt != null) pstmt.close();
		            if (connection != null) connection.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		}
		
		public int getBillCount() throws SQLException {
		    String query = "SELECT COUNT(*) FROM bills";
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

