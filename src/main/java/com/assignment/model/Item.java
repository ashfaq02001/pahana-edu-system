package com.assignment.model;

import java.sql.Timestamp;

public class Item {

	private String item_Id;
	private String itemName;
	private String description;
	private double unit_Price;
	private String category;
	private int stockQuantity;
	private Timestamp createdAt;
    

	public Item() {
		
	}


	public Item(String item_Id, String itemName, String description, double unit_Price, String category, int stockQuantity,
			Timestamp createdAt) {
		super();
		this.item_Id = item_Id;
		this.itemName = itemName;
		this.description = description;
		this.unit_Price = unit_Price;
		this.category = category;
		this.stockQuantity = stockQuantity;
		this.createdAt = createdAt;
	}


	public String getItem_Id() {
		return item_Id;
	}


	public void setItem_Id(String item_Id) {
		this.item_Id = item_Id;
	}


	public String getItemName() {
		return itemName;
	}


	public void setItemName(String itemName) {
		this.itemName = itemName;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public double getUnit_Price() {
		return unit_Price;
	}


	public void setUnit_Price(double unit_Price) {
		this.unit_Price = unit_Price;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public int getStockQuantity() {
		return stockQuantity;
	}


	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}


	public Timestamp getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	
}



