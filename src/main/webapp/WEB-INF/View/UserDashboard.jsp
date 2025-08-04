<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
</head>
<body>
    <h1>User Dashboard</h1>
    
    <p>Welcome, ${sessionScope.username}!</p>
    
    <table border="1" cellpadding="10" cellspacing="0">
        <tr>
            <td>
                <h3>Customer Management</h3>
                <p>Add and manage customer information</p>
                <a href="CustomerController?action=addCustomer">
                    <button type="button">Add Customer</button>
                </a>
            </td>
            <td>
                <h3>Billing</h3>
                <p>Generate bills and manage transactions</p>
                <a href="BillController?action=dashboard">
                    <button type="button">Generate Bills</button>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <h3>View Bills</h3>
                <p>View all generated bills</p>
                <a href="BillController?action=viewBills">
                    <button type="button">View Bills</button>
                </a>
            </td>
            <td>
                <h3>Help & Support</h3>
                <p>Get help and support information</p>
                <a href="help.jsp">
                    <button type="button">Help Page</button>
                </a>
            </td>
        </tr>
    </table>
    
    <hr>
    
    <p>
        <a href="LoginController?action=logout">
            <button type="button">Logout</button>
        </a>
    </p>
    
</body>
</html>