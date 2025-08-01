<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Item</title>
</head>
<body>
	<c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
	<form action="ItemController?action=addItem" method="post" id="form">
		
		<label for="item_id"> Item ID: </label>
		<input type="text" name="item_id" id="item_id" readonly> <br><br>
		
		<label for="name"> Item Name: </label>
		<input type="text" name="item_name"> <br><br>
		
		<label for="description"> Description: </label>
		<input type="text" name="description"> <br><br>
		
		<label for="unit_price"> Unit Price: </label>
		<input type="text" name="unit_price" id="unit-price"><br><br>
		
		<label>Category:</label> 
		<select name="category" id="category" required>
			<option value="">Select Category</option>
			<option value="Books">Books</option>
			<option value="Stationary">Stationary</option>
			<option value="Other">Other</option>
			<!-- Add more categories as needed -->
		</select><br><br> 
		
		<label for="stock_quantity"> Stock Quantity: </label>
		<input type="text" name="stock_quantity" id="stock-quantity"><br><br>
		
		<button type="submit" id="submit">Add Item</button>
	</form>
	
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
	</script>
</body>
</html>