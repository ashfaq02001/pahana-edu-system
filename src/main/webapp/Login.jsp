<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>login</title>
</head>

<body>
	<h2>Login Page</h2>
    <form action="login" method="post">
        <label>Username:</label>
        <input type="text" name="username" required /><br><br>
        <label>Password:</label>
        <input type="password" name="password" required /><br><br>
        <input type="submit" value="Login" />
    </form>
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
</body>
</html>