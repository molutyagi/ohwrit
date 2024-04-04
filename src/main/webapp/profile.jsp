
<%@page import="java.util.List"%>
<%@page import="com.ohwrite.helper.FactoryProvider"%>
<%@page import="com.ohwrite.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ohwrite.dao.PostDao"%>
<%@page import="com.ohwrite.entities.Message"%>
<%@page import="com.ohwrite.entities.User"%>


<%
User user = (User) session.getAttribute("currentUser");
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=user.getName()%> || Oh!Write</title>

<!--css-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="static/css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="static/css/util.css">

<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
}
</style>
</head>
<body style="background-color: #aaa !important">

	<!--navbar-->
	<%@include file="navbar.jsp"%>
	
	<%
	Message m = (Message) session.getAttribute("message");
	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%>" role="alert">
		<%=m.getContent()%>
	</div>

	<%
	session.removeAttribute("message");
	}
	%>


	<!--main body of the page-->
	<main class="container">
		<div class="row mt-4">
			<!--first col-->
			<div class="col-md-4">
				<!--categories-->
				<div class="list-group primary-background">
					<a href="#" onclick="getPosts(0, this)"
						class=" c-link list-group-item list-group-item-action active">
						All Posts </a>
					<!--categories-->
					<%
					for (Category cc : list1) {
					%>
					<a href="#" onclick="getPosts(<%=cc.getCid()%>, this)"
						class=" c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
					<%
					}
					%>
				</div>
			</div>

			<!--second col-->
			<div class="col-md-8">
				<!--posts-->
				<div class="container text-center" id="loader">
					<i class="fa fa-refresh fa-4x fa-spin"></i>
					<h3 class="mt-2">Loading...</h3>
				</div>
				<div class="container-fluid" id="post-container"></div>
			</div>
		</div>
	</main>
	<!--end main body of the page-->




	<!--profile modal-->
	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">Oh! Write</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="dynamic/profileimg/<%=user.getProfile()%>"
							class="img-fluid" style="border-radius: 50%; max-width: 150px;">
						<br>
						<h5 class="modal-title mt-3" id="exampleModalLabel">
							<%=user.getName()%>
						</h5>
						<!--//details-->

						<div id="profile-details">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>

									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>

									</tr>
									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getrDate().toString()%></td>

									</tr>
								</tbody>
							</table>
						</div>


						<!--profile edit-->
						<div id="profile-edit" style="display: none;">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="edituserservlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID :</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>New Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="">
										</td>
									</tr>
									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<td>About :</td>
										<td><textarea rows="3" class="form-control"
												name="user_about"><%=user.getAbout()%>
                                                </textarea></td>
									</tr>
									<tr>
										<td>New Profile:</td>
										<td><input type="file" name="image" class="form-control">
										</td>
									</tr>
								</table>
								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">EDIT</button>
				</div>
			</div>
		</div>
	</div>
	<!--end of profile modal-->


	<!--add post modal-->
	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						post details...</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="savepostservlet" method="post"
						enctype="multipart/form-data">

						<div class="form-group">
							<select class="form-control" name="cid" required="required">
								<option selected disabled>---Select Category---</option>

								<%
								for (Category c : list1) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>

								<%
								}
								%>
							</select>
						</div>
						<div class="form-group">
							<input name="pTitle" type="text" placeholder="Enter post Title"
								class="form-control" required="required" />
						</div>
						<div class="form-group">
							<textarea name="pContent" class="form-control"
								style="height: 200px;" placeholder="Enter your content"
								required="required"></textarea>
						</div>
						<div class="form-group">
							<textarea name="pCode" class="form-control"
								style="height: 200px;" placeholder="Enter your program (if any)"></textarea>
						</div>
						<div class="form-group">
							<label>Select your pic...</label> <br> <input type="file"
								name="pic" required="required">
						</div>
						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!--END add post modal-->

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

	<script>
                            $(document).ready(function () {
                                let editStatus = false;

                                $('#edit-profile-button').click(function ()
                                {

                                    if (editStatus == false)
                                    {
                                        $("#profile-details").hide()

                                        $("#profile-edit").show();
                                        editStatus = true;
                                        $(this).text("Back")
                                    } else
                                    {
                                        $("#profile-details").show()

                                        $("#profile-edit").hide();
                                        editStatus = false;
                                        $(this).text("Edit")

                                    }


                                })
                            });

        </script>
	<!--now add post js-->
	<script>
            $(document).ready(function (e) {
                //
                $("#add-post-form").on("submit", function (event) {
                    //this code gets called when form is submitted....
                    event.preventDefault();
                    console.log("you have clicked on submit..")
                    let form = new FormData(this);
                    //now requesting to server
                    $.ajax({
                        url: "savepostservlet",
                        type: 'post',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success ..
                            console.log(data);
                            if (data.trim() == 'done')
                            {
                                swal("Good job!", "saved successfully", "success")
                                        .then((value) => {
                                            window.location = "profile";
                                        });
                            } else
                            {
                                swal(data, "Something went wrong try again...", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error..
                            swal("Error!!", "Something went wrong try again...", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>

	<!--
                loading post using ajax
        -->
	<script>

            function getPosts(catId, temp) {
                $("#loader").show();
                $("#post-container").hide()

                $(".c-link").removeClass('active')

                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        $("#loader").hide();
                        $("#post-container").show();
                        $('#post-container').html(data)
                        $(temp).addClass('active')
                    }
                })
            }

            $(document).ready(function (e) {

                let allPostRef = $('.c-link')[0]
                getPosts(0, allPostRef)
            })
        </script>

</body>
</html>