<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Applicant Details</title>
</head>
<style>
      .recommend {
        background-color: blue;
        -webkit-border-radius: 60px;
        border-radius: 60px;
        border: none;
        color: #eeeeee;
        cursor: pointer;
        display: inline-block;
        font-family: sans-serif;
        font-size: 13px;
        padding: 5px 15px;
        text-align: center;
        text-decoration: none;
      }
      @keyframes glowing {
        0% {
          background-color: green;
          box-shadow: 0 0 5px green;
        }
        50% {
          background-color: green;
          box-shadow: 0 0 20px green;
        }
        100% {
          background-color: green;
          box-shadow: 0 0 5px green;
        }
      }
      .recommend {
        animation: glowing 1300ms infinite;
      }


</style>
<body>


	<!--Main Navigation-->
	<!-- header section start  -->
	<!-- Sidebar -->
	<jsp:include page="header-side-menu.jsp" />
	<!-- Sidebar -->
	<!-- header section end  -->
	<!--Main Navigation-->

<c:choose>

	<c:when test="${not empty userDetails && (userDetails.userType eq 'TA Admin' || userDetails.userType eq 'TA Committee')}">
	<!--Main layout-->
	<main style="margin-top: 58px">

		<div class="container pt-4">
			<!-- <div id="viewFileDivId">

			<object
				data="${pageContext.request.contextPath}/ACK441731810120723 (1).pdf"
				type="application/pdf" width="500" height="300">
				<a
					href="${pageContext.request.contextPath}/ACK441731810120723 (1).pdf" target="_blank">Download
					file.pdf</a>
			</object>
		</div> -->

			<section class="vh-100"
				style="background-color: ash; overflow-x: scroll; overflow-y: scroll;">

				<form id="get-applicants-form" name="get-applicants-form">

					<div class="container h-100">

						<div
							class="row d-flex justify-content-center align-items-center h-100">
							<div class="col-xl-12">

								<input type="text" value="${userDetails.userType}" id="userType"
									style="display: none;"> <b><p id="statusMsg"></p></b>
								<div class="row align-items-center">
									TA Applicant
									<div class="col-md-3">

										<select class="form-select" id="taApplicantSelectId"
											name="taApplicantSelectId">
											<option value="ALL">Select</option>
										</select> <b><span id="taApplicantSelectIdError"
											style="font-size: 10px; color: red"></span></b>
									</div>
									Course Name
									<div class="col-md-3">
										<select class="form-select" id="courseId" name="courseId">
											<option value="ALL">ALL</option>
											<c:forEach items="${coursesList}" var="course"
												varStatus="counter">
												<option value="${course.courseId}">${course.courseName}</option>
											</c:forEach>
										</select> <b><span id="courseIdError"
											style="font-size: 10px; color: red"></span></b>
									</div>

									Application Status
									<div class="col-md-2">
										<select class="form-select" id="status" name="status">
											<option value="ALL">ALL</option>
											<option value="PENDING">Pending</option>
											<option value="APPROVED">Approved</option>
											<option value="REJECTED">Rejected</option>
											<option value="APPOINTED">Appointed</option>
											<option value="COMPLETED">Completed</option>

										</select><b><span id="statusError"
											style="font-size: 10px; color: red"></span></b>
									</div>


								</div>
								<br />
								<div class="col-md-12 text-center">

									<button type="button" class="btn btn-primary btn-md"
										onclick="getApplicants()">View Application Details</button>

								</div>
								<br />

								<h2 class="mb-6"
									style="font-family: Calibri; color: black; font-size: 22px;">
									<b>Applicants Details: </b> <b id="statusMessage"
										style="color: blue"></b>
								</h2>

								<div class="card" style="border-radius: 15px;">


									<div class="card-body"
										style="overflow-x: scroll; overflow-y: scroll;">



										<table class="table table-bordered table-hover" border="1px"
											style="overflow-x: scroll; overflow-y: scroll;"
											id="applicantsMainTableId">
											<thead>
												<tr>
													<th scope="col">Applicant ID</th>
													<th scope="col">Course ID</th>
													<th scope="col">View CV/Resume</th>
													<c:if test="${userDetails.userType eq 'TA Committee'}">
														<th scope="col">Recommended</th>
													</c:if>
													<th scope="col">Status</th>
													<th scope="col">View Details & Action</th>
												</tr>
											</thead>
											<tbody id="applicantsTableId">
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

		
		<!-- Modal -->
		<div class="modal fade" id="newCoursesModal" tabindex="-1"
			aria-labelledby="newCoursesModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="newCoursesModalLabel">New
							Courses</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-hover" border="1px"
							style="overflow-x: scroll; overflow-y: scroll;">
							<thead>
								<tr>
									<th scope="col">S.No.</th>
									<th scope="col">Course ID</th>
									<th scope="col">Course Name</th>
								</tr>
							</thead>
							<tbody id="courseTableId">
								<c:forEach items="${coursesList}" var="course"
									varStatus="counter">

									<tr>
										<th scope="row">${counter.count}</th>
										<td>${course.courseId}</td>
										<td>${course.courseName}</td>
									</tr>

								</c:forEach>

							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<!-- <button type="button" class="btn btn-primary">Save
							changes</button>-->
					</div>
				</div>
			</div>
		</div>
		<!-- previous courses end -->





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
		/* fetching applicant details start */

		function setApplicationValues(rating, feedback) {
			if (rating == null || rating.trim() == ""
					|| rating.trim() == "undefined") {
				$("#modalRatingId").val("NA");
			} else {
				$("#modalRatingId").val(rating);
			}

			if (feedback == null || feedback.trim() == ""
					|| feedback.trim() == "undefined") {
				$("#modalFeedbackId").val("NA");
			} else {
				$("#modalFeedbackId").val(feedback);
			}

		}

		function getApplicantsValidation() {

			var isValidationPassed = true;

			$("#statusMessage").text("");
			$("#courseIdError").text("");
			$("#statusError").text("");
			$("#taApplicantSelectIdError").text("");

			var courseId = $("#courseId").val();
			var status = $("#status").val();
			var taApplicantSelectId = $("#taApplicantSelectId").val();

			//alert(status)

			if (taApplicantSelectId == null || taApplicantSelectId.trim() == ""
					|| taApplicantSelectId.trim() == "NA") {
				$("#taApplicantSelectIdError").text("please select applicant");
				isValidationPassed = false;

			} else if (courseId == null || courseId.trim() == ""
					|| courseId.trim() == "NA") {
				$("#courseIdError").text("please select course");
				isValidationPassed = false;

			} else if (status == null || status.trim() == ""
					|| status.trim() == "NA") {
				$("#statusError").text("please select status");
				isValidationPassed = false;

			}

			return isValidationPassed;

		}

		function getApplicants() {
			$("#statusMessage").text("");
			if (true) {

				var formData = {
					courseId : $("#courseId").val(),
					status : $("#status").val(),
					userId : $("#taApplicantSelectId option:selected").val()
				};
				$
						.ajax({
							type : "post",
							url : "get-applicants",
							data : formData,
							success : function(responseData, textStatus, jqXHR) {
								//alert("responseData:: " + responseData)
								$("#applicantsTableId tr").remove();
								if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
									var courseList = responseData
											.split("@@SEPARATOR@@")[1];
									if (courseList != null && courseList != "") {
										setTableData(courseList);
									} else {
										$("#statusMessage")
												.html(
														'<div id="not-found">No results</div>');
										$("#statusMessage").focus();
									}
								} else {
									$("#statusMsg")
											.text(
													"Something went wrong.please try again later!");
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

		function setTableData(courseList) {
			//alert(courseList)
			var json = JSON.parse(courseList);
			//alert(json.length)
			var tableString = "";
			var index = 1;
			for (let i = 0; i < json.length; i++) {
				let obj = json[i];
				//alert(obj)
				tableString += "<tr>";

				if ($("#userType").val() == 'TA Committee') {
					/*tableString += '<td scope="row">';
					tableString += '<center><input type="checkbox" name="userIdCheckbox" id="userIdCheckbox" value="'+obj.courseId+'"></center>';
					tableString += "</td>";*/
				}

				tableString += "<td>";
				tableString += obj.applicationId;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.courseId;
				tableString += "</td>";
				
				tableString += "<td>";
				var fileName = obj.cvFileName;
				tableString += '<a href="/TeachingAssistantApp/view-file?fileName='+obj.userId+'_'+fileName+'" target="_blank">view/download</a>';
				tableString += "</td>";
				
				if ($("#userType").val() == 'TA Committee') {
					if (obj.isRecommended != null && obj.isRecommended == "Y") {
						tableString += "<td>";
						tableString += '<a class="recommend" href="#">Recommended</a>';
						tableString += "</td>";
					} else {
						tableString += "<td>";
						tableString += 'NA';
						tableString += "</td>";
					}
				}
				
				tableString += "<td>";
				tableString += obj.applicationStatus;
				tableString += "</td>";

				var courseId = "'" + obj.courseId + "'";
				var courseUniqueId = "'" + obj.courseUniqueId + "'";
				var applicationStatus = "'" + obj.applicationStatus + "'";
				var userId = "'" + obj.userId + "'";
				tableString += "<td>";
				tableString += '<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#applicantDetailsModal" onclick="loadApplicantCourseDetails('+courseId+','+courseUniqueId+','+applicationStatus+','+userId+')">View Details</button>';
				tableString += "</td>";

				tableString += "</tr>";

				index++;
			}

			$("#applicantsTableId").append(tableString);

			$('#applicantsMainTableId').DataTable().clear().destroy();
			$("#applicantsTableId").append(tableString);
			$('#applicantsMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});

		}
		/* fetching applicant details end */

		/*Get Previous exeperienced course details based on userId -  start*/
		function getUserPrevCourses(userId) {
			var formData = {
				userId : userId
			};
			$
					.ajax({
						type : "post",
						url : "get-prev-courses",
						data : formData,
						success : function(responseData, textStatus, jqXHR) {
							//alert("responseData:: " + responseData)
							console.log("data fetched");
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								var courseList = responseData
										.split("@@SEPARATOR@@")[1];
								$("#prevCourseTableId tr").remove();
								setTableDataForPrevCourses(courseList);
							} else {
								$("#statusMsg")
										.text(
												"Something went wrong.please try again later!");
								$("#statusMsg").css("color", "red");
								$("#statusMsg").focus();
							}

						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(errorThrown);
						}
					})

		}
		function setTableDataForPrevCourses(courseList) {
			var json = JSON.parse(courseList);
			var tableString = "";
			var index = 1;
			for (let i = 0; i < json.length; i++) {
				let obj = json[i];
				//alert(obj.courseId+" "+obj.applicationStatus);
				tableString += "<tr>";

				tableString += '<th scope="row">';
				tableString += index;
				tableString += "</th>";

				tableString += "<td>";
				tableString += obj.courseName;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.fromDate;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.toDate;
				tableString += "</td>";

				tableString += "</tr>";

				index++;
			}

			$("#prevCourseTableId").append(tableString);

		}
		/*Get Previous exeperienced course details based on userId -  end*/

		$(document).on('change', '#status', function() {
			if ($("#userType").val() == 'TA Committee') {
				var value = this.value;
				if (value == 'PENDING') {
					$("#apprvBtnId").show();
					$("#rejBtnId").show();
				} else {
					$("#apprvBtnId").hide();
					$("#rejBtnId").hide();
				}
			}
		});

		/* approve/reject applicant profile start..*/
		function apprvOrRejectApplications(actionType) {
			//
			$("#statusMessage").text("");
			var formData = {
				userId : $("#taApplicantSelectId option:selected").val(),
				actionType : actionType,
				selRowCourseId : $("#modalCourseId").val(),
				courseIdFromSearch : $("#courseId").val(),
				courseUniqueId : $("#modalCourseUniqueIdId").val(),
				status : $("#status").val()
			};
			$
					.ajax({
						type : "post",
						url : "updateTAApplication",
						data : formData,
						success : function(responseData, textStatus, jqXHR) {
							//alert("responseData:: " + responseData)
							//alert(responseData.split("@@SEPARATOR@@")[1])
							$('#applicantDetailsModal').modal('toggle');
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								$("#applicantsTableId tr").remove();
								var taUsersList = responseData.split("@@SEPARATOR@@")[1];
								//alert(taUsersList)
								if (taUsersList != null && taUsersList.trim() != "") {
									setTableData(taUsersList);
									
								} 
								
								if(actionType=="APPROVED"){
									$("#statusMessage").text("Course is approved successfully.");
								}else{
									$("#statusMessage").text("Course is rejected successfully.");
								}

							} else if(responseData.split("@@SEPARATOR@@")[0] == "FAIL"){
								if(responseData.split("@@SEPARATOR@@")[1] == "NOOPENPOSITIONS"){
									$("#statusMessage").text("No open positions.");
								}else{
									$("#statusMessage").text("Something went wrong.please try again later!");
								}
								
							}
							$(window).scrollTop(0);
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(errorThrown);
						}
					})

		}
		/* approve/reject applicant profile end..*/

		/* get ta applicant user details - drop down userId and userName - start */
		getTaApplicantUserDetails();
		function getTaApplicantUserDetails() {
			$
					.ajax({
						type : "get",
						url : "getTAApplicantUserDetails",
						data : {},
						success : function(responseData, textStatus, jqXHR) {
							///alert("responseData:: " + responseData)
							///alert(responseData.split("@@SEPARATOR@@")[1])
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								var taUsersList = responseData
										.split("@@SEPARATOR@@")[1];

								if (taUsersList != null
										&& taUsersList.trim() != "") {
									var json = JSON.parse(taUsersList);

									var list = $("#taApplicantSelectId");

									for (let i = 0; i < json.length; i++) {
										let obj = json[i];
										list.append(new Option(obj.userName,
												obj.userId));
									}
								} else {
									//do nothing
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
		/* get ta applicant user details - drop down userId and userName - end */

		/* recommend applicantions start..*/
		function recommendOrNotifyApplication(actionType) {
			
			$("#statusMessage").text("");
			var formData = {
				userId : $("#taApplicantSelectId option:selected").val(),
				actionType : actionType,
				selRowCourseId : $("#modalCourseId").val(),
				courseIdFromSearch : $("#courseId").val(),
				courseUniqueId : $("#modalCourseUniqueIdId").val(),
				status : $("#status").val()
			};
			$
					.ajax({
						type : "post",
						url : "updateTAApplication",
						data : formData,
						success : function(responseData, textStatus, jqXHR) {
							$('#applicantDetailsModal').modal('toggle');
							///alert("responseData:: " + responseData)
							//alert(responseData.split("@@SEPARATOR@@")[1])
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								$("#applicantsTableId tr").remove();
								var taUsersList = responseData.split("@@SEPARATOR@@")[1];

								if (taUsersList != null && taUsersList.trim() != "") {
									setTableData(taUsersList);
								} 
								
								if(actionType=="RECOMMEND"){
									$("#statusMessage").text("Course is recommended to Committee members successfully.");
								}else{
									$("#statusMessage").text("Course is notified to TA Applicant successfully.");
								}
							} else {
								$("#statusMessage").text("Something went wrong.please try again later.");
							}
							$(window).scrollTop(0);
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(errorThrown);
						}
					})

		}
		/* recommend applicantions end..*/

		/* datatable initialization start*/
		$(document).ready(function() {
			//$('#applnStatustableId').DataTable();
			$('#applicantsMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});
		});
		/* datatable initialization end*/

		$("#applicantsDetailsMenuId").addClass('active');
	</script>
	<%@include file="load-applicant-course-dtls.html"%>
</body>
</html>