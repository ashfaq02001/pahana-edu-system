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
    <h1>Item Management System</h1>
    
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
    
    <p><a href="ItemController?action=addItem">Add New Item</a></p>
    
    <table border="1">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Description</th>
                <th>Unit Price</th>
                <th>Category</th>
                <th>Stock Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td><c:out value="${item.item_Id}" /></td>
                    <td><c:out value="${item.itemName}" /></td>
                    <td><c:out value="${item.description}" /></td>
                    <td><c:out value="${item.unit_Price}" /></td>
                    <td><c:out value="${item.category}" /></td>
                    <td><c:out value="${item.stockQuantity}" /></td>
                    <td>
                        <a href="ItemController?action=editItem&id=<c:out value='${item.item_Id}' />">Edit</a>
                        <a href="ItemController?action=deleteItem&id=<c:out value='${item.item_Id}' />" 
                           onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="index.jsp">Back to home</a>
</body>
</html>