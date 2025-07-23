package com.assignment.model;

public class Item {

	private String itemName;
	private String description;
	private double price;
	private int stockQuantity;
	
	public Item(String itemName, String description, double price, int stockQuantity) {
		super();
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.stockQuantity = stockQuantity;
	}

	public Item() {
		// TODO Auto-generated constructor stub
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

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getStockQuantity() {
		return stockQuantity;
	}

	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
}



