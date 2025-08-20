<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Check session in JSP
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("LoginController?action=login");
        return;
    }
    
    com.assignment.model.User currentUser = (com.assignment.model.User) session.getAttribute("user");
    
    // For admin-only pages, add this additional check:
    if (!"admin".equals(currentUser.getRole().toLowerCase())) {
        response.sendRedirect("BillController?action=dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Item</title>
<link rel="stylesheet" type="text/css" href="./CSS/add-item.css">
</head>
<body>
<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>📦 Add New Item</h1>
        <p>PAHANA Book Shop - Inventory Management</p>
    </div>

    <!-- Form Container -->
    <div class="form-container">
        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <p><strong>⚠️ Error:</strong> ${errorMessage}</p>
            </div>
        </c:if>

        <!-- Info Box -->
        <div class="form-info">
            <p>💡 <strong>Note:</strong> Item ID is auto-generated based on category selection. Please fill in all required fields marked with <span class="required">*</span></p>
        </div>

        <form action="ItemController?action=addItem" method="post" id="form">
            <!-- Item ID -->
            <div class="form-group account-number-group">
                <label for="item_id">Item ID <span class="required">*</span></label>
                <input type="text" name="item_id" id="item_id" readonly required>
                <span class="info-icon" title="Auto-generated based on category">🏷️</span>
            </div>

            <!-- Item Name -->
            <div class="form-group">
                <label for="item_name">Item Name <span class="required">*</span></label>
                <input type="text" name="item_name" id="item_name" placeholder="Enter item name" required>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label for="description">Description <span class="required">*</span></label>
                <textarea name="description" id="description" rows="3" placeholder="Enter item description" required></textarea>
            </div>

            <!-- Category -->
            <div class="form-group">
                <label for="category">Category <span class="required">*</span></label>
                <select name="category" id="category" required>
                    <option value="">Select Category</option>
                    <option value="Books">📚 Books</option>
                    <option value="Stationary">✏️ Stationary</option>
                    <option value="Other">📋 Other</option>
                </select>
            </div>

            <!-- Price and Stock Row -->
            <div class="form-row">
                <div class="form-group">
                    <label for="unit_price">Unit Price (Rs.) <span class="required">*</span></label>
                    <input type="number" name="unit_price" id="unit-price" placeholder="0.00" min="1" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="stock_quantity">Stock Quantity <span class="required">*</span></label>
                    <input type="number" name="stock_quantity" id="stock-quantity" placeholder="0" min="1" required>
                </div>
            </div>

            <!-- Button Group -->
            <div class="button-group">
                <button type="submit" id="submit" class="btn btn-primary" onclick="msgAdd()">✅ Add Item</button>
                <button type="reset" class="btn btn-secondary">🔄 Clear Form</button>
                <input type="reset" value="❌ Cancel" class="btn btn-secondary" onclick="window.location.href='ItemController?action=list'">
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('category').addEventListener('change', function() {
    const category = this.value;
    const itemIdField = document.getElementById('item_id');

    if (category) {
        const prefix = category.substring(0, 3).toUpperCase();
        const timestamp = Date.now().toString().slice(-4);
        itemIdField.value = prefix + " - " + timestamp;
    }
});

document.querySelector('form').addEventListener('submit', function(e) {
    const price = parseFloat(document.getElementById('unit-price').value);
    const quantity = parseInt(document.getElementById('stock-quantity').value);

    if (price < 1) {
        e.preventDefault();
        alert('Unit price cannot be less than one');
        return;
    }

    if (quantity < 1) {
        e.preventDefault();
        alert('Stock Quantity cannot be less than 1');
        return;
    }
});

function msgAdd(){
	alert('Item Added Successfully');
}

</script>
</body>
</html>