package com.ohwrite.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.SessionFactory;

import com.ohwrite.dao.LikeDao;
import com.ohwrite.dao.PostDao;
import com.ohwrite.dao.UserDao;
import com.ohwrite.entities.Post;
import com.ohwrite.entities.User;
import com.ohwrite.helper.FactoryProvider;

public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		PostDao pd = null;
		Post post = null;
		User user = null;

		try {
			boolean f = false;
			HttpSession hs = request.getSession();
			user = (User) hs.getAttribute("currentUser");

			String operation = request.getParameter("operation");
			int pid = Integer.parseInt(request.getParameter("pid"));

			pd = new PostDao(FactoryProvider.getFactory());

			post = pd.getPostByPostId(pid);

			LikeDao ldao = new LikeDao(FactoryProvider.getFactory());

			if (!ldao.checkUserLike(post, user)) {

				if (operation.equals("like")) {
					f = ldao.insertLike(user, post);

					out.println("liked");
					return;
				}
			} else {
				ldao.deleteLike(post, user);
				out.println("disliked");
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
