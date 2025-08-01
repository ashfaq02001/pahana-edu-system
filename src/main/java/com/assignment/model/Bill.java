package com.assignment.model;

import java.sql.Date;

public class Bill {

	private String billId;
    private String accountNo;
    private Date billDate;
    private double discount;
    private double totalAmount;
    
    public Bill() {
    	
    }
	
    public Bill(String billId, String accountNo, Date billDate, double discount, double totalAmount) {
		super();
		this.billId = billId;
		this.accountNo = accountNo;
		this.billDate = billDate;
		this.discount = discount;
		this.totalAmount = totalAmount;
	}

	public String getBillId() {
		return billId;
	}

	public void setBillId(String billId) {
		this.billId = billId;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public Date getBillDate() {
		return billDate;
	}

	public void setBillDate(Date billDate) {
		this.billDate = billDate;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	
}
