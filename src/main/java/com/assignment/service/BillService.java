package com.assignment.service;

import java.sql.SQLException;
import java.util.List;

import com.assignment.dao.BillDAO;
import com.assignment.model.Bill;
import com.assignment.model.BillItem;

public class BillService {

	public static BillService instance;
	private BillDAO billDAO;
	
	private BillService() {
        billDAO = new BillDAO();
    }
	
	public static BillService getInstance() {
        if (instance == null) {
            instance = new BillService();
        }
        return instance;
    }
	
	public void addBill(Bill bill) {
        billDAO.addBill(bill);
    }
	
	public void addBillItem(BillItem billItem) {
        billDAO.addBillItem(billItem);
    }
    
    public void updateItemStock(String itemId, int quantity) {
        billDAO.updateItemStock(itemId, quantity);
    }
    
    public Bill getBillById(String billId) throws SQLException {
        return billDAO.getBillById(billId);
    }
    
    public List<BillItem> getBillItems(String billId) throws SQLException {
        return billDAO.getBillItems(billId);
    }
	
	
	
}
