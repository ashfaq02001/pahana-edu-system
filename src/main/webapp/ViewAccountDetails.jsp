<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Account Details</title>
</head>
<body>
	<h1>Customer Management System</h1>

	<c:if test="${not empty errorMessage}">
		<p style="color: red;">${errorMessage}</p>
	</c:if>

	<p>
		<a href="CustomerController?action=addCustomer">Add New Customer</a>
	</p>

	<table border="1">
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
					<td><c:out value="${customer.accountNumber}" /></td>
					<td><c:out value="${customer.name}" /></td>
					<td><c:out value="${customer.address}" /></td>
					<td><c:out value="${customer.telephone}" /></td>
					<td><c:out value="${customer.email}" /></td>
					<td><c:out value="${customer.registrationDate}" /></td>
					<td><a
						href="CustomerController?action=editCustomer&id=<c:out value='${customer.accountNumber}' />">Edit</a>
						<a
						href="CustomerController?action=deleteCustomer&id=<c:out value='${customer.accountNumber}' />"
						onclick="return confirm('Are you sure you want to delete this customer?')">Delete</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="index.jsp">Back to home</a>
</body>
</html>