package com.assignment.service;

import com.assignment.dao.ItemDAO;
import com.assignment.model.Item;


public class ItemService {

	private static ItemService instance;
	private ItemDAO itemDAO;
	
	private ItemService() {
		this.itemDAO = new ItemDAO();
	}
	
	public static ItemService getInstance() {
		if (instance == null) {
			synchronized (ItemService.class) {
				if(instance == null) {
					instance = new ItemService();
				}
			}
		}
		return instance;
	}
	
	public void addItem (Item item) {
		itemDAO.addItem(item);
	}
	
	
	
	
	
	
	
}
