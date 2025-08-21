package ModelTest;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;

import java.sql.Timestamp;

import org.junit.jupiter.api.Test;

import com.assignment.model.Customer;

public class CustomerModelTest {

    @Test
    public void testCustomerConstructorWithParameters() {
        // Test constructor with all parameters
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        Customer customer = new Customer("ACC001", "John Doe", "123 Main St", "1234567890", "john@email.com", currentTime);
        
        assertNotNull("Customer should not be null", customer);
        assertNotNull("Account number should not be null", customer.getAccountNumber());
        assertNotNull("Name should not be null", customer.getName());
        assertNotNull("Address should not be null", customer.getAddress());
        assertNotNull("Telephone should not be null", customer.getTelephone());
        assertNotNull("Email should not be null", customer.getEmail());
        assertNotNull("Registration date should not be null", customer.getRegistrationDate());
    }

    @Test
    public void testCustomerDefaultConstructor() {
        // Test default constructor
        Customer customer = new Customer();
        assertNotNull("Customer created with default constructor should not be null", customer);
    }

}