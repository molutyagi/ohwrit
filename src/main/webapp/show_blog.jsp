<%@page import="com.ohwrite.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.ohwrite.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ohwrite.entities.Category"%>
<%@page import="com.ohwrite.entities.Category"%>
<%@page import="com.ohwrite.dao.PostDao"%>
<%@page import="com.ohwrite.entities.Post"%>
<%@page import="com.ohwrite.entities.User"%>

<%
User user = (User) session.getAttribute("currentUser");
%>

<%
int postId = Integer.parseInt(request.getParameter("post_id"));
PostDao d = new PostDao(FactoryProvider.getFactory());
Post p = d.getPostByPostId(postId);
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=p.getpTitle()%> || Oh!Write</title>

<!--css-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="static/css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
}

.post-title {
	font-weight: 100;
	font-size: 30px;
}

.post-content {
	font-weight: 100;
	font-size: 25px;
}

.post-date {
	font-style: italic;
	font-weight: bold;
}

.post-user-info {
	font-size: 20px;
}

.row-user {
	border: 1px solid #e2e2e2;
	padding-top: 15px;
}

body {
	background: url(static/imgs/bg.jpeg);
	background-size: cover;
	background-attachment: fixed;
}
</style>

</head>
<body style="background-color: #aaa">

	<!--navbar-->
	<%@include file="navbar.jsp"%>
	<!--end of navbar-->

	<!--main content of body-->


	<div class="container">
		<div class="row my-4">
			<div class="col-md-8 offset-md-2">
				<div class="card">

					<!--card header-->
					<div class="card-header primary-background text-white">
						<h4 class="post-title"><%=p.getpTitle()%></h4>
					</div>

					<!--card body-->
					<div class="card-body">
						<img class="card-img-top my-2"
							src="dynamic/blogimg/<%=p.getpPic()%>" alt="Card image cap">
						<div class="row my-3 row-user">
							<div class="col-md-8">
								<%
								UserDao ud = new UserDao(FactoryProvider.getFactory());
								%>
								<p class="post-user-info">
									<a href="#!"> <%=p.getAuthorId().getName()%>
									</a> has posted :
								</p>
							</div>
							<div class="col-md-4">
								<p class="post-date">
									<%=DateFormat.getDateTimeInstance().format(p.getpDate())%>
								</p>
							</div>
						</div>
						<p class="post-content" style="white-space: pre-wrap;"><%=p.getpContent()%></p>
						<br> <br>
						<div class="post-code">
							<pre><%=p.getpCode()%></pre>
						</div>
					</div>

					<!--card footer-->
					<div class="card-footer primary-background">
						<%
						LikeDao ld = new LikeDao(FactoryProvider.getFactory());
						%>
						<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)"
							class="btn btn-outline-light btn-sm"> <i
							class="fa fa-thumbs-o-up"></i> <span
							class="like-counter<%=p.getPid()%>"><%=ld.countLikeOnPost(p)%></span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--end of main content  of body-->


	<!--javascripts-->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script src="static/js/myjs.js" type="text/javascript"></script>
</body>
</html>