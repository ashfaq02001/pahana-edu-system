<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Items</title>
</head>
<h1>Edit Item</h1>
    
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
    
    <form action="ItemController" method="post">
        <input type="hidden" name="action" value="updateItem">
        
        <table>
            <tr>
                <td>Item ID:</td>
                <td><input type="text" name="item_id" value="<c:out value='${item.item_Id}' />" readonly></td>
            </tr>
            <tr>
                <td>Item Name:</td>
                <td><input type="text" name="item_name" value="<c:out value='${item.itemName}' />" required></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td><textarea name="description" rows="4" cols="50"><c:out value='${item.description}' /></textarea></td>
            </tr>
            <tr>
                <td>Unit Price:</td>
                <td><input type="number" step="0.01" name="unit_price" value="<c:out value='${item.unit_Price}' />" required></td>
            </tr>
            <tr>
                <td>Category:</td>
                <td><input type="text" name="category" value="<c:out value='${item.category}' />" required></td>
            </tr>
            <tr>
                <td>Stock Quantity:</td>
                <td><input type="number" name="stock_quantity" value="<c:out value='${item.stockQuantity}' />" required></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="Update Item">
                    <a href="ItemController?action=list">Cancel</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>