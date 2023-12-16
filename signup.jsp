<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SignUp</title>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>



<style>
.tooltip {
	display: none;
	background-color: yellow;
	color: black;
	position: absolute;
}
</style>


<body>

	<section class="vh-100" style="background-color: #eee;">
		<div class="container h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-lg-12 col-xl-11">
					<div class="card text-black" style="border-radius: 25px;">
						<div class="card-body p-md-5">

							<form action="${pageContext.request.contextPath}/save-user"
								method="post">

								<b><p id="sucessStatusMsg"></p></b>


								<div class="row justify-content-center" id="signupDivId">
									<div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1"
										style="margin-top: -70px">

										<p class="text-center h1 fw-bold mb-3 mx-1 mx-md-4 mt-4">Sign
											up</p>


										<b><p id="failedStatusMsg"></p></b>

										<div class="d-flex flex-row align-items-center mb-3">
											<i class="fas fa-user fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="firstName" name="firstName"
													class="form-control" placeholder="First Name"
													maxlength="45"
													onkeypress="return blockSpecialCharAndNumbers(event)"
													autocomplete="off" /> <b><span id="firstNameError"
													style="font-size: 10px; color: red"></span></b>
											</div>


										</div>



										<div class="d-flex flex-row align-items-center mb-3">
											<i class="fas fa-user fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="lastName" name="lastName"
													class="form-control" placeholder="Last Name" maxlength="45"
													onkeypress="return blockSpecialCharAndNumbers(event)"
													autocomplete="off" /> <b><span id="lastNameError"
													style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-3">
											<i class="fas fa-user fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<select id="userType" name="userType" class="form-control">
													<option value="NA">Select User Type</option>
													<option value="TA Applicant">TA Applicant</option>
													<option value="TA Admin">TA Admin</option>
													<option value="TA Committee">TA Committee</option>
													<option value="TA Instructor">TA Instructor</option>
												</select> <b><span id="userTypeError"
													style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-3"
											id="mobileNumberTooltip">
											<i class="fas fa-user fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="mobileNumber" name="mobileNumber"
													class="form-control" placeholder="Mobile Number"
													title="only numbers allowed" autocomplete="off" /> <b><span
													id="mobileNumberError" style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-3">
											<i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="email" id="emailAddress" name="emailAddress"
													class="form-control" placeholder="Email Address"
													maxlength="45" autocomplete="off" /> <b><span
													id="emailAddressError" style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-3">
											<i class="fas fa-user fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="userName" name="userName"
													class="form-control" placeholder="User Name" maxlength="15"
													onkeypress="return blockSpecialChar(event)"
													autocomplete="off" /> <b><span id="userNameError"
													style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-3">
											<i class="fas fa-lock fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="password" id="password" name="password"
													class="form-control" placeholder="Password" maxlength="45"
													autocomplete="off" /> <b><span id="passwordError"
													style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-3">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="password" id="repassword" name="repassword"
													class="form-control" placeholder="Repeat your password"
													maxlength="45" autocomplete="off" />
											</div>
										</div>

										<div class="form-check d-flex justify-content-center"
											style="margin-left: -10px">
											<input class="form-check-input me-2" type="checkbox" value=""
												id="agreeStmtCheckboxId" style="margin-left: -350px" />
											<p style="margin-left: -110px">
												I agree to <a href="terms-and-conditions.html">Terms & Conditions</a>
											</p>
										</div>

										<div class="d-flex justify-content-center mx-4 mb-2 mb-lg-4">
											<button type="button" class="btn btn-primary btn-md"
												onclick="saveUserDetails()">Sign Up</button>
											&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<a href="login.jsp">Already
												have an account?</a>
										</div>


									</div>


									<div
										class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">

										<img
											src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
											class="img-fluid" alt="Sample image">

									</div>

								</div>

							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

</body>

