<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<style>
</style>
<body>

	<!-- Header -->
	<div class="header">
		<div class="admin-info">
			<div>
				Welcome, <strong>${sessionScope.username}</strong>
			</div>
			<div style="font-size: 0.8rem; opacity: 0.8;">Administrator</div>
			<a href="LoginController?action=logout" class="logout-btn">Logout</a>
		</div>
		<h1>Admin Dashboard</h1>
		<p>PAHANA Book Shop Management System</p>
	</div>

	<div class="navigation">
		<div class="nav-links">
			<a href="LoginController?action=admin" class="nav-link"> <span>🏠</span>
				<span>Home</span>
			</a> <a href="BillController?action=dashboard" class="nav-link"> <span>📄</span>
				<span>Create Invoice</span>
			</a> <a href="ItemController?action=viewItems" class="nav-link"> <span>📚</span>
				<span>Manage Items</span>
			</a> <a href="CustomerController?action=viewCustomers" class="nav-link">
				<span>👤</span> <span>Manage Customers</span>
			</a> <a href="BillController?action=viewBills" class="nav-link"> <span>📊</span>
				<span>Manage Bills</span>
			</a> <a href="LoginController?action=help" class="nav-link"> <span>❓</span>
				<span>Help</span>
			</a>
		</div>
	</div>

	<br>

	<!-- Help Sections -->
	<div class="help-sections">

		<!-- Customer Management Help -->
		<div class="help-section">
			<h2 class="help-section-title">
				<span class="help-section-icon">👥</span> Customer Management
			</h2>
			<div class="help-content">
				<p>Learn how to effectively manage your customer database and
					accounts.</p>

				<h3>Adding a New Customer:</h3>
				<ol class="help-steps">
					<li>Click on "Manage Customers" from the navigation menu</li>
					<li>Click the "Add New Customer" button</li>
					<li>Fill in all required fields (marked with *)</li>
					<li>Account number is auto-generated automatically</li>
					<li>Click "Add Customer" to save the information</li>
				</ol>

				<h3>Updating Customer Details:</h3>
				<ol class="help-steps">
					<li>Click on "Manage Customers" from the navigation menu</li>
					<li>Select the customer and click the "Edit" button</li>
					<li>Change the details you need</li>
					<li>Account number cannot be changed</li>
					<li>Click on update customer to save</li>
				</ol>

				<h3>Deleting a Customer:</h3>
				<ol class="help-steps">
					<li>Click on "Manage Customers" from the navigation menu</li>
					<li>Select the customer and click the "delete" button</li>
				</ol>




			</div>
		</div>

		<!-- Bill Management Help -->
		<div class="help-section">
			<h2 class="help-section-title">
				<span class="help-section-icon">📄</span> Invoice & Bill Management
			</h2>
			<div class="help-content">
				<p>Master the billing system to create professional invoices and
					track sales.</p>

				<h3>Creating a New Invoice:</h3>
				<ol class="help-steps">
					<li>Click "Create Invoice" from the navigation menu</li>
					<li>Select or search for the customer</li>
					<li>Add items to the invoice by searching items</li>
					<li>Set quantities and verify prices</li>
					<li>Add discount if you want</li>
					<li>Click on save button</li>
					<li>Click on print receipt button to print a pdf receipt</li>
				</ol>
			</div>
		</div>

		<!-- Item Management Help -->
		<div class="help-section">
			<h2 class="help-section-title">
				<span class="help-section-icon">📚</span> Item & Inventory
				Management
			</h2>
			<div class="help-content">
				<p>Efficiently manage your item inventory and track stock
					levels.</p>

				<h3>Adding New Items:</h3>
				<ol class="help-steps">
					<li>Navigate to "Manage Items" section</li>
					<li>Click "Add New Item" button</li>
					<li>Enter item details required (marked with *)</li>
					<li>Select the category and description</li>
					<li>Save the item information</li>
				</ol>

				<h3>Updating Item Information & Stock:</h3>
				<ol class="help-steps">
					<li>Navigate to "Manage Items" section</li>
					<li>Click "Edit" button</li>
					<li>Make changes you need / add stock</li>
					<li>Click on "update"</li>
				</ol>

				<h3>Deleting an Item:</h3>
				<ol class="help-steps">
					<li>Navigate to "Manage Items" section</li>
					<li>Click "Delete" button</li>
				</ol>
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