<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Pahana Educational Institute</title>
<link rel="stylesheet" href="./CSS/login.css">
<script>
    function validateForm() {
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        
        if (username.trim() === "") {
            alert("Please enter username");
            return false;
        }
        
        if (password.trim() === "") {
            alert("Please enter password");
            return false;
        }
        
        return true;
    }
    
    window.onload = function() {
        // Show messages if any
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('message') === 'logged_out') {
            alert("You have been logged out successfully");
        }
        if (urlParams.get('error') === 'unknown_role') {
            alert("Access denied. Unknown user role.");
        }
    }
</script>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <h3>Pahana Educational Institute</h3>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>

        <form action="LoginController" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="authenticate">

            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="Enter username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter password" required>

            <div class="remember">
                <input type="checkbox" id="rememberMe" name="rememberMe">
                <label for="rememberMe">Remember me for 7 days</label>
            </div>

            <input type="submit" value="Login">
        </form>

        <div class="demo-info">
            <p><strong>Demo Accounts:</strong></p>
            <p>Admin: <code>admin / admin123</code></p>
            <p>User: <code>user / user123</code></p>
        </div>
    </div>
    
</body>
</html>