<script type="text/javascript">
	function saveUserDetails() {

		if (signUpValidation()) {

			var formData = {
				firstName : $("#firstName").val(),
				lastName : $("#lastName").val(),
				mobileNumber : $("#mobileNumber").val(),
				emailAddress : $("#emailAddress").val(),
				userType : $("#userType").val(),
				password : $("#password").val(),
				userName : $("#userName").val()
			};
			$.ajax({
				type : "post",
				// encode: true,
				url : "save-user",
				//dataType: "html",
				data : formData,
				// contentType: "json",
				success : function(responseData, textStatus, jqXHR) {
					console.log("data saved");
					//alert(responseData);
					if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
						//alert("=====11======")
						window.location.href = "signup-success.html";
						//alert("=====22======")
						// $("#sucessStatusMsg").text("Account creation is success..");
						//$("#sucessStatusMsg").append("<a href='login.jsp'>Click here to login</a>");
						// $("#sucessStatusMsg").css("color", "blue");
						//$("#sucessStatusMsg").focus();
						//$("#signupDivId").hide();
					} else {
						if (responseData.split("@@SEPARATOR@@")[1] == "USERNAME_EXIST") {
							$("#failedStatusMsg").text("User Name is already Exist.");
						}else if (responseData.split("@@SEPARATOR@@")[1] == "MOBILENO_EXIST") {
							$("#failedStatusMsg").text("Mobile Number is already Exist.");
						}else if (responseData.split("@@SEPARATOR@@")[1] == "EMAILADDRESS_EXIST") {
							$("#failedStatusMsg").text("Email Address Number is already Exist.");
						}else{
							$("#failedStatusMsg").text("Something went wrong.please try again later!");
						}
						$("#failedStatusMsg").css("color", "red");
						$("#failedStatusMsg").focus();
						$(window).scrollTop(0);
					}

				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(errorThrown);
				}
			})
		}

	}

	function signUpValidation() {

		var isValidationPassed = true;

		$("#firstNameError").text("");
		$("#lastNameError").text("");
		$("#mobileNumberError").text("");
		$("#emailAddressError").text("");
		$("#userNameError").text("");
		$("#passwordError").text("");
		$("#userTypeError").text("");

		var firstName = $("#firstName").val();
		var lastName = $("#lastName").val();
		var mobileNumber = $("#mobileNumber").val();
		var emailAddress = $("#emailAddress").val();
		var userName = $("#userName").val();
		var password = $("#password").val();
		var userType = $("#userType").val();

		var repassword = $("#repassword").val();
		//alert(userType)

		if (firstName == null || firstName.trim() == "") {
			$("#firstNameError").text("first name can't be empty");
			isValidationPassed = false;

		} else if (lastName == null || lastName.trim() == "") {
			$("#lastNameError").text("last name can't be empty");
			isValidationPassed = false;

		} else if (mobileNumber == null || mobileNumber.trim() == "") {
			$("#mobileNumberError").text("mobile number can't be empty");
			isValidationPassed = false;

		} else if (mobileNumber.trim() != "" && mobileNumber.trim().length < 10) {
			$("#mobileNumberError").text("mobile number is not valid");
			isValidationPassed = false;

		} else if (emailAddress == null || emailAddress.trim() == "") {
			$("#emailAddressError").text("email address can't be empty");
			isValidationPassed = false;

		} else if (emailAddress.trim() != "" && !ValidateEmail(emailAddress)) {
			$("#emailAddressError").text("invalid email");
			isValidationPassed = false;

		} else if (userName == null || userName.trim() == "") {
			$("#userNameError").text("user name can't be empty");
			isValidationPassed = false;

		} else if (password == null || password.trim() == "") {
			$("#passwordError").text("password can't be empty");
			isValidationPassed = false;

		} else if (password.trim() != "" && !validatePassword(password)) {
			$("#passwordError")
					.text(
							"password should be minimum 8 letters, with at least a symbol, upper and lower case letters and a number");
			isValidationPassed = false;

		} else if (userType == null || userType.trim() == ""
				|| userType.trim() == "NA") {
			$("#userTypeError").text("select user type");
			isValidationPassed = false;
		}

		if (isValidationPassed && password != repassword) {
			alert("password and confirm passwords are not matched");
			isValidationPassed = false;
		}

		if (isValidationPassed && !$("#agreeStmtCheckboxId").is(':checked')) {
			alert("You must agree to terms and condition for registration");
			isValidationPassed = false;
		}

		
		
		if (isValidationPassed) {
			let text = "Are you sure ? you are going to register as a "+userType+".";
			
			if (confirm(text) == true) {
				isValidationPassed = true;
			} else {
				isValidationPassed = false;
			}
		}

		return isValidationPassed;

	}

	function ValidateEmail(inputText) {
		var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
		return inputText.match(mailformat);
	}
	function validatePassword(inputPwd) {
		var passwordFormat = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$/;

		return inputPwd.match(passwordFormat);
	}

	$(document).ready(function() {

		$("#mobileNumber").on("keypress", function(e) {

			var $this = $(this);
			var regex = new RegExp("^[0-9\b]+$");
			var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
			// for 10 digit number only
			if ($this.val().length > 9) {
				e.preventDefault();
				return false;
			}
			/*if (e.charCode < 54 && e.charCode > 47) {
			    if ($this.val().length == 0) {
			        e.preventDefault();
			        return false;
			    } else {
			        return true;
			    }

			}*/
			if (regex.test(str)) {
				return true;
			}
			e.preventDefault();
			return false;
		});

	});

	function blockSpecialCharAndNumbers(e) {
		// || (k >= 48 && k <= 57)
		var k;
		document.all ? k = e.keyCode : k = e.which;
		return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32);
	}

	function blockSpecialChar(e) {
		var k;
		document.all ? k = e.keyCode : k = e.which;
		return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
	}
</script>

</html>