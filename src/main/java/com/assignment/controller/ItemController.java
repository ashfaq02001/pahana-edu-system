package com.assignment.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
		
		String action = request.getParameter("action");
		if (action == null || action.equals("list")) {
	        ViewItems(request, response);
	    } else if (action.equals("addItem")) {
	        request.getRequestDispatcher("WEB-INF/View/AddItem.jsp").forward(request, response);
	    } else {
	        response.sendRedirect("ItemController?action=list");
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action.equals("addItem")) {
			addItem(request, response);
		}
	}

	private void ViewItems(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Item> ItemList = new ArrayList<Item>();
		try {
			ItemList = itemService.ViewItems();
			request.setAttribute("items", ItemList);
		} catch (SQLException e) {
			return;
		}

		request.getRequestDispatcher("WEB-INF/View/ViewItems.jsp").forward(request, response);

	}

	private void addItem(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String itemName = request.getParameter("item_name");
		String description = request.getParameter("description");
		double price = Double.parseDouble(request.getParameter("price"));
		int stock_quantity = Integer.parseInt(request.getParameter("stock_quantity"));

		Item item = new Item();

		item.setItemName(itemName);
		item.setDescription(description);
		item.setPrice(price);
		item.setStockQuantity(stock_quantity);

		itemService.addItem(item);
		response.sendRedirect("ItemController?action=list");
	}

}
