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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null || action.equals("list")) {
            ViewItems(request, response);
        } else if (action.equals("addItem")) {
            request.getRequestDispatcher("WEB-INF/View/AddItem.jsp").forward(request, response);
        } else if (action.equals("editItem")) {
            showEditItem(request, response);
        } else if (action.equals("deleteItem")) {
            deleteItem(request, response);
        } else {
            response.sendRedirect("ItemController?action=list");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action.equals("addItem")) {
            addItem(request, response);
        } else if (action.equals("updateItem")) {
            updateItem(request, response);
        } else {
            response.sendRedirect("ItemController?action=list");
        }
    }

    private void ViewItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> ItemList = new ArrayList<Item>();
        try {
            ItemList = itemService.ViewItems();
            request.setAttribute("items", ItemList);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading items: " + e.getMessage());
        }
        request.getRequestDispatcher("WEB-INF/View/ViewItems.jsp").forward(request, response);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String item_Id = request.getParameter("item_id");
        String itemName = request.getParameter("item_name");
        String description = request.getParameter("description");
        double unitPrice = Double.parseDouble(request.getParameter("unit_price"));
        String category = request.getParameter("category");
        int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));
        
        Item item = new Item();
        item.setItem_Id(item_Id);
        item.setItemName(itemName);
        item.setDescription(description);
        item.setUnit_Price(unitPrice);
        item.setCategory(category);
        item.setStockQuantity(stockQuantity);
        
        itemService.addItem(item);
        response.sendRedirect("ItemController?action=list");
    }

    private void showEditItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("id");
        
        try {
            Item item = itemService.getItemById(itemId);
            if (item != null) {
                request.setAttribute("item", item);
                request.getRequestDispatcher("WEB-INF/View/EditItem.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Item not found");
                response.sendRedirect("ItemController?action=list");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading item: " + e.getMessage());
            response.sendRedirect("ItemController?action=list");
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String item_Id = request.getParameter("item_id");
        String itemName = request.getParameter("item_name");
        String description = request.getParameter("description");
        double unitPrice = Double.parseDouble(request.getParameter("unit_price"));
        String category = request.getParameter("category");
        int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));
        
        Item item = new Item();
        item.setItem_Id(item_Id);
        item.setItemName(itemName);
        item.setDescription(description);
        item.setUnit_Price(unitPrice);
        item.setCategory(category);
        item.setStockQuantity(stockQuantity);
        
        boolean success = itemService.updateItem(item);
		if (success) {
		    response.sendRedirect("ItemController?action=list");
		} else {
		    request.setAttribute("errorMessage", "Failed to update item");
		    request.setAttribute("item", item);
		    request.getRequestDispatcher("WEB-INF/View/EditItem.jsp").forward(request, response);
		}
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("id");
        
        boolean success = itemService.deleteItem(itemId);
		if (!success) {
		    request.setAttribute("errorMessage", "Failed to delete item");
		}
        
        response.sendRedirect("ItemController?action=list");
    }

}

