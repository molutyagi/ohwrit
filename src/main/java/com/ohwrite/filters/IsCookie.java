package com.ohwrite.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ohwrite.dao.UserDao;
import com.ohwrite.entities.Message;
import com.ohwrite.entities.User;
import com.ohwrite.helper.FactoryProvider;

public class IsCookie implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession hs = req.getSession();
		User user = null;
		UserDao dao = null;

		System.out.println("isCookieeeeeeee/n");
		Cookie[] cookies = req.getCookies();
		
		
		if (cookies != null) {
			System.out.println("if cookie");
			for (Cookie cookie : cookies) {
				System.out.println("for cookie");
				if (cookie.getName().equals("rememberUser")) {

					System.out.println("Cookie founddddddddddddd/n");
					// get cookie value
					String email = cookie.getValue();

					// get user from email
					dao = new UserDao(FactoryProvider.getFactory());
					user = dao.getUserByEmail(email);

					// set session to user
					hs.setAttribute("currentUser", user);
					dao.closeSession();

					chain.doFilter(request, response);
					return;
				}
			}
		} else {

			System.out.println("no cookieeeeeeeeeeeeeeeee/n");

			Message msg = new Message("Kindly login first.", "error", "alert-danger");
			hs.setAttribute("message", msg);
			res.sendRedirect("login");
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {

	}

}
