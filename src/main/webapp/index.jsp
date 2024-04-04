<%@page import="com.ohwrite.dao.UserDao"%>
<%@page import="com.ohwrite.helper.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.ohwrite.dao.PostDao"%>
<%@page import="com.ohwrite.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.ohwrite.entities.User"%>
<%@page import="com.ohwrite.entities.Post"%>
<%@page import="java.util.List"%>


<%
User user_home = null;
HttpSession hs = request.getSession();

if (hs.getAttribute("currentUser") != null) {
	user_home = (User) hs.getAttribute("currentUser");
} else {
	Cookie[] cookies = request.getCookies();

	if (cookies != null) {
		for (Cookie cookie : cookies) {
	if (cookie.getName().equals("rememberUser")) {

		// get cookie value
		String email = cookie.getValue();

		// get user from email
		UserDao dao = new UserDao(FactoryProvider.getFactory());
		user_home = dao.getUserByEmail(email);

		// set session to user
		hs.setAttribute("currentUser", user_home);
	}
		}
	}
}
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Oh! Write</title>

<!--CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="static/css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="static/css/util.css">
<link rel="stylesheet" type="text/css" href="static/css/login.css">

<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
	background: #9053c7;
	background: -webkit-linear-gradient(-135deg, #c850c0, #4158d0);
	background: -o-linear-gradient(-135deg, #c850c0, #4158d0);
	background: -moz-linear-gradient(-135deg, #c850c0, #4158d0);
	background: linear-gradient(-135deg, #c850c0, #4158d0);
	background-size: cover;
	background-attachment: fixed;
}

body {
	background-color: #aaa;
}

.card {
	border-radius: 1rem;
	margin-bottom: 1rem;
}
</style>

</head>
<body>

	<!--navbar-->
	<%@include file="navbar.jsp"%>
	<!--//banner-->

	<div class="container-fluid p-0 m-0">
		<div class="jumbotron text-white banner-background">
			<div class="container">
				<h3 class="display-3">Welcome to Oh! Write</h3>

				<p style="color: white;">
					Welcome to Oh! Write, world of words. Oh! Write gives you a totally
					different and independent platform to showcase whatever you think,
					it's a canvas for your thoughts.<br>
					<!-- comment -->
					Rest lorem ipsum for you Lorem ipsum, dolor sit amet consectetur
					adipisicing elit. Quia voluptatibus quasi earum iste a saepe amet
					obcaecati reprehenderit temporibus, nemo, deleniti corporis magni
					corrupti, ut nulla ducimus minus voluptates ipsa!

				</p>
				<p style="color: white;">some more lorem Lorem ipsum, dolor sit
					amet consectetur adipisicing elit. Quia voluptatibus quasi earum
					iste a saepe amet obcaecati reprehenderit temporibus, nemo,
					deleniti corporis magni corrupti, ut nulla ducimus minus voluptates
					ipsa!</p>
				<%
				if (user_home == null) {
				%>
				<br> <a href="register"><button
						class="btn btn-outline-light btn-lg">
						<span class="fa fa fa-user-plus"></span> Start ! its Free
					</button></a> <a href="login" class="btn btn-outline-light btn-lg"> <span
					class="fa fa-user-circle fa-spin"></span> Login
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<!--//cards-->
	<div class="container">
		<div class="row mb-2">
			<%
			PostDao d = new PostDao(FactoryProvider.getFactory());
			List<Post> posts = null;
			posts = d.getAllPosts();

			for (Post p : posts) {
			%>
			<div class="col-md-4" style="background: #fff;">
				<div class="card ">
					<div class="card-body" style="min-height: 250px;">
						<%
						Category cat = p.getCatId();
						%>
						<h5 class="card-title"><%=cat.getName()%></h5>
						<%
						String title = p.getpTitle();
						if (title.length() >= 220) {
							title = title.substring(0, 220);
						}
						%>
						<hr>
						<p class="card-text"><%=title%><strong> . . .</strong>"
						</p>
					</div>
					<a href="blog?post_id=<%=p.getPid()%>"
						class="btn primary-background text-white">Read more</a>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>




	<!--JavaScript-->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
	<script src="static/js/newjavascript.js" type="text/javascript"></script>
</body>
</html>