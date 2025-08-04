package com.assignment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.assignment.model.User;

public class UserDAO {

	public User authenticate(String username, String password) throws SQLException {
        String query = "SELECT * FROM users WHERE username = ? AND password = ? AND is_active = 1";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DBConnectionFactory.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password); // In production, use hashed passwords
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setActive(rs.getBoolean("is_active"));
                user.setCreatedDate(rs.getTimestamp("created_date"));
                user.setLastLogin(rs.getTimestamp("last_login"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return user;
    }
    
    public void updateLastLogin(int userId) {
        String query = "UPDATE users SET last_login = ? WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnectionFactory.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public User getUserByUsername(String username) throws SQLException {
        String query = "SELECT * FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DBConnectionFactory.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setActive(rs.getBoolean("is_active"));
                user.setCreatedDate(rs.getTimestamp("created_date"));
                user.setLastLogin(rs.getTimestamp("last_login"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return user;
    }
    
    public int getUserCount() throws SQLException {
	    String query = "SELECT COUNT(*) FROM users";
	    Connection connection = null;
	    PreparedStatement pstmt = null;
	    ResultSet resultSet = null;
	    try {
	        connection = DBConnectionFactory.getConnection();
	        pstmt = connection.prepareStatement(query);
	        resultSet = pstmt.executeQuery();
	        if (resultSet.next()) {
	            return resultSet.getInt(1);
	        }
	        return 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        // Cleanup code like your existing methods
	        try {
	            if (resultSet != null) resultSet.close();
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
}
