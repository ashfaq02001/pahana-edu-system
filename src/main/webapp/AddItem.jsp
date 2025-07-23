<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Item</title>
</head>
<body>
	<form action="ItemController?action=addItem" method="post">
		
		<label for="item_name"> Item Name: </label>
		<input type="text" name="item_name"> <br><br>
		
		<label for="description"> Description: </label>
		<input type="text" name="description"> <br><br>
		
		<label for="price"> Price: </label>
		<input type="number" name="price"> <br><br>
		
		<label for="stock_quantity"> Stock Quantity: </label>
		<input type="number" name="stock_quantity"><br><br>
		
		<button type="submit">Add Item</button>
	</form>
</body>
</html>