package com.assignment.DAOTest;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.junit.jupiter.api.Test;

import com.assignment.dao.CustomerDAO;
import com.assignment.model.Customer;

public class CustomerDAOTest {

//    @Test
//    public void testViewAccountDetails() throws SQLException {
//        // Test that ViewAccountDetails returns a non-null list
//        CustomerDAO customerDAO = new CustomerDAO();
//        List<Customer> customers = customerDAO.ViewAccountDetails();
//        assertNotNull("The customers list should not be null", customers);
//    }

//    @Test
//    public void testAddCustomer() {
//        // Test that addCustomer method executes without throwing exception
//        CustomerDAO customerDAO = new CustomerDAO();
//        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
//        Customer testCustomer = new Customer("ACC001", "Test Customer", "Test Address", "1234567890", "test@email.com", currentTime);
//        
//        try {
//            customerDAO.addCustomer(testCustomer);
//            assertTrue("addCustomer should execute without exception", true);
//        } catch (Exception e) {
//            assertFalse("addCustomer should not throw exception", true);
//        }
//    }

//    @Test
//    public void testGetCustomerByAccountNumber() throws SQLException {
//        // Test getCustomerByAccountNumber with a potentially existing account number
//        CustomerDAO customerDAO = new CustomerDAO();
//        Customer customer = customerDAO.getCustomerByAccountNumber("ACC001");
//        // Customer can be null if not found, or not null if found - both are valid
//        assertTrue("getCustomerByAccountNumber should execute without exception", customer == null || customer != null);
//    }
//
    //@Test
//    public void testUpdateCustomer() {
//        // Test that updateCustomer method executes without throwing exception
//        CustomerDAO customerDAO = new CustomerDAO();
//        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
//        Customer testCustomer = new Customer("ACC001", "Updated Customer", "Updated Address", "9876543210", "updated@email.com", currentTime);
//        
//        try {
//            customerDAO.updateCustomer(testCustomer);
//            assertTrue("updateCustomer should execute without exception", true);
//        } catch (Exception e) {
//            assertFalse("updateCustomer should not throw exception", true);
//        }
//    }
//
    @Test
    public void testDeleteCustomer() {
        // Test that deleteCustomer method executes without throwing exception
        CustomerDAO customerDAO = new CustomerDAO();
        
        try {
            customerDAO.deleteCustomer("ACC001");
            assertTrue("deleteCustomer should execute without exception", true);
        } catch (Exception e) {
            assertFalse("deleteCustomer should not throw exception", true);
        }
    }

}