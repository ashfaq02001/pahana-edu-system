package com.assignment.model;

public class Item {

	private int item_Id;
	private String itemName;
	private String description;
	private double price;
	private int stockQuantity;
	
	public Item(int item_Id, String itemName, String description, double price, int stockQuantity) {
		super();
		this.setItem_Id((item_Id));
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

	public static void add(Item item) {
		// TODO Auto-generated method stub
		
	}

	public int getItem_Id() {
		return item_Id;
	}

	public void setItem_Id(int item_Id) {
		this.item_Id = item_Id;
	}

	
}



