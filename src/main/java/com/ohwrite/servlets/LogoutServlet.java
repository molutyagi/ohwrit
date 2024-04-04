package com.ohwrite.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ohwrite.entities.Message;

public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {

			// remove session
			HttpSession hs = request.getSession();
			hs.removeAttribute("currentUser");

//			 remove cookie if it exists
			Cookie loginCookie = new Cookie("rememberUser", "");
			loginCookie.setMaxAge(0);
			response.addCookie(loginCookie);

			response.sendRedirect("login");

			Message msg = new Message("Logged out Successfully. Visit again.", "success", "alert-success");
			hs.setAttribute("message", msg);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
