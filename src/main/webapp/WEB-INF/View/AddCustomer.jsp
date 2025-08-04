<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Customer Account - PAHANA Book Shop</title>
    <link rel="stylesheet" type="text/css" href="./CSS/add-customer.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>📚Add New Customer</h1>
            <p>PAHANA Book Shop - Customer Registration</p>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <!-- Info Box -->
            <div class="form-info">
                <p>💡<strong>Note:</strong> Account number is auto-generated. Please fill in all required fields marked with <span class="required">*</span></p>
            </div>

            <form action="CustomerController?addCustomer" method="post">
                <input type="hidden" name="action" value="addCustomer">

                <!-- Account Number -->
                <div class="form-group account-number-group">
                    <label for="account_no">Account Number <span class="required">*</span></label>
                    <input type="text" id="account_no" name="account_no" readonly required>
                    <span class="info-icon" title="Auto-generated account number">🔢</span>
                </div>

                <!-- Customer Name -->
                <div class="form-group">
                    <label for="name">Customer Name <span class="required">*</span></label>
                    <input type="text" id="name" name="name" placeholder="Enter full name" required>
                </div>

                <!-- Address -->
                <div class="form-group">
                    <label for="address">Address <span class="required">*</span></label>
                    <textarea id="address" name="address" rows="3" placeholder="Enter complete address" required></textarea>
                </div>

                <!-- Contact Information Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="telephone">Telephone <span class="required">*</span></label>
                        <input type="tel" id="telephone" name="telephone" placeholder="+94 XX XXX XXXX" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address <span class="required">*</span></label>
                        <input type="email" id="email" name="email" placeholder="example@email.com" required>
                    </div>
                </div>

                <!-- Button Group -->
                <div class="button-group">
                    <input type="submit" value="✅ Add Customer" class="btn btn-primary">
                    <input type="reset" value="🔄 Clear Form" class="btn btn-secondary">
                </div>
            </form>
        </div> 
    </div>

    <script>
        // Function to generate auto account number
        function generateAccountNumber() {
            // Get current date
            var today = new Date();
            var year = today.getFullYear().toString().substr(-2); // Last 2 digits of year
            var month = String(today.getMonth() + 1).padStart(2, '0'); // Month with leading zero

            // Generate random 4-digit number
            var randomNum = Math.floor(1000 + Math.random() * 9000);

            // Create account number format: PHN/YY/MM/XXXX
            var accountNumber = "PHN/" + year + "/" + month + "/" + randomNum;

            return accountNumber;
        }

        // Function to set account number when page loads
        window.onload = function() {
            document.getElementById("account_no").value = generateAccountNumber();
        }

        // Add form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const address = document.getElementById('address').value.trim();
            const telephone = document.getElementById('telephone').value.trim();
            const email = document.getElementById('email').value.trim();

            if (!name || !address || !telephone || !email) {
                e.preventDefault();
                alert('Please fill in all required fields.');
                return;
            }

            // Basic email validation
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address.');
                return;
            }

            // Basic phone validation
            const phonePattern = /^[+]?[\d\s\-()]+$/;
            if (!phonePattern.test(telephone)) {
                e.preventDefault();
                alert('Please enter a valid telephone number.');
                return;
            }
        });

        // Auto-format phone number
        document.getElementById('telephone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.startsWith('94')) {
                value = '+' + value;
            } else if (value.startsWith('0')) {
                value = '+94 ' + value.substring(1);
            }
            e.target.value = value;
        });
    </script>
</body>
</html>