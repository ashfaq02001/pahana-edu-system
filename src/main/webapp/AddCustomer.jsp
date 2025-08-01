<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Customer Account</title>
</head>
<body>
	<h1>Add New Customer</h1>

	<form action="CustomerController?addCustomer" method="post">
		<input type="hidden" name="action" value="addCustomer">

		<table>
			<tr>
				<td>Account Number:</td>
				<td><input type="text" id="account_no" name="account_no" readonly required></td>
			</tr>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="name" required></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><textarea name="address" rows="3" cols="30" required></textarea></td>
			</tr>
			<tr>
				<td>Telephone:</td>
				<td><input type="text" name="telephone" required></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="email" name="email" required></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Add Customer">
					<input type="reset" value="Clear"></td>
			</tr>
		</table>
	</form>
	<script>
		// Function to generate auto account number
		function generateAccountNumber() {
			// Get current date
			var today = new Date();
			var year = today.getFullYear().toString().substr(-2); // Last 2 digits of year
			var month = String(today.getMonth() + 1).padStart(2, '0'); // Month with leading zero

			// Generate random 4-digit number
			var randomNum = Math.floor(1000 + Math.random() * 9000);

			// Create account number format: PHN/YY/MM/XXXX
			var accountNumber = "PHN/" + year + "/" + month + "/" + randomNum;

			return accountNumber;
		}

		// Function to set account number when page loads
		window.onload = function() {
			document.getElementById("account_no").value = generateAccountNumber();
		}
	</script>
	<br>
	<a href="CustomerController?action=list">View All Customers</a>
	<a href="index.jsp">Back to home</a>

</body>
</html>