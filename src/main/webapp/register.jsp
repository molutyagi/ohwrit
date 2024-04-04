<%@page import="com.ohwrite.entities.Message"%>

<%
User user = (User) session.getAttribute("currentUser");
if (user != null) {
	response.sendRedirect("profile");
}
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Register</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="static/images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="static/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="static/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="static/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="static/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="static/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="static/css/util.css">
<link rel="stylesheet" type="text/css" href="static/css/login.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="static/css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!--===============================================================================================-->
</head>

<body>

	<!--navbar-->
	<%@include file="navbar.jsp"%>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-register100">
				<div class="login100-pic js-tilt" data-tilt>
					<img src="static/images/img-01.png" alt="IMG">
				</div>

				<form action="registerservlet" method="post"
					class="login100-form validate-form">
					<span class="login100-form-title"> User Registration </span>

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
					<div class="wrap-input100 validate-input">
						<input class="input100" type="text" name="user_name"
							placeholder="Name" required="required"> <span
							class="focus-input100"></span> <span class="symbol-input100">
							<i class="fa fa-user" aria-hidden="true"></i>
						</span>
					</div>
					<div class="wrap-input100 validate-input"
						data-validate="Valid email is required: ex@abc.xyz">
						<input class="input100" type="email" name="user_email"
							placeholder="Email" required="required"> <span
							class="focus-input100"></span> <span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input"
						data-validate="Password is required">
						<input class="input100" type="password" name="user_password"
							placeholder="Password" required="required"> <span
							class="focus-input100"></span> <span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100">
						<div class='p-t-0 m-b-10 input100'>
							<input class="input90 m-t-18 p-r-5" type="radio" id="gender"
								name="gender" value="male" required>Male <input
								class="input90" type="radio" id="gender" name="gender"
								value="female" required>Female
						</div>
					</div>
					<br>
					<div class="wrap-input100">
						<label for="gender" class=" ">Enter something about
							yourself:</label>
						<textarea name="about" class="form-control input100" id=""
							rows="5" required></textarea>
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100">
						<div class="form-check  ">
							<input name="check" required="required" type="checkbox"
								class="form-check-input" id="exampleCheck1"> <label
								class="form-check-label" for="exampleCheck1">agree terms
								and conditions</label>
						</div>
						<span class="focus-input100"></span>
					</div>

					<div class="container-login100-form-btn">
						<button type="submit" class="login100-form-btn">Register
						</button>
					</div>

					<div class="text-center p-t-16">
						<a class="txt2" href="login"> Already a user? Login here. <i
							class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
						</a>
					</div>


				</form>
			</div>
		</div>
	</div>
	<!--===============================================================================================-->
	<script src="static/vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="static/vendor/bootstrap/js/popper.js"></script>
	<script src="static/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="static/vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="static/vendor/tilt/tilt.jquery.min.js"></script>
	<script>
		$('.js-tilt').tilt({
			scale : 1.1
		})
	</script>
	<!--===============================================================================================-->
	<script src="static/js/login.js"></script>
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
	<script src="static/js/myjs.js" type="text/javascript"></script>


</body>

</html>