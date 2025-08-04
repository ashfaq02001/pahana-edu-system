<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PAHANA Book Shop - Billing System</title>
  	<link rel="stylesheet" href="./CSS/index.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="shop-logo">PAHANA EDU (PVT) LTD</div>
            <div class="shop-subtitle">Billing Management System</div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="welcome-section">
                <h2 id="greeting">Welcome!</h2>
                <p>Manage your book shop operations efficiently with our comprehensive billing solution.</p>
            </div>

            <!-- Login & Help Section -->
            <div class="login-section">
                <h3>Access Required</h3>
                <p>Please login to continue or visit our help section for guidance.</p>
                <div style="display: flex; justify-content: center; gap: 20px; flex-wrap: wrap;">
                    <a href="LoginController?action=login" class="login-button">Login to System</a>
                </div>
            </div>
        </div>

        
    </div>

    <script>
        function getGreeting() {
            const now = new Date();
            const hour = now.getHours();
            let greeting = "";

            if (hour < 12) {
                greeting = "Good Morning! Welcome to Pahana";
            } else if (hour < 17) {
                greeting = "Good Afternoon! Welcome to Pahana";
            } else if (hour < 21) {
                greeting = "Good Evening! Welcome to Pahana";
            } else {
                greeting = "Good Night! Welcome to Pahana";
            }

            return greeting;
        }

        document.getElementById("greeting").innerText = getGreeting();
    </script>
</body>
</html>
