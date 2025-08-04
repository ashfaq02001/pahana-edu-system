<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Customer</title>
</head>
<body>
	<h1>Edit Customer</h1>
	
	<form action="CustomerController" method="post">
		<input type="hidden" name="action" value="updateCustomer">
		
		<table>
			<tr>
				<td>Account Number:</td>
				<td><input type="text" name="account_no" value="${customer.accountNumber}" readonly></td>
			</tr>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="name" value="${customer.name}" required></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><textarea name="address" rows="3" cols="30" required>${customer.address}</textarea></td>
			</tr>
			<tr>
				<td>Telephone:</td>
				<td><input type="text" name="telephone" value="${customer.telephone}" required></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="email" name="email" value="${customer.email}" required></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="Update Customer">
					<input type="button" value="Cancel" onclick="window.location.href='CustomerController?action=list'">
				</td>
			</tr>
		</table>
	</form>
	
	<br>
	<a href="CustomerController?action=list">Back to Customer List</a><br><br>
	<a href="index.jsp">Back to home</a>
</body>
</html>