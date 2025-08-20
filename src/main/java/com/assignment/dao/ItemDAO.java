package com.assignment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.assignment.model.Item;

public class ItemDAO {

	public void addItem(Item item) {
	    String query = "INSERT INTO items (item_id, item_name, description, unit_price, category, stock_quantity) VALUES (?, ?, ?, ?, ?, ?)";
	    
	    try (Connection conn = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        
	        pstmt.setString(1, item.getItem_Id());
	        pstmt.setString(2, item.getItemName());
	        pstmt.setString(3, item.getDescription());
	        pstmt.setDouble(4, item.getUnit_Price());
	        pstmt.setString(5, item.getCategory());
	        pstmt.setInt(6, item.getStockQuantity());
	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	public List<Item> ViewItems() throws SQLException {
	    List<Item> items = new ArrayList<>();
	    String query = "SELECT * FROM items";

	    try (Connection connection = DBConnectionFactory.getConnection();
	         Statement stmt = connection.createStatement();
	         ResultSet resultSet = stmt.executeQuery(query)) {

	        while (resultSet.next()) {
	            String item_id = resultSet.getString("item_id");
	            String item_name = resultSet.getString("item_name");
	            String description = resultSet.getString("description");
	            double unit_price = resultSet.getDouble("unit_price");
	            String category = resultSet.getString("category");
	            int stock_quantity = resultSet.getInt("stock_quantity");

	            // Create and add to list
	            Item item = new Item(item_id, item_name, description, unit_price, category, stock_quantity, null);
	            items.add(item);
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return items;
	}

	public Item getItemById(String itemId) throws SQLException {
	    String query = "SELECT * FROM items WHERE item_id = ?";

	    try (Connection conn = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        
	        pstmt.setString(1, itemId);
	        
	        try (ResultSet resultSet = pstmt.executeQuery()) {
	            if (resultSet.next()) {
	                String item_id = resultSet.getString("item_id");
	                String item_name = resultSet.getString("item_name");
	                String description = resultSet.getString("description");
	                double unit_price = resultSet.getDouble("unit_price");
	                String category = resultSet.getString("category");
	                int stock_quantity = resultSet.getInt("stock_quantity");

	                return new Item(item_id, item_name, description, unit_price, category, stock_quantity, null);
	            }
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return null;
	}

	public boolean updateItem(Item item) {
	    String query = "UPDATE items SET item_name = ?, description = ?, unit_price = ?, category = ?, stock_quantity = ? WHERE item_id = ?";

	    try (Connection conn = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        
	        pstmt.setString(1, item.getItemName());
	        pstmt.setString(2, item.getDescription());
	        pstmt.setDouble(3, item.getUnit_Price());
	        pstmt.setString(4, item.getCategory());
	        pstmt.setInt(5, item.getStockQuantity());
	        pstmt.setString(6, item.getItem_Id());

	        int rowsAffected = pstmt.executeUpdate();
	        return rowsAffected > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean deleteItem(String itemId) {
	    String query = "DELETE FROM items WHERE item_id = ?";

	    try (Connection conn = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        
	        pstmt.setString(1, itemId);
	        int rowsAffected = pstmt.executeUpdate();
	        return rowsAffected > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public int getItemCount() throws SQLException {
	    String query = "SELECT COUNT(*) FROM items";
	    
	    try (Connection connection = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = connection.prepareStatement(query);
	         ResultSet resultSet = pstmt.executeQuery()) {
	        
	        if (resultSet.next()) {
	            return resultSet.getInt(1);
	        }
	        return 0;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

}
