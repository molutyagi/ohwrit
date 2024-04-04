package com.ohwrite.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ohwrite.dao.UserDao;
import com.ohwrite.entities.Message;
import com.ohwrite.entities.User;
import com.ohwrite.helper.FactoryProvider;
import com.ohwrite.security.SaltingAndHashing;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserDao dao = null;
		User user = null;
		SaltingAndHashing sah = new SaltingAndHashing();
		try {

			// fetch username and password from request
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String remember = request.getParameter("remember");

			dao = new UserDao(FactoryProvider.getFactory());
			user = dao.getUserByEmail(email);

			byte[] salt = Base64.getDecoder().decode(user.getSalt());

			String hashedPassword = sah.texttoHash(password, salt);

			// validate user and log in
			if (user != null && user.getPassword().equals(hashedPassword)) {
				HttpSession hs = request.getSession();
				hs.setAttribute("currentUser", user);
				dao.closeSession();

				// if user wants to stay logged in
				if (remember != null) {
					// set cookies
					Cookie loginCookie = new Cookie("rememberUser", email);
					loginCookie.setMaxAge(30 * 24 * 60 * 60); // 30days
					response.addCookie(loginCookie);
				}

				response.sendRedirect("profile");
			} else {
				Message msg = new Message("Invalid details! Try again.", "error", "alert-danger");
				HttpSession hs = request.getSession();
				hs.setAttribute("message", msg);
				response.sendRedirect("login");
			}

		} catch (Exception e) {
//			dao.txRollback();
			e.printStackTrace();
			out.println("error");
		}
	}

}
