<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>

	<link
		href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
		rel="stylesheet" id="bootstrap-css">
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script
		src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!------ Include the above in your HEAD tag ---------->

	<style>
body {
	margin: 0;
	padding: 0;
	background-color: #17a2b8;
	height: 100vh;
}

#login .container #login-row #login-column #login-box {
	margin-top: 120px;
	max-width: 600px;
	height: 320px;
	border: 1px solid #9C9C9C;
	background-color: #EAEAEA;
}

#login .container #login-row #login-column #login-box #login-form {
	padding: 20px;
}

#login .container #login-row #login-column #login-box #login-form #register-link
	{
	margin-top: -85px;
}

label {
	display: inline-block;
}
</style>
<body>
	<div id="login">
		<h3 class="text-center text-white pt-5">Login form</h3>
		<div class="container">
			<div id="login-row"
				class="row justify-content-center align-items-center">

				<div id="login-column" class="col-md-6">
					<b><center>
							<p id="failedStatusMsg" style="color: yellow"></p>
						</center></b>
					<div id="login-box" class="col-md-12" style="margin-top: 50px;">

						<form id="login-form" class="form" action="" method="post">
							<h3 class="text-center text-info">Login</h3>
							<div class="form-group">
								<label for="username" class="text-info">Username:</label><br>
								<input type="text" name="userName" id="userName"
									class="form-control" autocomplete="off" placeholder="USERNAME/MOBILE/EMAIL"> <b><span
									id="userNameError" style="font-size: 10px; color: red"></span></b>
							</div>
							<div class="form-group">
								<label for="password" class="text-info">Password:</label><br>
								<input type="password" name="password" id="password"
									class="form-control" autocomplete="off"> <b><span
									id="passwordError" style="font-size: 10px; color: red"></span></b>
							</div>
							<div class="form-group">
								<!--<label for="remember-me" class="text-info">
								 <span>Remember me</span> 
								 <span><input id="remember-me" name="remember-me"
										type="checkbox"></span></label>-->
								<br> <input type="button" name="submit"
									class="btn btn-info btn-md" id="loginButtonId" value="submit"
									onclick="login()">
							</div>
							<div id="register-link" class="text-right">
								<a href="signup.jsp" class="text-info">Register here</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</body>

<script type="text/javascript">
//	$(document).ready(function() {

		$("#login-form").keyup(function(event) {
			if (event.keyCode == '13') {
				login();
			}
		});
	//});

	function login() {

		$("#userNameError").text("");
		$("#passwordError").text("");

		var userName = $("#userName").val();
		var password = $("#password").val();

		var isValidationPassed = true;
		if (userName == null || userName.trim() == "") {
			$("#userNameError").text("user name can't be empty");
			isValidationPassed = false;
		} else if (password == null || password.trim() == "") {
			$("#passwordError").text("password can't be empty");
			isValidationPassed = false;
		}

		if (isValidationPassed) {

			var formData = {
				userName : $("#userName").val(),
				password : $("#password").val()
			};

			$.ajax({
				type : "post",
				// encode: true,
				url : "login",
				//dataType: "html",
				data : formData,
				// contentType: "json",
				success : function(responseData, textStatus, jqXHR) {
					console.log("data saved");
					if (responseData == "SUCCESS") {
						window.location.href = "profile.jsp";
					} else {
						$("#failedStatusMsg").text(
								"Incorrect username/password");
						$("#failedStatusMsg").focus();

					}

				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(errorThrown);
				}
			})
		}

	}
</script>
</html>