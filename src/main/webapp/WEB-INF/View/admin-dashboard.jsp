<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        <!-- Main Menu -->
        <div class="menu-card">
            <div class="menu-header">
                <h2>Management Menu</h2>
                <p>Select an option to manage your book shop</p>
            </div>
            
            <div class="menu-options">
                <!-- Customer Management -->
                <div class="menu-section">
                    <div class="section-title customer">Customer Management</div>
                    <div class="menu-items">
                        <a href="CustomerController?action=addCustomer" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">Add New Customer</div>
                                <div class="menu-description">Register new customer accounts</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                        <a href="CustomerController?action=viewCustomers" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">View Account Details</div>
                                <div class="menu-description">Browse and manage customer records</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                    </div>
                </div>

                <!-- Bill Management -->
                <div class="menu-section">
                    <div class="section-title bill">Bill Management</div>
                    <div class="menu-items">
                        <a href="BillController?action=dashboard" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">Generate New Bill</div>
                                <div class="menu-description">Create invoices for book sales</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                        <a href="BillController?action=viewBills" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">View All Bills</div>
                                <div class="menu-description">Browse and manage all sales records</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
         
                    </div>
                </div>

                <!-- User Management -->
                <div class="menu-section">
                    <div class="section-title user">User Management</div>
                    <div class="menu-items">
                        <a href="UserController?action=addUser" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">Add New User</div>
                                <div class="menu-description">Create new staff accounts</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                        <a href="UserController?action=viewUsers" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">View All Users</div>
                                <div class="menu-description">Manage system user accounts</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                        <a href="UserController?action=manageRoles" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">Manage User Roles</div>
                                <div class="menu-description">Set permissions and access levels</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                    </div>
                </div>

                <!-- Item Management -->
                <div class="menu-section">
                    <div class="section-title item">Item Management</div>
                    <div class="menu-items">
                        <a href="ItemController?action=addItem" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">Add New Book</div>
                                <div class="menu-description">Add books to inventory</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                        <a href="ItemController?action=viewItems" class="menu-item">
                            
                            <div class="menu-text">
                                <div class="menu-title">View All Items</div>
                                <div class="menu-description">Browse and manage book inventory</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                     
                    </div>
                </div>
                
                <div class="menu-section">
                    <div class="section-title help">Help Section</div>
                    <div class="menu-items">
                        <a href="LoginController?action=help" class="menu-item">
                            <div class="menu-text">
                                <div class="menu-title">Help</div>
                                <div class="menu-description">Click here to more help</div>
                            </div>
                            <div class="menu-arrow">→</div>
                        </a>
                    </div>
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