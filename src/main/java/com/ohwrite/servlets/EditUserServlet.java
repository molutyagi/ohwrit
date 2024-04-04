package com.ohwrite.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ohwrite.dao.UserDao;
import com.ohwrite.entities.Message;
import com.ohwrite.entities.User;
import com.ohwrite.helper.FactoryProvider;
import com.ohwrite.helper.Helper;
import com.ohwrite.security.SaltingAndHashing;

@MultipartConfig
public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		SaltingAndHashing sah = new SaltingAndHashing();

		try {

			// get user from session
			HttpSession hs = request.getSession();
			User user = (User) hs.getAttribute("currentUser");

			String imageName = null;
			// fetch data to edit
			String name = request.getParameter("user_name");
			String email = request.getParameter("user_email");
			String password = request.getParameter("user_password");
			String about = request.getParameter("user_about");
			Part part = request.getPart("image");

			imageName = part.getSubmittedFileName();

			// edit user values
			user.setEmail(email);
			user.setName(name);
			if (!password.equals("")) {
				byte[] salt = sah.generateSalt();
				String hashedPassword = sah.texttoHash(password, salt);
				user.setPassword(hashedPassword);
				user.setSalt(Base64.getEncoder().encodeToString(salt));
			}
			user.setAbout(about);
			String oldProfile = user.getProfile();
			if (imageName != "") {
				user.setProfile(imageName);
			} else {
				user.setProfile(oldProfile);
			}

			// update database
			UserDao dao = new UserDao(FactoryProvider.getFactory());
			boolean ans = dao.updateUser(user);
			if (ans == true) {
				// change new profile in directory
				String path = request.getRealPath("/" + "dynamic/profileimg" + File.separator + user.getProfile());
				String oldPath = request.getRealPath("/" + "dynamic/profileimg" + File.separator + oldProfile);

				if (imageName != "") {
					if (!oldProfile.equals("default.png")) {
						Helper.deleteFile(oldPath);
					}
					if (Helper.saveFile(part.getInputStream(), path)) {
						Message msg = new Message("User Updated Successfully.", "success", "alert-success");
						hs.setAttribute("message", msg);
					} else {
						Message msg = new Message("Couldn't Update User.", "error", "alert-danger");
						hs.setAttribute("message", msg);
					}
				}
			} else {
				Message msg = new Message("Couldn't Update User.", "error", "alert-danger");
				hs.setAttribute("message", msg);
			}
			response.sendRedirect("profile");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
