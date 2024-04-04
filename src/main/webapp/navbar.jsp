
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="java.util.List"%>
<%@page import="com.ohwrite.helper.FactoryProvider"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ohwrite.entities.Category"%>
<%@page import="com.ohwrite.dao.PostDao"%>
<%@page import="com.ohwrite.entities.Message"%>
<%@page import="com.ohwrite.entities.User"%>

<link rel="stylesheet" type="text/css" href="static/css/util.css">
<link rel="stylesheet" type="text/css" href="static/css/login.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="static/css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<nav
	class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
	<a class="navbar-brand" href="index"> <span class="fa fa-book"></span>
		Oh! Write
	</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="index">
					<span class="	fa fa-bell-o"></span> Home <span class="sr-only">(current)</span>
			</a></li>

			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <span class="	fa fa-check-square-o"></span>
					Categories
			</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<!--categories-->
					<%
					PostDao dao_profile = new PostDao(FactoryProvider.getFactory());
					List<Category> list1 = dao_profile.getAllCategories();
					for (Category cc : list1) {
					%>
					<a href="profile" onclick="getPosts(<%=cc.getCid()%>, this)"
						class=" c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
					<%
					}
					%>
				</div></li>

			<li class="nav-item"><a class="nav-link" href="about"> <span
					class="	fa fa-address-card-o"></span> About
			</a></li>

			<%
			User user_profile = (User) session.getAttribute("currentUser");
			String textUrl = request.getRequestURI().toString();

			if (user_profile != null) {
				if (textUrl.equals("/ohwrite/profile")) {
			%>
			<li class="nav-item"><a class="nav-link" href="#"
				data-toggle="modal" data-target="#add-post-modal"> <span
					class="	fa fa-asterisk"></span> Do Post
			</a></li>

			<li class="nav-item"><a class="nav-link" href="#!"
				data-toggle="modal" data-target="#profile-modal"> <span
					class="fa fa-user-circle"></span> <%=user_profile.getName()%>
			</a></li>
			<%
			} else {
			%>
			<li class="nav-item"><a class="nav-link" href="profile"> <span
					class="fa fa-user-circle "> </span> <%=user_profile.getName()%>
			</a></li>

			<%
			}
			%>
			<li class="nav-item"><a class="nav-link" href="logoutservlet">
					<span class="fa fa-user-plus "></span> Logout
			</a></li>
			<%
			} else {
			%>

			<li class="nav-item"><a class="nav-link" href="login"> <span
					class="fa fa-user-circle "></span> Login
			</a></li>
			<li class="nav-item"><a class="nav-link" href="register"> <span
					class="fa fa-user-plus "></span> Sign up
			</a></li>
			<%
			}
			%>

		</ul>
		<form class="form-inline my-2 my-lg-0">
			<input class="form-control mr-sm-2" type="search"
				placeholder="Search" aria-label="Search">
			<button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
		</form>
	</div>
</nav>
