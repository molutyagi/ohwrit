package com.ohwrite.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ohwrite.dao.UserDao;
import com.ohwrite.entities.Message;
import com.ohwrite.entities.User;
import com.ohwrite.helper.FactoryProvider;
import com.ohwrite.security.SaltingAndHashing;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserDao dao = null;
		SaltingAndHashing sah = new SaltingAndHashing();

		try {
			HttpSession hs = request.getSession();

			// fetch all form data
			String check = request.getParameter("check");
			if (check == null) {
				Message msg = new Message("Terms & conditions not accepted.", "error", "alert-danger");
				hs.setAttribute("message", msg);
				return;
			}

			else {
				String name = request.getParameter("user_name");
				String email = request.getParameter("user_email");
				String password = request.getParameter("user_password");
				String gender = request.getParameter("gender");
				String about = request.getParameter("about");

				byte[] salt = sah.generateSalt();
				String hashedPassword = sah.texttoHash(password, salt);

				// create user object and set all data to that object..
				User user = new User(name, email, hashedPassword, gender, about,
						Base64.getEncoder().encodeToString(salt));

				// save user through userdao
				dao = new UserDao(FactoryProvider.getFactory());
				dao.saveUser(user);
				dao.closeSession();
				out.println("done");
				Message msg = new Message("User Registered Successfully.", "success", "alert-success");
				hs.setAttribute("message", msg);
				response.sendRedirect("login"); 

			}
		} catch (Exception e) {
			dao.txRollback();
			e.printStackTrace();
			out.println("error");
		}
	}

}
