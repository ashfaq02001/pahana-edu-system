package com.assignment.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.assignment.model.User;
import com.assignment.service.BillService;
import com.assignment.service.CustomerService;
import com.assignment.service.ItemService;
import com.assignment.service.UserService;

/**
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService;

	public void init() throws ServletException {
		userService = UserService.getInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action == null || action.equals("login")) {
			showLoginPage(request, response);
		} else if (action.equals("logout")) {
			logout(request, response);
		} else if (action.equals("adminDashboard") || action.equals("admin")) {
			showAdminDashboard(request, response);
		} else if (action.equals("help")) {
			showHelpPage(request, response);
		} else if (action.equals("back")) {
			showAdminDashboard(request, response);
		} else {
			response.sendRedirect("LoginController?action=login");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("authenticate".equals(action)) {
			authenticateUser(request, response);
		} else {
			response.sendRedirect("LoginController?action=login");
		}
	}

	private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Check if user is already logged in
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			redirectBasedOnRole(user, request, response);
			return;
		}

		// Check remember me cookie
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("rememberedUser".equals(cookie.getName())) {
					String username = cookie.getValue();
					try {
						User user = userService.getUserByUsername(username);
						if (user != null && user.isActive()) {
							// Auto login from cookie
							createUserSession(request, user, false);
							redirectBasedOnRole(user, request, response);
							return;
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}

		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	private void authenticateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String rememberMe = request.getParameter("rememberMe");

		try {
			User user = userService.authenticateUser(username, password);

			if (user != null) {

				// Update last login
				try {
					userService.updateLastLogin(user.getUserId());
				} catch (Exception e) {
					System.out.println("Warning: Could not update last login: " + e.getMessage());
				}

				// Create session
				boolean remember = "on".equals(rememberMe);
				createUserSession(request, user, remember);

				// Create remember me cookie if requested
				if (remember) {
					Cookie rememberCookie = new Cookie("rememberedUser", user.getUsername());
					rememberCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
					rememberCookie.setPath("/");
					response.addCookie(rememberCookie);
				}

				// Redirect based on role
				redirectBasedOnRole(user, request, response);

			} else {
				System.out.println("Login failed - Invalid credentials for: " + username);
				request.setAttribute("errorMessage", "Invalid username or password");
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			System.out.println("Database error: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error. Please try again.");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}

	private void createUserSession(HttpServletRequest request, User user, boolean rememberMe) {
		HttpSession session = request.getSession(true);
		session.setAttribute("user", user);
		session.setAttribute("username", user.getUsername());
		session.setAttribute("role", user.getRole());
		session.setAttribute("userId", user.getUserId());

		// Set session timeout (30 minutes)
		session.setMaxInactiveInterval(30 * 60);

		System.out.println("Session created for user: " + user.getUsername());
	}

	private void redirectBasedOnRole(User user, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String role = user.getRole().toLowerCase();

		if ("admin".equals(role)) {
			System.out.println("Loading Admin Dashboard");

			// Initialize counts with default values
			int customerCount = 0;
			int billCount = 0;
			int userCount = 0;
			int itemCount = 0;

			try {
				CustomerService customerService = CustomerService.getInstance();
				customerCount = customerService.getCustomerCount();
			} catch (Exception e) {
				System.out.println("Error getting customer count: " + e.getMessage());
			}

			try {
				BillService billService = BillService.getInstance();
				billCount = billService.getBillCount();
			} catch (Exception e) {
				System.out.println("Error getting bill count: " + e.getMessage());
			}

			try {
				UserService userService = UserService.getInstance();
				userCount = userService.getUserCount();
			} catch (Exception e) {
				System.out.println("Error getting user count: " + e.getMessage());
			}

			try {
				ItemService itemService = ItemService.getInstance();
				itemCount = itemService.getItemCount();
			} catch (Exception e) {
				System.out.println("Error getting item count: " + e.getMessage());
			}

			// Set attributes
			request.setAttribute("customerCount", customerCount);
			request.setAttribute("billCount", billCount);
			request.setAttribute("userCount", userCount);
			request.setAttribute("itemCount", itemCount);

			System.out.println("Dashboard loaded successfully");
			request.getRequestDispatcher("WEB-INF/View/admin-dashboard.jsp").forward(request, response);

		} else if ("user".equals(role)) {
			System.out.println("Loading Billing Dashboard");

			// Load data needed for billing dashboard
			try {
				// Load customer list for customer selection dropdown
				CustomerService customerService = CustomerService.getInstance();
				request.setAttribute("customers", customerService.ViewAccountDetails());
				System.out.println("Loaded customers for billing dashboard");
			} catch (Exception e) {
				System.out.println("Error loading customers: " + e.getMessage());
				request.setAttribute("customers", new java.util.ArrayList<>());
			}

			try {
				// Load item list for item selection dropdown
				ItemService itemService = ItemService.getInstance();
				request.setAttribute("items", itemService.ViewItems());
				System.out.println("Loaded items for billing dashboard");
			} catch (Exception e) {
				System.out.println("Error loading items: " + e.getMessage());
				request.setAttribute("items", new java.util.ArrayList<>());
			}

			System.out.println("Billing dashboard loaded successfully");
			request.getRequestDispatcher("WEB-INF/View/BillingDashboard.jsp").forward(request, response);

		} else {
			response.sendRedirect("LoginController?action=login&error=unknown_role");
		}
	}

	private void showAdminDashboard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if user is logged in and is admin
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("LoginController?action=login");
			return;
		}

		User user = (User) session.getAttribute("user");
		if (!"admin".equals(user.getRole().toLowerCase())) {
			response.sendRedirect("LoginController?action=login&error=unauthorized");
			return;
		}

		// Reload dashboard with current data
		redirectBasedOnRole(user, request, response);
	}

	private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Invalidate session
		HttpSession session = request.getSession(false);
		if (session != null) {
			System.out.println("Logging out user: " + session.getAttribute("username"));
			session.invalidate();
		}

		// Clear remember me cookie
		Cookie rememberCookie = new Cookie("rememberedUser", "");
		rememberCookie.setMaxAge(0);
		rememberCookie.setPath("/");
		response.addCookie(rememberCookie);

		// Redirect to login
		response.sendRedirect("LoginController?action=login&message=logged_out");
	}

	private void showHelpPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/View/admin-help.jsp").forward(request, response);
	}
}