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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PAHANA Book Shop</title>
   	<link rel="stylesheet" type="text/css" href="./CSS/admin-style.css">
</head>
<body>

    <!-- Header -->
    <div class="header">
        <div class="admin-info">
            <div>Welcome, <strong>${sessionScope.username}</strong></div>
            <div style="font-size: 0.8rem; opacity: 0.8;">Administrator</div>
            <a href="LoginController?action=logout" class="logout-btn">Logout</a>
        </div>
        <h1>Admin Dashboard</h1>
        <p>PAHANA Book Shop Management System</p>
    </div>
    
    <div class="navigation">
    <div class="nav-links">
        <a href="LoginController?action=admin" class="nav-link">
            <span>🏠</span>
            <span>Home</span>
        </a>
        <a href="BillController?action=dashboard" class="nav-link">
            <span>📄</span>
            <span>Create Invoice</span>
        </a>
        <a href="ItemController?action=viewItems" class="nav-link">
            <span>📚</span>
            <span>Manage Items</span>
        </a>
        <a href="CustomerController?action=viewCustomers" class="nav-link">
            <span>👤</span>
            <span>Manage Customers</span>
        </a>
        <a href="BillController?action=viewBills" class="nav-link">
            <span>📊</span>
            <span>Manage Bills</span>
        </a>
        <a href="LoginController?action=help" class="nav-link">
            <span>❓</span>  
            <span>Help</span>   
        </a>
    </div>
</div>
    <br>


    <!-- Main Container -->
    <div class="container">
        <!-- Quick Stats -->
        <div class="stats-section">
            <h3 class="stats-title">System Overview</h3>
            <div class="stats-grid">
                <div class="stat-item">
                	<img alt="" src="./img/customers-icon-3.png">
                    <div class="stat-number">${customerCount != null ? customerCount : 0}</div>
                    <div class="stat-label">Customers</div>
                </div>
                <div class="stat-item">
                	<img alt="" src="./img/bill-icon.png">
                    <div class="stat-number">${billCount != null ? billCount : 0}</div>
                    <div class="stat-label">Bills</div>
                </div>
                <div class="stat-item">
                	<img alt="" src="./img/user.jpg">
                    <div class="stat-number">${userCount != null ? userCount : 0}</div>
                    <div class="stat-label">Users</div>
                </div>
                <div class="stat-item">
                	<img alt="" src="./img/item.png">
                    <div class="stat-number">${itemCount != null ? itemCount : 0}</div>
                    <div class="stat-label">Items</div>
                </div>
            </div>
        </div>

        
		<script>
        // Add smooth transitions
        document.addEventListener('DOMContentLoaded', function() {
            const menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateX(-20px)';
                setTimeout(() => {
                    item.style.transition = 'all 0.3s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateX(0)';
                }, index * 50);
            });
        });
    </script>
</body>
</html>