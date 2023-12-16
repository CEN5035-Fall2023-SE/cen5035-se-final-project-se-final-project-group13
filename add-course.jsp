<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Course</title>
</head>
<body>
	<!--Main Navigation-->
	<!-- header section start  -->
	<!-- Sidebar -->
	<jsp:include page="header-side-menu.jsp" />
	<!-- Sidebar -->
	<!-- header section end  -->
	<!--Main Navigation-->
<c:choose>
<c:when test="${not empty userDetails && userDetails.userType eq 'TA Admin'}">
	<!--Main layout-->
	<main style="margin-top: 58px">
		<div class="container pt-4">


			<section class="vh-100"
				style="background-color: ash; overflow-x: scroll; overflow-y: scroll;">

				<form id="add-course" name="add-course"
					action="${pageContext.request.contextPath}/add-course"
					method="post">

					<div class="container h-100">

						<div
							class="row d-flex justify-content-center align-items-center h-100">
							<div class="col-xl-12">

								<h5 class="mb-4">Add Course</h5>
								<b><p id="statusMsg"></p></b>

								<div class="card" style="border-radius: 15px;">
									<div class="card-body">
										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-2 ps-4">
												<h6 class="mb-0">Course ID</h6>
											</div>
											<div class="col-md-3 pe-4">
												<input type="text" class="form-control form-control-lg"
													id="courseId" name="courseId" maxlength="80"
													onkeypress="return blockSpecialChar(event)"
													autocomplete="off" /> <b><span id="courseIdError"
													style="font-size: 10px; color: red"></span></b>
											</div>

											<div class="col-md-2 ps-4">
												<h6 class="mb-0">Course Name</h6>
											</div>
											<div class="col-md-3 pe-4">
												<input type="text" class="form-control form-control-lg"
													id="courseName" name="courseName" maxlength="80"
													onkeypress="return blockSpecialChar(event)"
													autocomplete="off" /> <b><span id="courseNameError"
													style="font-size: 10px; color: red"></span></b>
											</div>
										</div>


										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-2 ps-4">
												<h6 class="mb-0">No.of Open Positions</h6>
											</div>
											<div class="col-md-3 pe-4">
												<input type="text" class="form-control form-control-lg"
													id="openPositions" name="openPositions" maxlength="80"
													onkeypress="return blockSpecialChar(event)"
													autocomplete="off" /> <b><span id="openPositionsError"
													style="font-size: 10px; color: red"></span></b>
											</div>

											<div class="col-md-2 ps-4">
												<h6 class="mb-0">Select Professor</h6>
											</div>
											<div class="col-md-3 pe-4">
												<select class="form-select select" id="professorSelectId"
													name="professorSelectId">
													<option value="NA">Select</option>
												</select> <b><span id="professorSelectIdError"
													style="font-size: 10px; color: red"></span></b>
											</div>
											<div class="col-md-2 ps-4">
												<button type="button" class="btn btn-primary btn-md"
													onclick="addCourse()">Add</button>
											</div>
										</div>

										<br />
										<h6>Course Details::</h6>
										<br />
										<table class="table table-bordered table-hover" border="1px"
											style="overflow-x: scroll; overflow-y: scroll;"
											id="courseMainTableId">
											<thead>
												<tr>
													<th scope="col">S.No.</th>
													<th scope="col">Course ID</th>
													<th scope="col">Course Name</th>
													<th scope="col">View Details & Action</th>
												</tr>
											</thead>
											<tbody id="courseTableId">
												<c:forEach items="${coursesList}" var="course"
													varStatus="counter">

													<tr>
														<th scope="row">${counter.count}</th>
														<td>${course.courseId}</td>
														<td>${course.courseName}</td>
														<td><button type="button"
																class="btn btn-primary btn-sm" data-bs-toggle="modal"
																data-bs-target="#courseDetailsModal"
																onclick="getProfessorDetailsByCourseId('${course.courseId}')">View Details</button></td>
													</tr>

												</c:forEach>

											</tbody>
										</table>
									</div>
								</div>

							</div>
						</div>
					</div>
				</form>
			</section>


		</div>


		<!-- Course and Professor Details view Modal start -->
		<div class="modal fade" id="courseDetailsModal" tabindex="-1"
			aria-labelledby="courseDetailsModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="courseDetailsModalLabel">Course
							Details</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">


						<div class="row">
							<div class="col-md-4 mb-3">
								<label for="validationCustom01"><h6 class="mb-0">Course
										ID</h6></label> 
										<input type="text" class="form-control" id="modalCourseId"
									disabled="disabled">
							</div>
							<div class="col-md-4 mb-3">
								<label for="validationCustom02"><h6 class="mb-0">Course
										Name</h6></label> <input type="text" class="form-control"
									id="modalCourseName" disabled="disabled">
							</div>
							<div class="col-md-4 mb-3">
								<label for="validationCustom02"><h6 class="mb-0">No.of
										open positions</h6></label> <input type="text" class="form-control"
									id="modalOpenPositions">
							</div>
						</div>

						<hr />
						<h6 class="mb-0">Professor Details</h6>
						<br />
						<div class="row">
							<div class="col-md-4 mb-3">
								<label for="validationCustom01"><h6 class="mb-0">Name</h6></label>
								<input type="text" class="form-control" id="modalProfessorName"
									disabled="disabled">
							</div>
							<div class="col-md-4 mb-3">
								<label for="validationCustom02"><h6 class="mb-0">Mobile
										No.</h6></label> <input type="text" class="form-control"
									id="modalProfessorMobileNo" disabled="disabled">
							</div>
							<div class="col-md-4 mb-3">
								<label for="validationCustom02"><h6 class="mb-0">Email
										Address</h6></label> <input type="text" class="form-control"
									id="modalProfessorEmailAddress" disabled="disabled">
							</div>
						</div>


					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary btn-sm"
							onclick="updateOrDeleteCourse('UPDATE')">Update</button>
						<button type="button" class="btn btn-danger btn-sm"
							onclick="updateOrDeleteCourse('DELETE')">delete</button>
						<button type="button" class="btn btn-secondary btn-sm"
							data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Course and Professor Details view Modal end -->


	</main>
	<!--Main layout-->

 </c:when>
	  <c:otherwise>
	  <%
    	String redirectURL = "login.jsp";
	  session.invalidate();
    	response.sendRedirect(redirectURL);
	%>
  </c:otherwise> 
	</c:choose>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#add-course')[0].reset();

			$('#courseMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});
			
			$("#openPositions").on("keypress", function(e) {

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
			
			$("#modalOpenPositions").on("keypress", function(e) {

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

		/*load professor details start..*/
		loadProfessorDetails();
		function loadProfessorDetails() {
			$
					.ajax({
						type : "post",
						url : "getProfessorDtls",
						data : {},
						success : function(responseData, textStatus, jqXHR) {
							//alert(responseData)
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {

								var professorList = responseData
										.split("@@SEPARATOR@@")[1];

								if (professorList != null
										&& professorList.trim() != "") {

									var json = JSON.parse(professorList);

									var tableString = "";
									for (let i = 0; i < json.length; i++) {
										let obj = json[i];
										tableString += "<option value="+obj.professorId+">";
										tableString += obj.name;
										tableString += "</option>";
									}

									$("#professorSelectId").append(tableString);

								}

							} else {
								// do nothing
							}

						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(errorThrown);
						}
					})
		}
		/*load professor details end..*/

		/* get professor details by course id start */
		function getProfessorDetailsByCourseId(courseId) {
			$
					.ajax({
						type : "get",
						url : "getProfessorDtlsByCourseId",
						data : {
							courseId : courseId
						},
						success : function(responseData, textStatus, jqXHR) {
							//alert(responseData)
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {

								var professorList = responseData
										.split("@@SEPARATOR@@")[1];

								if (professorList != null
										&& professorList.trim() != "") {

									var json = JSON.parse(professorList);
									//alert(json.courseId)
									$("#modalCourseId").val("");
									$("#modalCourseName").val("");
									$("#modalOpenPositions").val("");
									$("#modalProfessorName").val("");
									$("#modalProfessorMobileNo").val("");
									$("#modalProfessorEmailAddress").val("");
									//
									$("#modalCourseId").val(json.courseId);
									$("#modalCourseName").val(json.courseName);
									$("#modalOpenPositions").val(
											json.openPositions);
									//
									$("#modalProfessorName").val(
											json.professorDetails.name);
									$("#modalProfessorMobileNo").val(
											json.professorDetails.mobileNumber);
									$("#modalProfessorEmailAddress").val(
											json.professorDetails.emailAddress);

								}

							} else {
								// do nothing
							}

						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(errorThrown);
						}
					})
		}
		/* get professor details by course id end */

		function addCoursevalidation() {

			var isValidationPassed = true;

			$("#courseIdError").text("");
			$("#courseNameError").text("");
			$("#openPositionsError").text("");
			$("#professorSelectIdError").text("");

			var courseId = $("#courseId").val();
			var courseName = $("#courseName").val();
			var openPositions = $("#openPositions").val();
			var professorSelectId = $("#professorSelectId").val();

			if (courseId == null || courseId.trim() == "") {
				$("#courseIdError").text("Course ID can't be empty");
				isValidationPassed = false;

			} else if (courseName == null || courseName.trim() == "") {
				$("#courseNameError").text("Course Name can't be empty");
				isValidationPassed = false;

			} else if (openPositions == null || openPositions.trim() == "") {
				$("#openPositionsError").text(
						"please provide no.of open positions");
				isValidationPassed = false;

			} else if (professorSelectId == null
					|| professorSelectId.trim() == ""
					|| professorSelectId.trim() == "NA") {
				$("#professorSelectIdError").text("please select professor");
				isValidationPassed = false;

			}

			return isValidationPassed;

		}

		function blockSpecialCharAndNumbers(e) {
			// || (k >= 48 && k <= 57)
			var k;
			document.all ? k = e.keyCode : k = e.which;
			return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32);
		}

		function blockSpecialChar(e) {
			//alert(e.keyCode +" "+e.which)
			var k;
			document.all ? k = e.keyCode : k = e.which;
			return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8
					|| k == 95 || k == 32 || (k >= 48 && k <= 57));
		}

		function addCourse() {

			if (addCoursevalidation()) {
				//alert("===")
				var formData = {
					courseId : $("#courseId").val(),
					courseName : $("#courseName").val(),
					openPositions : $("#openPositions").val(),
					professorId : $("#professorSelectId").val()
				};
				//alert("==")
				$.ajax({
					type : "post",
					url : "add-course",
					data : formData,
					success : function(responseData, textStatus, jqXHR) {
						///alert("responseData:: " + responseData)
						if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
							$("#courseId").val("");
							$("#courseName").val("");
							$("#openPositions").val("");
							$("#professorSelectId").val("NA");

							$("#statusMsg").text("Course is added.");
							$("#statusMsg").css("color", "blue");
							$("#statusMsg").focus();
							$("#courseTableId tr").remove();
							//alert(responseData.split("@@SEPARATOR@@")[1]);
							var courseList = responseData.split("@@SEPARATOR@@")[1];

							if (courseList != null && courseList.trim() != "") {
								setTableData(courseList);
							}

						} else {
							$("#statusMsg").text("Course is not added.");
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

		function updateOrDeleteCourse(actionType) {
			$.ajax({
				type : "post",
				url : "updateOrDeletecourse",
				data : {
					courseId : $("#modalCourseId").val(),
					actionType : actionType,
					openPositions : $("#modalOpenPositions").val()
				},
				success : function(responseData, textStatus, jqXHR) {
					///alert("responseData:: " + responseData)
					$("#courseDetailsModal").modal('toggle');
					if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
						$("#courseId").val("");
						$("#courseName").val("");
						
						if(actionType=="UPDATE"){
							$("#statusMsg").text("Course is Updated.");
						}else{
							$("#statusMsg").text("Course is deleted.");
						}
						
						$("#statusMsg").css("color", "blue");
						$("#statusMsg").focus();
						$("#courseTableId tr").remove();

						//alert(responseData.split("@@SEPARATOR@@")[1]);
						var courseList = responseData.split("@@SEPARATOR@@")[1];

						if (courseList != null && courseList.trim() != "") {
							//alert(courseList)
							setTableData(courseList);
						}

					} else {
						$("#statusMsg").text("Course is not deleted.");
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
		function setTableData(courseList) {

			//alert(courseList)
			var json = JSON.parse(courseList);

			var tableString = "";
			var index = 1;
			for (let i = 0; i < json.length; i++) {
				let obj = json[i];
				//alert(obj.courseId+" "+obj.applicationStatus);
				tableString += "<tr>";

				tableString += '<td scope="row">';
				tableString += index;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.courseId;
				tableString += "</td>";

				var courseId = "'" + obj.courseId + "'";

				tableString += "<td>";
				tableString += obj.courseName;
				tableString += "</td>";

				tableString += '<td><button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#courseDetailsModal" onclick="getProfessorDetailsByCourseId('
						+ courseId + ')">View Details</button></td>';


				tableString += "</tr>";

				index++;
			}

			$("#courseTableId").append(tableString);

			$('#courseMainTableId').DataTable().clear().destroy();
			$("#courseTableId").append(tableString);
			$('#courseMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});

		}
		$("#addCourseMenuId").addClass('active');
	</script>

</body>
</html>