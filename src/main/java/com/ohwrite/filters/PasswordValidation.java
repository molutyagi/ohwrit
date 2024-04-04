package com.ohwrite.filters;

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

import com.ohwrite.entities.Message;

public class PasswordValidation implements Filter {
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		final int MIN_LENGTH = 8;
		final String PASSWORD_REGEX = "^(?=.*[a-zA-Z])(?=.*[0-9]).{" + MIN_LENGTH + ",}$";

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession hs = req.getSession();

		String uri = req.getRequestURI().toString();

		String password = req.getParameter("user_password");
		if (uri.equals("/ohwrite/edituserservlet") && password.equals("")) {
			chain.doFilter(request, response);
		} else if (!password.matches(PASSWORD_REGEX)) {
			Message msg = new Message("Password doesn't match the criteria, Try again.", "error", "alert-danger");
			hs = req.getSession();
			hs.setAttribute("message", msg);

			if (uri.equals("/ohwrite/edituserservlet")) {
				res.sendRedirect("profile");
				return;
			} else {
				res.sendRedirect("register");
				return;
			}
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
