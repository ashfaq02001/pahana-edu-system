<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Bills</title>
</head>
<body>
    <h1>All Bills</h1>
    
    <table border="1" cellpadding="5" cellspacing="0">
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
                <a href="BillController?action=deleteBill&billId=${bill.billId}" 
                   onclick="return confirm('Delete this bill?')">Delete</a>
            </td>
        </c:if>
        </tr>
    </c:forEach>
</table>
    
    <p><a href="BillController?action=dashboard">Back to Dashboard</a></p>
</body>
</html>