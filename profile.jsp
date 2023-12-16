<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
</head>
<body>


	<!--Main Navigation-->
	<!-- header section start  -->
	<!-- Sidebar -->
	<jsp:include page="header-side-menu.jsp" />
	<!-- Sidebar -->
	<!-- header section end  -->
	<!--Main Navigation-->

	<!--Main layout-->
	<main style="margin-top: 58px">
		<div class="container pt-4">


			<section class="vh-100"
				style="background-color: ash; overflow-x: scroll; overflow-y: scroll;">

				<form id="update-profile" name="update-profile"
					action="${pageContext.request.contextPath}/update-profile"
					method="post">

					<div class="container h-100">

						<div
							class="row d-flex justify-content-center align-items-center h-100">
							<div class="col-xl-12">

								<h2 class="mb-4" style="font-family: Calibri; color: black;">Edit
									your Profile</h2>
								<b><p id="statusMsg"></p></b>

								<div class="card" style="border-radius: 15px;">
									<div class="card-body">
										<input type="text" id="userId" name="userId"
											value="${userDetails.userId}" style="display: none;">
										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-2 ps-4">
												<h6 class="mb-0">First Name</h6>
											</div>
											<div class="col-md-4 pe-4">
												<input type="text" class="form-control form-control-lg"
													id="firstName" name="firstName" maxlength="45"
													onkeypress="return blockSpecialCharAndNumbers(event)"
													autocomplete="off" value="${userDetails.firstName}" /> <b><span
													id="firstNameError" style="font-size: 10px; color: red"></span></b>
											</div>

											<div class="col-md-2 ps-4">
												<h6 class="mb-0">Last Name</h6>
											</div>
											<div class="col-md-4 pe-4">
												<input type="text" class="form-control form-control-lg"
													id="lastName" name="lastName" maxlength="45"
													onkeypress="return blockSpecialCharAndNumbers(event)"
													autocomplete="off" value="${userDetails.lastName}" /> <b><span
													id="lastNameError" style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-2 ps-4">
												<h6 class="mb-0">Mobile Number</h6>
											</div>
											<div class="col-md-4 pe-4">
												<input type="text" class="form-control form-control-lg"
													id="mobileNumber" name="mobileNumber"
													value="${userDetails.mobileNumber}"
													title="only numbers allowed" autocomplete="off" /> <b><span
													id="mobileNumberError" style="font-size: 10px; color: red"></span></b>
											</div>

											<div class="col-md-2 ps-4">
												<h6 class="mb-0">Email Address</h6>
											</div>
											<div class="col-md-4 pe-4">
												<input type="text" class="form-control form-control-lg"
													id="emailAddress" name="emailAddress" maxlength="45"
													autocomplete="off" value="${userDetails.emailAddress}" /><b><span
													id="emailAddressError" style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-2 ps-4">
												<h6 class="mb-0">User Type</h6>
											</div>
											<div class="col-md-4 pe-4">
												<input disabled="disabled" type="text"
													class="form-control form-control-lg"
													value="${userDetails.userType}" />
											</div>

											<div class="col-md-2 ps-4">
												<h6 class="mb-0">User Name</h6>
											</div>
											<div class="col-md-4 pe-4">
												<input disabled="disabled" type="text"
													class="form-control form-control-lg"
													value="${userDetails.userName}" />
											</div>
										</div>

										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-2 ps-4">
												<h6 class="mb-0">Password</h6>
											</div>
											<div class="col-md-4 pe-4">
												<input type="password" class="form-control form-control-lg"
													id="password" name="password" maxlength="45"
													autocomplete="off" value="${userDetails.password}" /><b><span
													id="passwordError" style="font-size: 10px; color: red"></span></b>
											</div>
										</div>
										<div class="px-5 py-4">

											<button type="button" class="btn btn-primary btn-md"
												onclick="updateUserProfile()">Update</button>

										</div>

									</div>
								</div>

							</div>
						</div>
					</div>
				</form>
			</section>


		</div>
	</main>
	<!--Main layout-->


	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#update-profile')[0].reset();

					$("#mobileNumber").on(
							"keypress",
							function(e) {

								var $this = $(this);
								var regex = new RegExp("^[0-9\b]+$");
								var str = String
										.fromCharCode(!e.charCode ? e.which
												: e.charCode);
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

		function updateUserProfileValidation() {

			var isValidationPassed = true;

			$("#firstNameError").text("");
			$("#lastNameError").text("");
			$("#mobileNumberError").text("");
			$("#emailAddressError").text("");
			$("#passwordError").text("");

			var firstName = $("#firstName").val();
			var lastName = $("#lastName").val();
			var mobileNumber = $("#mobileNumber").val();
			var emailAddress = $("#emailAddress").val();
			var password = $("#password").val();

			if (firstName == null || firstName.trim() == "") {
				$("#firstNameError").text("first name can't be empty");
				isValidationPassed = false;

			} else if (lastName == null || lastName.trim() == "") {
				$("#lastNameError").text("last name can't be empty");
				isValidationPassed = false;

			} else if (mobileNumber == null || mobileNumber.trim() == "") {
				$("#mobileNumberError").text("mobile number can't be empty");
				isValidationPassed = false;

			} else if (mobileNumber.trim() != ""
					&& mobileNumber.trim().length < 10) {
				$("#mobileNumberError").text("mobile number is not valid");
				isValidationPassed = false;

			} else if (emailAddress == null || emailAddress.trim() == "") {
				$("#emailAddressError").text("email address can't be empty");
				isValidationPassed = false;

			} else if (emailAddress.trim() != ""
					&& !ValidateEmail(emailAddress)) {
				$("#emailAddressError").text("invalid email");
				isValidationPassed = false;

			} else if (password == null || password.trim() == "") {
				$("#passwordError").text("password can't be empty");
				isValidationPassed = false;

			} else if (password.trim() != "" && !validatePassword(password)) {
				$("#passwordError")
						.text(
								"password should be minimum 8 letters, with at least a symbol, upper and lower case letters and a number");
				isValidationPassed = false;

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
		function blockSpecialCharAndNumbers(e) {
			// || (k >= 48 && k <= 57)
			var k;
			document.all ? k = e.keyCode : k = e.which;
			return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32);
		}

		function blockSpecialChar(e) {
			var k;
			document.all ? k = e.keyCode : k = e.which;
			return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8
					|| k == 32 || (k >= 48 && k <= 57));
		}

		function updateUserProfile() {

			if (updateUserProfileValidation()) {
				//alert("===")
				var formData = {
					userId : $("#userId").val(),
					firstName : $("#firstName").val(),
					lastName : $("#lastName").val(),
					mobileNumber : $("#mobileNumber").val(),
					emailAddress : $("#emailAddress").val(),
					password : $("#password").val()
				};
				//alert("==")
				$.ajax({
					type : "post",
					url : "update-profile",
					data : formData,
					success : function(responseData, textStatus, jqXHR) {
						//alert("responseData:: " + responseData)
						console.log("data updated");
						if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
							$("#statusMsg").text("Updation is success.");
							$("#statusMsg").css("color", "blue");
							$("#statusMsg").focus();
						} else {
							
							if (responseData.split("@@SEPARATOR@@")[1] == "MOBILENO_EXIST") {
								$("#statusMsg").text("Mobile Number is already Exist.");
							}else if (responseData.split("@@SEPARATOR@@")[1] == "EMAILADDRESS_EXIST") {
								$("#statusMsg").text("Email Address Number is already Exist.");
							}else{
								$("#statusMsg").text("Something went wrong.please try again later!");
							}
							
							$("#statusMsg").css("color", "red");
							$("#statusMsg").focus();
						}
						$(window).scrollTop(0);

					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(errorThrown);
					}
				})

			}
		}
		$("#profileMenuId").addClass('active');
	</script>

</body>
</html>