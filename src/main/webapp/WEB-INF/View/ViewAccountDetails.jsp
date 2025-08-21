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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Customers - PAHANA Book Shop</title>
    <link rel="stylesheet" type="text/css" href="./CSS/view-customer.css">
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
        <h1>Customer Management</h1>
        <p>PAHANA Book Shop - View Customer Details</p>
        <div class="customer-count">
            Total Customers: <strong>${account_list.size()}</strong>
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
                <input type="text" class="search-input" placeholder="🔍 Search customers" id="searchInput" onkeyup="searchCustomers()">
                <button class="search-btn" onclick="searchCustomers()">Search</button>
            </div>
            <a href="CustomerController?action=addCustomer" class="add-customer-btn">
                <span>➕</span>
                <span>Add New Customer</span>
            </a>
        </div>

        <!-- Customers Table -->
        <div class="customers-table-container">
            <div class="table-header">
                <h3>Customer Accounts</h3>
                <p>Manage and view all registered customers</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty account_list}">
                    <table class="customers-table" id="customersTable">
                        <thead>
                            <tr>
                                <th>Account Number</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th>Telephone</th>
                                <th>Email</th>
                                <th>Registration Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${account_list}">
                                <tr>
                                    <td><strong><c:out value="${customer.accountNumber}" /></strong></td>
                                    <td><c:out value="${customer.name}" /></td>
                                    <td><c:out value="${customer.address}" /></td>
                                    <td><c:out value="${customer.telephone}" /></td>
                                    <td><c:out value="${customer.email}" /></td>
                                    <td><c:out value="${customer.registrationDate}" /></td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="CustomerController?action=editCustomer&id=<c:out value='${customer.accountNumber}' />" 
                                               class="btn btn-edit">Edit</a>
                                            <a href="CustomerController?action=deleteCustomer&id=<c:out value='${customer.accountNumber}' />" 
                                               class="btn btn-delete"
                                               onclick="return confirm('Are you sure you want to delete this customer?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">👥</div>
                        <h3>No Customers Found</h3>
                        <p>Start by adding your first customer to the system.</p>
                        <br>
                        <a href="CustomerController?action=addCustomer" class="add-customer-btn">
                            <span>➕</span>
                            <span>Add New Customer</span>
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