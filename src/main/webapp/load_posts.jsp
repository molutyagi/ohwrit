
<%@page import="com.ohwrite.entities.Category"%>
<%@page import="com.ohwrite.helper.FactoryProvider"%>
<%@page import="com.ohwrite.dao.LikeDao"%>
<%@page import="com.ohwrite.entities.User"%>
<%@page import="com.ohwrite.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.ohwrite.dao.PostDao"%>

<div class="row">

	<%
	User uuu = (User) session.getAttribute("currentUser");

	Thread.sleep(1000);
	PostDao d = new PostDao(FactoryProvider.getFactory());

	int cid = Integer.parseInt(request.getParameter("cid"));
	List<Post> post = null;
	if (cid == 0) {
		post = d.getAllPosts();
	} else {
		Category cat = d.getCatByCatId(cid);
		post = d.getPostByCat(cat);
	}

	if (post.size() == 0) {
		out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
		return;
	}

	for (Post p : post) {
	%>

	<!--<div class="col-md-5 mt-1" style="height: 75%; width: 76%">-->
	<div class="card mr-4 mb-4" style="min-height: 20%; width: 45%">
		<img style="height: 15rem;" class="card-img-top"
			src="dynamic/blogimg/<%=p.getpPic()%>" alt="Card image cap">
		<div class="card-body">
			<%
			String title = p.getpTitle();
			if (title.length() >= 50) {
				title = title.substring(0, 50);
			}
			%>

			<b><%=title%></b>
			<%
			String content = new String(p.getpContent());
			if (content.length() >= 100) {
				content = content.substring(0, 200) + "<strong >...</strong>";
			}
			%>
			<p style="max-width: 200ch"><%=content%></p>
		</div>


		<div class="card-footer primary-background text-center">
			<%
			LikeDao ld = new LikeDao(FactoryProvider.getFactory());
			%>
			<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=uuu.getId()%>)"
				class="btn btn-outline-light btn-sm"> <i
				id="liker<%=p.getPid()%>" class="fa fa-thumbs-o-up"></i> <span
				class="like-counter<%=p.getPid()%>"><%=ld.countLikeOnPost(p)%></span>
			</a> <a href="blog?post_id=<%=p.getPid()%>"
				class="btn btn-outline-light btn-sm">Read More...</a>
			<!--<a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-commenting-o"></i> <span>20</span>  </a>-->
		</div>
	</div>
	<!--</div>-->
	<%
	}
	%>

</div>
<script src="static/js/myjs.js" type="text/javascript"></script>
