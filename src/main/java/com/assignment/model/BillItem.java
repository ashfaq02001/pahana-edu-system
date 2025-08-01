package com.assignment.model;

public class BillItem {

	private int billItemId;
    private String billId;
    private String itemId;
    private int quantity;
    
    public BillItem(){
    	
    }
	
    public BillItem(int billItemId, String billId, String itemId, int quantity) {
		super();
		this.billItemId = billItemId;
		this.billId = billId;
		this.itemId = itemId;
		this.quantity = quantity;
	}

	public int getBillItemId() {
		return billItemId;
	}

	public void setBillItemId(int billItemId) {
		this.billItemId = billItemId;
	}

	public String getBillId() {
		return billId;
	}

	public void setBillId(String billId) {
		this.billId = billId;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
