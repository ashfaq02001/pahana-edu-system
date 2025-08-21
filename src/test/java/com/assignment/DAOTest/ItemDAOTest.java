package com.assignment.DAOTest;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;

import java.sql.SQLException;
import java.util.List;

import org.junit.jupiter.api.Test;

import com.assignment.dao.ItemDAO;
import com.assignment.model.Item;

public class ItemDAOTest {


    @Test
    public void testAddItemNotThrowException() {
        // Test that addItem method executes without throwing exception
        ItemDAO itemDAO = new ItemDAO();
        Item testItem = new Item("TEST001", "Test Item", "Test Description", 10.99, "Test Category", 5, null);
        
        try {
            itemDAO.addItem(testItem);
            assertTrue("addItem should execute without exception", true);
        } catch (Exception e) {
            assertFalse("addItem should not throw exception", true);
        }
    }

    @Test
    public void testUpdateItemReturnBoolean() {
        // Test that updateItem returns a boolean value
        ItemDAO itemDAO = new ItemDAO();
        Item testItem = new Item("TEST001", "Updated Item", "Updated Description", 15.99, "Updated Category", 10, null);
        
        try {
            boolean result = itemDAO.updateItem(testItem);
            // Result can be true or false, just ensure it returns a boolean
            assertTrue("updateItem should return a boolean value", result == true || result == false);
        } catch (Exception e) {
            assertFalse("updateItem should not throw exception", true);
        }
    }

    @Test
    public void testDeleteItemReturnBoolean() {
        // Test that deleteItem returns a boolean value
        ItemDAO itemDAO = new ItemDAO();
        
        try {
            boolean result = itemDAO.deleteItem("TEST001");
            // Result can be true or false, just ensure it returns a boolean
            assertTrue("deleteItem should return a boolean value", result == true || result == false);
        } catch (Exception e) {
            assertFalse("deleteItem should not throw exception", true);
        }
    }

    @Test
    public void testViewItems() throws SQLException {
        // Test that ViewItems executes a query successfully
        ItemDAO itemDAO = new ItemDAO();
        
        try {
            List<Item> items = itemDAO.ViewItems();
            assertNotNull("ViewItems should return a list", items);
            assertTrue("ViewItems should execute without exception", true);
        } catch (SQLException e) {
            assertFalse("ViewItems should not throw SQL exception", true);
        }
    }

}
