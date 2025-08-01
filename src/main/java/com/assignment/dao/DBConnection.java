package com.assignment.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/pahana_edu_db";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "123456";
	private static DBConnection instance;

	    private DBConnection() {
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        }
	    }

	    public static DBConnection getInstance() {
	        if (instance == null) {
	            synchronized (DBConnection.class) {
	                if (instance == null) {
	                    instance = new DBConnection();
	                }
	            }
	        }
	        return instance;
	    }

	    // Create a new connection each time
	    public Connection getConnection() throws SQLException {
	        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	    }
	}


