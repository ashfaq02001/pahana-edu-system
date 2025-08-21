# PAHANA Book Shop Management System

A comprehensive web-based book shop management system built with Java, JSP, and MySQL. This system provides complete functionality for managing items, customers, billing, and administrative tasks
## ✨ Features

- **Book Management** - Add, edit, delete items
- **Customer Management** - Add, edit, delete customer accounts
- **Billing System** - Generate professional invoices with multiple items
- **Admin Dashboard** - Manages all administration services
- **Role-based Access** - Admin and User roles with different permissions
- **Responsive Design** - Modern UI that works on all devices

## Quick Start

### Prerequisites
- Java 17
- Apache Tomcat 9+
- MySQL 8.0

### Setup
```bash
1. Clone the repository
2. Create MySQL database: pahana_edu_db
3. import database: pahana_edu_db
4. Configure database connection in DatabaseConnection.java
5. Deploy to Tomcat webapps folder
6. Access: http://localhost:8080/pahana-billing
```

### Default Login
- **Admin**: `admin / admin123`
- **User**: `user / user123`

## Tech Stack

- **Backend**: Java, JSP, Servlets, JDBC
- **Frontend**: HTML5, CSS3, JavaScript
- **Database**: MySQL
- **Server**: Apache Tomcat
- **Build Tool**: Maven
- **IDE**: Eclipse

## Key Components

- **Controllers** - Handle HTTP requests and business logic
- **DAOs** - Database access layer with CRUD operations
- **Models** - Entity classes (Bill, Customer, Item, User)
- **JSP Pages** - Dynamic web interface with professional styling

## Maven Dependencies
    <dependency>
			<groupId>javax.servlet.jsp</groupId>
			<artifactId>javax.servlet.jsp-api</artifactId>
			<version>2.3.3</version>
			<scope>provided</scope>
		</dependency>
  
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>8.0.32</version>
		</dependency>

		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.13.2</version>
			<scope>test</scope>
		</dependency>

		<dependency>
			<groupId>org.junit.jupiter</groupId>
			<artifactId>junit-jupiter</artifactId>
			<version>5.9.3</version>
			<scope>test</scope>
		</dependency>

		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>

		<dependency>
			<groupId>com.github.librepdf</groupId>
			<artifactId>openpdf</artifactId>
			<version>1.3.30</version>
		</dependency>

## Author
- For any inquiries or support, please contact mohammedashfaq798@gmail.com
