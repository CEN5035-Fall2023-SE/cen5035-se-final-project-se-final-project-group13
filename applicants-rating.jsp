<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Applicant Details</title>
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

	<c:when test="${not empty userDetails && userDetails.userType eq 'TA Instructor'}">
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

								<h2 class="mb-6"
									style="font-family: Calibri; color: black; font-size: 22px;">
									<b>Applicants Performance Rating </b> 
								</h2>

								<div class="card" style="border-radius: 15px;"><b id="statusMessage"
										style="color: blue"></b>


									<div class="card-body"
										style="overflow-x: scroll; overflow-y: scroll;">



										<table class="table table-bordered table-hover" border="1px"
											style="overflow-x: scroll; overflow-y: scroll;"
											id="applicantsMainTableId">
											<thead>
												<tr>
													<th scope="col" style="display: none;">User ID</th>
													<th scope="col" style="display: none;">Course ID</th>
													<th scope="col">Applicant ID</th>
													<th scope="col">Qualification</th>
													<th scope="col">Course ID</th>
													<!-- <th scope="col">Rating</th> -->
													<!-- <th scope="col">Submit</th> -->
													<th scope="col">View Details</th>
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





		<!-- applicant details and give feedback view Modal start -->
		<div class="modal fade" id="courseDetailsModal" tabindex="-1"
			aria-labelledby="courseDetailsModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="courseDetailsModalLabel">Rating & Feedback</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">

					<input type="text" style="display: none;" id="modalUserId" name="modalUserId">
					<input type="text" style="display: none;" id="modalCourseId" name="modalCourseId">
						<div class="row">
							<div class="col-md-4 mb-3">
								<label for="validationCustom01"><h6 class="mb-0">Select Rating</h6></label> 
								<select class="form-select" id="ratingSelectId" name="ratingSelectId">
									<option value="NA">Select</option>
									<option value="EXCELLENT">Excellent</option>
									<option value="GOOD">Good</option>
									<option value="AVERAGE">Average</option>
									<option value="BELOWAVERAGE">Below Average</option></select>
									<b><span id="ratingSelectIdError"
													style="font-size: 10px; color: red"></span></b>
							</div>
							
							
						</div>

						
						
						<div class="row">
							<div class="col-md-9 mb-3">
								<label for="validationCustom01"><h6 class="mb-0">Feedback</h6></label> 
								<textarea id="feedbackId" name="feedbackId" class="form-control" id="exampleFormControlTextarea1" rows="3" maxlength="250"></textarea>
							<b><span id="feedbackIdError"
													style="font-size: 10px; color: red"></span></b>
							</div>
						</div>
						

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary btn-sm" onclick="submitFeedbackAndRating()">Submit</button>
						<button type="button" class="btn btn-secondary btn-sm"
							data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- applicant details and give feedback view Modal end -->

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
		function getApplicants() {

				var formData = {
					courseId : $("#courseId").val(),
					status : $("#status").val(),
					userId : $("#taApplicantSelectId option:selected").val()
				};
				$
						.ajax({
							type : "post",
							url : "get-appointed-applicants",
							data : {},
							success : function(responseData, textStatus, jqXHR) {
								//alert("responseData:: " + responseData)
								console.log("data fetched");
								if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
									$("#applicantsTableId tr").remove();
									var courseList = responseData.split("@@SEPARATOR@@")[1];
									if (courseList != null && courseList != "") {
										$("#applicantsTableId tr").remove();
										setTableData(courseList);
									} else {
										$("#statusMessage").text(
												"No data available");
										$("#statusMessage").focus();
									}
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

		function setTableData(courseList) {
			var json = JSON.parse(courseList);
			var tableString = "";
			var index = 1;
			for (let i = 0; i < json.length; i++) {
				let obj = json[i];
				//alert(obj.courseId+" "+obj.lastName+" "+obj.firstName+" "+obj.qualification+" "+obj.courseName);
				tableString += "<tr>";

				tableString += '<td style="display: none;">';
				tableString += obj.userId;
				tableString += "</td>";

				tableString += '<td style="display: none;">';
				tableString += obj.courseId;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.applicationId;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.qualification;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.courseId;
				tableString += "</td>";

				/*tableString += "<td>";
				tableString += '<select class="form-select" style="width:auto;"><option value="NA">Select</option><option value="EXCELLENT">Excellent</option><option value="GOOD">Good</option><option value="AVERAGE">Average</option><option value="BELOWAVERAGE">Below Average</option></select>';
				tableString += "</td>";*/

				/*tableString += "<td>";
				var userId = "'" + obj.userId + "'";
				var courseId = "'" + obj.courseId + "'";
				tableString += '<button type="button" class="btn btn-primary btn-sm" style="background-color: #52bebe;border-color: #8ad3d3;">Submit</button>'
				tableString += "</td>";*/
				
				var userId = "'" + obj.userId + "'";
				var courseId = "'" + obj.courseId + "'";
				
				tableString += "<td>";
				tableString += '<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#courseDetailsModal" onclick="setApplicationValues('+userId+','+courseId+')">Feedback & Submit</button>'
				tableString += "</td>";

				tableString += "</tr>";

				index++;
			}

			//$("#applicantsTableId").append(tableString);

			$('#applicantsMainTableId').DataTable().clear().destroy();
			$("#applicantsTableId").append(tableString);
			$('#applicantsMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});

		}
		/* fetching applicant details end */
		function updateTaRating(userId, courseId, value) {
			alert(userId + " " + courseId);
			alert(value)
			//alert($(value).parents('tr').find("td:eq(1)").text())
		}
		/* datatable initialization start*/

		$(document).ready(function() {

			//$('#applnStatustableId').DataTable();
			$('#applicantsMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});
			getApplicants();

			/*$('#applicantsMainTableId tbody').on('click', 'tr', function() {

				// Check for 'selected' class and remove 
				if ($(this).hasClass('selected')) {
					$(this).removeClass('selected');
				} else {
					table.$('tr.selected').removeClass('selected');
					$(this).addClass('selected');
				}
			});*/

		});
		/* datatable initialization end*/
		
		function setApplicationValues(userId,courseId){
			$("#modalUserId").val(userId);
			$("#modalCourseId").val(courseId);
		}
		function submitFeedbackAndRating(){
			var ratingSelectId = $("#ratingSelectId").val();
			var feedbackId = $("#feedbackId").val();
			var userId = $("#modalUserId").val();
			var courseId = $("#modalCourseId").val();
			//alert(ratingSelectId)
			//alert(feedbackId)
			//alert(userId)
			//alert(courseId)

			$("#ratingSelectIdError").text("");
			$("#feedbackIdError").text("");
			
			if(ratingSelectId==null || ratingSelectId.trim()=="" || ratingSelectId.trim()=="NA"){
				$("#ratingSelectIdError").text("please select rating");
				return false;
			}else if(feedbackId==null || feedbackId.trim()==""){
				$("#feedbackIdError").text("please provide feedback");
				return false;
			}
		var formData = {
				userId : userId,
				courseId : courseId,
				rating : ratingSelectId,
				feedback : feedbackId
			};
			$
					.ajax({
						type : "get",
						url : "update-ta-performance",
						data : formData,
						success : function(responseData, textStatus, jqXHR) {
							//alert("responseData:: " + responseData)
							console.log("data fetched");
							$('#courseDetailsModal').modal('toggle');
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								$("#statusMessage").text(
										"Updated rating successfully!!");
								$("#statusMessage").focus();
								getApplicants();
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

		/*$(document).on('click','.btn-sm',function() {
			var userId = $(this).parents('tr').find("td:eq(0)").text();
			var courseId = $(this).parents('tr').find("td:eq(1)").text();
			var rating = $(this).parents('tr').find("td:eq(5)").find('input,select').val();
			
			
			//alert(userId+" "+courseId+" "+rating);
			if(rating==null || rating.trim()=="" || rating=="NA"){
				alert("please select rating for the selected row");
				return false;
			}else{
				var formData = {
						userId : userId,
						courseId : courseId,
						rating : rating
					};
					$
							.ajax({
								type : "get",
								url : "update-ta-performance",
								data : formData,
								success : function(responseData, textStatus, jqXHR) {
									//alert("responseData:: " + responseData)
									console.log("data fetched");
									if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {							
										$("#statusMessage").text("Updated rating successfully!!");
										$("#statusMessage").focus();
										getApplicants();			
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
			
		});*/

		$("#applicantsRatingMenuId").addClass('active');
	</script>
</body>
</html>