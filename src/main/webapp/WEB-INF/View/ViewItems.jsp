<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Items</title>
</head>
<body>
	<div class="container">
        <h1 class="text-center">Item List</h1>
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Item ID</th>
                    <th>Item Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Stock Quantity</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.item_Id}</td>
                <td>${item.itemName}</td>
                <td>${item.description}</td>
                <td>${item.price}</td>
                <td>${item.stockQuantity}</td>
            </tr>
        </c:forEach>
            </tbody>
        </table>
        <div class="text-center">
            <a href="product?action=add" class="btn btn-primary">Add New Product</a>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</body>
</html>