<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<%
String successMsg = (String) session.getAttribute("successMessage");
if (successMsg != null) {
    session.removeAttribute("successMessage");
%>
    <script>alert("✅ <%= successMsg %>");</script>
<%
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Management - PAHANA Book Shop</title>
    <link rel="stylesheet" type="text/css" href="./CSS/view-item.css">
    <style>
        
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="admin-info">
            <div>Welcome, <strong>${sessionScope.username}</strong></div>
            <div style="font-size: 0.8rem; opacity: 0.8;">Administrator</div>
            <a href="LoginController?action=logout" class="logout-btn">Logout</a>
        </div>
        <h1>Item Management</h1>
        <p>PAHANA Book Shop - View Customer Details</p>
        <div class="customer-count">
            Total Items: <strong>${items.size()}</strong>
        </div>
    </div>
   
        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="alert">
                ${errorMessage}
            </div>
        </c:if>
        
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
	<div class="page-content">
        <!-- Action Bar -->
        <div class="action-bar">
            <div class="action-left">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search items...">
                </div>
            </div>
            <div class="action-right">
                <a href="ItemController?action=addItem" class="btn btn-primary">
                    ➕ Add New Item
                </a>
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <div class="table-header">
                <h2>Item Inventory</h2>
                <p>Manage your items and stock levels</p>
            </div>

            <c:choose>
                <c:when test="${empty items}">
                    <div class="empty-state">
                        <div class="icon">📚</div>
                        <h3>No Items Found</h3>
                        <p>Start building your inventory by adding your first book item.</p>
                        <a href="ItemController?action=addItem" class="btn btn-success">
                            ➕ Add First Item
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="items-table" id="itemsTable">
                        <thead>
                            <tr>
                                <th>Item ID</th>
                                <th>Item Name</th>
                                <th>Description</th>
                                <th>Unit Price</th>
                                <th>Category</th>
                                <th>Stock</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}">
                                <tr>
                                    <td>
                                        <span class="item-id">
                                            <c:out value="${item.item_Id}" />
                                        </span>
                                    </td>
                                    <td>
                                        <div class="item-name">
                                            <c:out value="${item.itemName}" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="item-description" title="${item.description}">
                                            <c:out value="${item.description}" />
                                        </div>
                                    </td>
                                    <td>
                                        <span class="item-price">
                                            Rs. <fmt:formatNumber value="${item.unit_Price}" pattern="#,##0.00"/>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="item-category">
                                            <c:out value="${item.category}" />
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.stockQuantity == 0}">
                                                <span class="stock-quantity stock-out">Out of Stock</span>
                                            </c:when>
                                            <c:when test="${item.stockQuantity <= 5}">
                                                <span class="stock-quantity stock-low">${item.stockQuantity}</span>
                                            </c:when>
                                            <c:when test="${item.stockQuantity <= 20}">
                                                <span class="stock-quantity stock-medium">${item.stockQuantity}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-quantity stock-high">${item.stockQuantity}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="ItemController?action=editItem&id=<c:out value='${item.item_Id}' />" 
                                               class="action-btn btn-edit" title="Edit Item">
                                                Edit
                                            </a>
                                            <a href="ItemController?action=deleteItem&id=<c:out value='${item.item_Id}' />" 
                                               class="action-btn btn-delete" 
                                               onclick="return confirm('Are you sure you want to delete this item?')"
                                               title="Delete Item">
                                                Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        </div>

        <!-- Navigation -->


    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchTerm = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#itemsTable tbody tr');
            
            tableRows.forEach(row => {
                const itemName = row.cells[1].textContent.toLowerCase();
                const itemId = row.cells[0].textContent.toLowerCase();
                const category = row.cells[4].textContent.toLowerCase();
                const description = row.cells[2].textContent.toLowerCase();
                
                if (itemName.includes(searchTerm) || 
                    itemId.includes(searchTerm) || 
                    category.includes(searchTerm) ||
                    description.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Update item count
            const visibleRows = document.querySelectorAll('#itemsTable tbody tr[style=""]').length;
            const totalRows = tableRows.length;
            const countElement = document.querySelector('.item-count');
            if (searchTerm) {
                countElement.innerHTML = `🔍 Found: ${visibleRows} of ${totalRows} items`;
            } else {
                countElement.innerHTML = `📊 Total Items: ${totalRows}`;
            }
        });

        // Add loading animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('#itemsTable tbody tr');
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    row.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, index * 50);
            });
        });

        // Confirm delete with better styling
        function confirmDelete(itemName) {
            return confirm(`Are you sure you want to delete "${itemName}"?\n\nThis action cannot be undone.`);
        }
    </script>
</body>
</html>