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

	    try (Connection conn = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        
	        pstmt.setString(1, username);
	        pstmt.setString(2, password); 
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                User user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setUsername(rs.getString("username"));
	                user.setPassword(rs.getString("password"));
	                user.setEmail(rs.getString("email"));
	                user.setRole(rs.getString("role"));
	                user.setActive(rs.getBoolean("is_active"));
	                user.setCreatedDate(rs.getTimestamp("created_date"));
	                user.setLastLogin(rs.getTimestamp("last_login"));
	                return user;
	            }
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return null;
	}
    
	public void updateLastLogin(int userId) {
	    String query = "UPDATE users SET last_login = ? WHERE user_id = ?";

	    try (Connection conn = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        
	        pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
	        pstmt.setInt(2, userId);
	        pstmt.executeUpdate();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
    
	public User getUserByUsername(String username) throws SQLException {
	    String query = "SELECT * FROM users WHERE username = ?";

	    try (Connection conn = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        
	        pstmt.setString(1, username);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                User user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setUsername(rs.getString("username"));
	                user.setEmail(rs.getString("email"));
	                user.setRole(rs.getString("role"));
	                user.setActive(rs.getBoolean("is_active"));
	                user.setCreatedDate(rs.getTimestamp("created_date"));
	                user.setLastLogin(rs.getTimestamp("last_login"));
	                return user;
	            }
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return null;
	}
    
	public int getUserCount() throws SQLException {
	    String query = "SELECT COUNT(*) FROM users";
	    
	    try (Connection connection = DBConnectionFactory.getConnection();
	         PreparedStatement pstmt = connection.prepareStatement(query);
	         ResultSet resultSet = pstmt.executeQuery()) {
	        
	        if (resultSet.next()) {
	            return resultSet.getInt(1);
	        }
	        return 0;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	
}
