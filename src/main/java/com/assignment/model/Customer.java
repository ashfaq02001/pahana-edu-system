package com.assignment.model;

import java.sql.Timestamp;

public class Customer {

	private String accountNumber;
	private String name;
	private String address;
	private String telephone;
	private String email;
	private Timestamp registrationDate;

	public Customer(String accountNumber, String name, String address, String telephone, String email,
			Timestamp registrationDate) {
		super();
		this.accountNumber = accountNumber;
		this.name = name;
		this.address = address;
		this.telephone = telephone;
		this.email = email;
		this.registrationDate = registrationDate;
	}
	
	public Customer() {
		
	}
	

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Timestamp registrationDate) {
		this.registrationDate = registrationDate;
	}

}
