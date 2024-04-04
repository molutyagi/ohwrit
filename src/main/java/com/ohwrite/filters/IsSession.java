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


public class IsSession implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession hs = req.getSession();
		
		

		System.out.println("isSession/n");

		if (hs.getAttribute("currentUser") != null) {

			System.out.println("session founddddddd/n");
			chain.doFilter(request, response);
			return;
		} else {

			chain.doFilter(request, response);

//			Message msg = new Message("Kindly login first.", "error", "alert-danger");
//			hs.setAttribute("message", msg);
//			res.sendRedirect("login");
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {

	}

}
