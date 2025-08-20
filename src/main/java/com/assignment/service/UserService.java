package com.assignment.service;

import java.sql.SQLException;

import com.assignment.dao.UserDAO;
import com.assignment.model.User;

public class UserService {

	private static UserService instance;
    private UserDAO userDAO;
    
    private UserService() {
        userDAO = new UserDAO();
    }
    
    public static UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }
    
    public User authenticateUser(String username, String password) throws SQLException {
        return userDAO.authenticate(username, password);
    }
    
    public void updateLastLogin(int userId) {
        userDAO.updateLastLogin(userId);
    }
    
    public User getUserByUsername(String username) throws SQLException {
        return userDAO.getUserByUsername(username);
    }
	
    public int getUserCount() throws SQLException {
	    return userDAO.getUserCount();
	}
    
    
}
