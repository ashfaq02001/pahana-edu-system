package com.assignment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.assignment.model.Item;

public class ItemDAO {

	public void addItem(Item item) {
		String query = "INSERT INTO items (item_name, description, price, stock_quantity) VALUES (?, ?, ?,?)";
		
		try {
			Connection conn = DBConnectionFactory.getConnection();
			PreparedStatement statement = conn.prepareStatement(query);
			statement.setString(1, item.getItemName());
			statement.setString(2, item.getDescription());
			statement.setDouble(3, item.getPrice());
			statement.setInt(4, item.getStockQuantity());
			statement.executeUpdate();
		}
		catch (SQLException e){
			e.printStackTrace();
		}
	}
	
	
}
