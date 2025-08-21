<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Check session
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("LoginController?action=login");
        return;
    }
    
    com.assignment.model.User currentUser = (com.assignment.model.User) session.getAttribute("user");
    
    //check if user logged in is an admin
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
    <title>View Bills - PAHANA Book Shop</title>
    <link rel="stylesheet" type="text/css" href="./CSS/view-bills.css">
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
        <h1>Bill Management</h1>
        <p>PAHANA Book Shop - View Bill Details</p>
        <div class="customer-count">
            Total bills: <strong>${bills.size()}</strong>
        </div>
    </div>

    <div class="navigation">
    <div class="nav-links">
        <a href="LoginController?action=admin" class="nav-link">
            <span>🏠</span>
            <span>Home</span>
        </a>
        <a href="BillController?action=dashboard" class="nav-link">
            <span>📄</span>
            <span>Create Bill</span>
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
            <span>📝</span>
            <span>Manage Bills</span>
        </a>
        <a href="LoginController?action=help" class="nav-link">
            <span>❓</span>
            <span>Help</span>
        </a>
    </div>
</div>

<br>

    <!-- Page Content -->
    <div class="page-content">
        
        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ⚠️ <strong>Error:</strong> ${errorMessage}
            </div>
        </c:if>

        <!-- Controls Section -->
        <div class="controls-section">
            <div class="search-section">
                <input type="text" class="search-input" placeholder="🔍 Search bills" id="searchInput" onkeyup="searchCustomers()">
                <button class="search-btn" onclick="searchCustomers()">Search</button>
            </div>
            <a href="BillController?action=dashboard" class="add-customer-btn">
                <span>➕</span>
                <span>Create New Bill</span>
            </a>
        </div>

        <!-- Customers Table -->
        <div class="customers-table-container">
            <div class="table-header">
                <h3>📋 View Bills</h3>
                <p>Manage and view all registered customers</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty bills}">
                    <table class="customers-table" id="customersTable">
                        <thead>
                            <tr>
                                <th>Bill ID</th>
        						<th>Bill Date</th>
        						<th>Account Number</th>
        						<th>Customer Name</th>
        						<th>Total Amount</th>
        						<th>Discount</th>
     							<c:if test="${sessionScope.role eq 'admin'}">
        						<th>Actions</th>
    							</c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bill" items="${bills}">
                                <tr>
                                    <td>${bill.billId}</td>
                                    <td><fmt:formatDate value="${bill.billDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>${bill.accountNo}</td>
                                    <td>
                						<c:set var="customerName" value="Unknown" />
                						<c:forEach var="customer" items="${customers}">
                    						<c:if test="${customer.accountNumber eq bill.accountNo}">
                        						<c:set var="customerName" value="${customer.name}" />
                    						</c:if>
                						</c:forEach>
                						${customerName}
            						</td>
                                    <td>Rs. <fmt:formatNumber value="${bill.totalAmount}" pattern="#,##0.00"/></td>
                                    <td>Rs. <fmt:formatNumber value="${bill.totalAmount * bill.discount / 100}" pattern="#,##0.00"/></td>
                                    <c:if test="${sessionScope.role eq 'admin'}">
                                    <td>
                                    <div class="action-buttons">
                                    	<a href="BillController?action=deleteBill&billId=${bill.billId}" class="btn btn-delete" onclick="return confirm('Delete this bill?')">Delete</a>  
                                    </div>	
                                    </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📄</div>
                        <h3>No Bills Found</h3>
                        <p>Start by creating your first bill.</p>
                        <br>
                        <a href="BillController?action=dashboard" class="add-customer-btn">
                            <span>➕</span>
                            <span>Create New Bill</span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>

        // Search functionality
        function searchCustomers() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('customersTable');
            const rows = table.getElementsByTagName('tr');

            for (let i = 1; i < rows.length; i++) {
                let row = rows[i];
                let cells = row.getElementsByTagName('td');
                let found = false;

                // Search in name, email, and telephone columns
                for (let j = 1; j <= 4; j++) {
                    if (cells[j] && cells[j].textContent.toLowerCase().includes(filter)) {
                        found = true;
                        break;
                    }
                }

                row.style.display = found ? '' : 'none';
            }
        }

        // Auto-search as user types
        document.getElementById('searchInput').addEventListener('input', searchCustomers);
    </script>

</body>
</html>