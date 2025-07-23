package com.assignment.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.assignment.service.ItemService;
import com.assignment.model.Item;

/**
 * Servlet implementation class ItemController
 */
public class ItemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ItemService itemService;
	
	public void init() throws ServletException {
		itemService = ItemService.getInstance();
	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action.equals("addItem")) {
			addItem(request, response);
		}
	}


	private void addItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String itemName =  request.getParameter("item_name");
		String description = request.getParameter("description");
		double price = Double.parseDouble(request.getParameter("price"));
		int stock_quantity = Integer.parseInt(request.getParameter("stock_quantity"));
		
		Item item = new Item();
		
		item.setItemName(itemName);
		item.setDescription(description);
		item.setPrice(price);
		item.setStockQuantity(stock_quantity);
		
		itemService.addItem(item);
		
		response.sendRedirect("AddItem.jsp");
		
	}
	
	
	

}
