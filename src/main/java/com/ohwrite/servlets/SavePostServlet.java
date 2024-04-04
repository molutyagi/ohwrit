package com.ohwrite.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.ohwrite.dao.PostDao;
import com.ohwrite.entities.Category;
import com.ohwrite.entities.Post;
import com.ohwrite.entities.User;
import com.ohwrite.helper.FactoryProvider;
import com.ohwrite.helper.Helper;

@MultipartConfig
public class SavePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {

			int cid = 0;

			String cidString = request.getParameter("cid");
			if (cidString != null) {
				cid = Integer.parseInt(cidString);
				String pTitle = request.getParameter("pTitle");
				String pContent = request.getParameter("pContent");
				String pCode = request.getParameter("pCode");
				Part part = request.getPart("pic");

//            getting currentuser
				HttpSession session = request.getSession();
				User user = (User) session.getAttribute("currentUser");

				PostDao pd = new PostDao(FactoryProvider.getFactory());
				Category category = (Category) pd.getCatByCatId(cid);
				Post p = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), category, user);

				if (pd.savePost(p)) {

					String path = request.getRealPath("/") + "dynamic/blogimg" + File.separator
							+ part.getSubmittedFileName();
					Helper.saveFile(part.getInputStream(), path);

					out.println("done");
				} else {
					out.print("error");
				}
			} else {
				out.println("Kindly Select Post Category");

			}

		} catch (

		Exception e) {
			e.printStackTrace();
		}
	}

}
