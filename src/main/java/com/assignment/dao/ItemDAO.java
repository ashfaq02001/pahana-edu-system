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
		String query = "INSERT INTO items (item_name, description, price, stock_quantity) VALUES (?, ?, ?,?)";

		try {
			Connection conn = DBConnectionFactory.getConnection();
			PreparedStatement statement = conn.prepareStatement(query);
			statement.setString(1, item.getItemName());
			statement.setString(2, item.getDescription());
			statement.setDouble(3, item.getPrice());
			statement.setInt(4, item.getStockQuantity());
			statement.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

	public List<Item> ViewItems() throws SQLException {
		List<Item> items = new ArrayList<>();
		String query = "SELECT * FROM items";

		Connection connection = DBConnectionFactory.getConnection();
		Statement stmt = connection.createStatement();
		ResultSet resultSet = stmt.executeQuery(query);

		while (resultSet.next()) {
			int item_id = resultSet.getInt("item_id");
			String item_name = resultSet.getString("item_name");
			String description = resultSet.getString("description");
			double price = resultSet.getDouble("price");
			int stock_quantity = resultSet.getInt("stock_quantity");

			// Create and add to list
			Item item = new Item(item_id, item_name, description, price, stock_quantity);
			items.add(item);
		}

		return items;
	}

}
