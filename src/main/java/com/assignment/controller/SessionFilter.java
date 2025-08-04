package com.assignment.controller;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.assignment.model.User;

public class SessionFilter implements Filter {
    
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String uri = httpRequest.getRequestURI();
        
        // Allow access to login page and resources
        if (uri.endsWith("WEB-INF/View/Login.jsp") || 
            uri.endsWith("LoginController") || 
            uri.contains("/css/") || 
            uri.contains("/js/") || 
            uri.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check session
        HttpSession session = httpRequest.getSession(false);
        User user = null;
        
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        
        if (user == null) {
            // Not logged in, redirect to login
            httpResponse.sendRedirect("LoginController?action=login");
            return;
        }
        
        // Check role-based access
        String role = user.getRole().toLowerCase();
        
        // Admin can access everything
        if ("admin".equals(role)) {
            chain.doFilter(request, response);
            return;
        }
        
        // User can only access billing-related pages
        if ("user".equals(role)) {
            if (uri.contains("BillController") || 
                uri.endsWith("WEB-INF/View/BillingDashboard.jsp")) {
                chain.doFilter(request, response);
                return;
            } else {
                // User trying to access admin area
                httpResponse.sendRedirect("BillController?action=dashboard");
                return;
            }
        }
        
        // Unknown role
        httpResponse.sendRedirect("LoginController?action=logout");
    }
    
    public void destroy() {
        // Cleanup if needed
    }
}