<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Application Track</title>
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

	<c:when test="${not empty userDetails && userDetails.userType eq 'TA Applicant'}">
   
	<!--Main layout-->
	<main style="margin-top: 58px">
		<div class="container pt-4">


			<section class="vh-100"
				style="background-color: ash; overflow-x: scroll; overflow-y: scroll;">

				<form id="track-appln-status-form" name="track-appln-status-form">

					<div class="container h-100">

						<h4 style="font-family: inherit;">
							<p>
								<u>Application Status:</u>
							</p>

							<div id="applicationPendingStatusDivId" style="display: block;">
								<h4 style="color: orange; font-size: 18px;">
									<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Not yet applied for
										TA?</i> <a href="applicant-registration.jsp"> Click Here</a>
								</h4>
							</div>


						</h4>

						<div id="applnStatusTrackDivId">
							<h4 style="color: orange; font-size: 18px;"
								id="applnStatusHeadingId">
								<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Application has
									been received and check course wise status below</i>
							</h4>
							<p id="statusMessage"
								style="color: blue; font-style: italic; font-size: 20px;"></p>
							<table class="table table-bordered table-hover table-striped"
								border="1px"
								style="overflow-x: scroll; overflow-y: scroll; width: 100%"
								id="applnStatusTableId">
								<thead>
									<tr>
										<th scope="col">S.No.</th>
										<th scope="col">Application ID</th>
										<th scope="col">Course ID</th>
										<th scope="col">View Status</th>
									</tr>
								</thead>
								<tbody id="courseTableId">
								</tbody>
							</table>
						</div>

					</div>
				</form>
			</section>


		</div>
		
		
		
		
		<!-- Application Details view Modal start -->
		<div class="modal fade" id="applnTrackDetailsModal" tabindex="-1"
			aria-labelledby="applnTrackModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="applnTrackModalLabel">Application
							Details</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" style="pointer-events: none;">
				
			<div id="courseDtlsTrackDivId">
						<div class="row">
							<div class="col-md-4 mb-3">
								<label for="validationCustom01"><h6 class="mb-0">Application
										ID</h6></label> <input type="text" class="form-control" id="modalApplnId"
									disabled="disabled" style="pointer-events: none;">
							</div>
							<div class="col-md-4 mb-3">
								<label for="validationCustom02"><h6 class="mb-0">Course ID</h6></label> <input type="text" class="form-control"
									id="modalCourseId" disabled="disabled">
							</div>
							<div class="col-md-4 mb-3">
								<label for="validationCustom02"><h6 class="mb-0">POC(Professor Email Address)</h6></label> <input type="text" class="form-control"
									id="modalProfessorEmailId" disabled="disabled">
							</div>
						</div>

						<hr />
						
						<div class="row">
							<div class="col-md-4 mb-3">
								<label for="validationCustom01"><h6 class="mb-0">Application Status</h6></label>
								<input type="text" class="form-control" id="modalApplnStatusId"
									disabled="disabled">
							</div>
							<div class="col-md-4 mb-3">
								<label for="validationCustom02"><h6 class="mb-0">Offer Status</h6></label> <input type="text" class="form-control"
									id="modalOfferStatusId" disabled="disabled">
							</div>
							<div class="col-md-4 mb-3" id="modalOfferAcceptedOnDivId" style="display: none;">
								<label for="validationCustom02"><h6 class="mb-0">Offer Accepted On</h6></label> <input type="text" class="form-control"
									id="modalOfferAcceptedOnId" disabled="disabled">
							</div>
							<div class="col-md-4 mb-3" id="modalOfferRejOnDivId" style="display: none;">
								<label for="validationCustom02"><h6 class="mb-0">Offer Rejected On</h6></label> <input type="text" class="form-control"
									id="modalOfferRejOnId" disabled="disabled">
							</div>
							<div class="col-md-4 mb-3" id="modalCourseRejOnDivId" style="display: none;">
								<label for="validationCustom02"><h6 class="mb-0">Course Rejected On</h6></label> <input type="text" class="form-control"
									id="modalCourseRejOnId" disabled="disabled">
							</div>
						</div>

</div>
					</div>
					<div class="modal-footer">
					<div id="apprvRejOfferDivId"></div>
						<button type="button" class="btn btn-secondary btn-sm"
							data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Application Details view Modal end -->
		
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
		/* datatable initialization start */
		$(document).ready(function() {
			$('#track-appln-status-form')[0].reset();
			/*$('#applnStatusTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});*/
		});
		/* datatable initialization end */

		/* accept/decline offer start */
		function acceptOrDeclineOffer(actionType, courseId) {
			var text = "";
			var isConfirmed = false;
			if(actionType=="ACCEPTED")
				text = "Please confirm you are going to accept this offer.";
			else
				text = "Please confirm you are going to decline this offer.";
			
			if (confirm(text) == true) {
				isConfirmed = true;
			} else {
				isConfirmed = false;
			}
			if(isConfirmed){
				$.ajax({
					type : "post",
					url : "updateOfferStatus",
					data : {
						offerStatus : actionType,
						courseId : courseId
					},
					success : function(responseData, textStatus, jqXHR) {
						$('#applnTrackDetailsModal').modal('toggle');
						if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
							trackApplicationStatus();
							$("#statusMessage").text(
									"Offer status is updated");
						} else {
							$("#statusMessage")
									.text(
											"Something went wrong.please try again later!");
						}

						$("#statusMessage").focus();
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(errorThrown);
					}
				})
			}
			
		}
		/* accept/decline offer end */

		/* TA User course wise tracking status start */
		trackApplicationStatus();
		function trackApplicationStatus() {

			$
					.ajax({
						type : "post",
						url : "track-appln-status",
						data : {},
						success : function(responseData, textStatus, jqXHR) {
							///alert("responseData:: " + responseData)
							///alert(responseData.split("@@SEPARATOR@@")[1])
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								var courseList = responseData.split("@@SEPARATOR@@")[1];
								$("#courseTableId tr").remove();

								if (courseList != null
										&& courseList.trim() != "") {
									$("#applnStatusTrackDivId").show();
									//$("#applicationPendingStatusDivId").hide();
									setTableData(courseList);
								} else {
									//$("#applicationPendingStatusDivId").show();
									$("#applnStatusTrackDivId").hide();
								}

							} else {
								$("#statusMessage")
										.text(
												"Something went wrong.please try again later!");
								$("#statusMessage").focus();
							}

						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(errorThrown);
						}
					});

		}

		function setTableData(courseList) {
			var json = JSON.parse(courseList);
			var tableString = "";
			var index = 1;
			for (let i = 0; i < json.length; i++) {
				let obj = json[i];
				tableString += "<tr>";

				tableString += '<td scope="row">';
				tableString += index;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.applicationId;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.courseId;
				tableString += "</td>";

				var applicationId = "'"+obj.applicationId+"'";
				var courseId = "'"+obj.courseId+"'";
				var courseUniqueId = "'"+obj.courseUniqueId+"'";
				
				tableString += "<td>";
				tableString += '<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#applnTrackDetailsModal" onclick="loadApplicantCourseDetailsForTracking('+applicationId+','+courseId+','+courseUniqueId+')">View Status</button>';
				tableString += "</td>";
				
				tableString += "</tr>";

				index++;
			}

			$("#courseTableId").append(tableString);

			$('#applnStatusTableId').DataTable().clear().destroy();
			$("#courseTableId").append(tableString);
			$('#applnStatusTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});

		}
		/* TA User course wise tracking status end */

		function setApplicantCourseDtls(applicantCourseDtls,applnId){

			$("#apprvRejOfferDivId").html("");
			$("#modalOfferAcceptedOnDivId").hide();
			$("#modalOfferRejOnDivId").hide();
			$("#modalCourseRejOnDivId").hide();
			//
			var obj = JSON.parse(applicantCourseDtls);
			//
			$("#modalApplnId").val("");
			$("#modalCourseId").val("");
			$("#modalProfessorEmailId").val("");
			$("#modalApplnStatusId").val("");
			$("#modalOfferStatusId").val("");
			$("#modalOfferAcceptedOnId").val("");
			$("#modalOfferRejOnId").val("");
			//
			if (obj.offerStatus != null && obj.offerStatus.trim()!="" && obj.offerStatus.trim()!="undefined"){
				
				$("#modalOfferStatusId").val(obj.offerStatus);
				if(obj.offerStatus=="ACCEPTED"){
					$("#modalOfferAcceptedOnDivId").show();
					$("#modalOfferAcceptedOnId").val(obj.offerAcceptedDate);
					$("#modalOfferRejOnDivId").hide();
				}else if(obj.offerStatus=="DECLINED"){
					$("#modalOfferRejOnDivId").show();
					$("#modalOfferRejOnId").val(obj.offerRejectedDate);	
					$("#modalOfferAcceptedOnDivId").hide();				
				}
			}			
			else{
				$("#modalOfferStatusId").val("NA");
			}
			
			$("#modalApplnId").val(applnId);
			$("#modalCourseId").val(obj.courseId);
			$("#modalProfessorEmailId").val(obj.professorDetails.emailAddress);
			
			
			if (obj.applicationStatus == "PENDING"){
				$("#modalApplnStatusId").val(obj.applicationStatus);
			}else{
				if (obj.isNotified != null && obj.isNotified == "Y"){
					$("#modalApplnStatusId").val(obj.applicationStatus);
					
					if (obj.applicationStatus == "REJECTED" ){
						$("#modalCourseRejOnDivId").show();
						$("#modalCourseRejOnId").val(obj.courseRejDate);
					}
					
				}else{
					$("#modalApplnStatusId").val("PENDING");			
				}
			}
			
			/*if (offerStatus != null && offerStatus.trim()!="" && offerStatus.trim()!="undefined"){
				// do nothing i.e not adding accept/decline offer buttons
				$("#apprvRejOfferDivId").html("");
			}else{*/
				if (obj.applicationStatus == 'APPROVED' && (obj.isNotified != null && obj.isNotified == "Y") &&
						(obj.offerStatus == null || obj.offerStatus.trim()=="" || obj.offerStatus.trim()=="undefined") ) {
					var apprvStatus = "'ACCEPTED'";
					var rejStatus = "'DECLINED'";
					var courseId = "'" + obj.courseId + "'";
					var tableString = '<button type="button" class="btn btn-primary btn-sm" onclick="acceptOrDeclineOffer('
							+ apprvStatus
							+ ','
							+ courseId
							+ ');">Accept Offer</button> &nbsp;<button type="button" class="btn btn-danger btn-sm" onclick="acceptOrDeclineOffer('
							+ rejStatus
							+ ','
							+ courseId
							+ ');">Decline Offer</button>';
							
							$("#apprvRejOfferDivId").append(tableString);
				}
			//}
		}
		function loadApplicantCourseDetailsForTracking(applnId,courseId,courseUniqueId){
			$
			.ajax({
				type : "get",
				url : "getApplcantCourseStatusDtls",
				data : {courseId:courseId,courseUniqueId:courseUniqueId},
				success : function(responseData, textStatus, jqXHR) {
					if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
						$("#apprvRejOfferDivId").html("");
						var applicantCourseDtls = responseData.split("@@SEPARATOR@@")[1];
						if (applicantCourseDtls != null && applicantCourseDtls.trim() != "") {
							$("#courseDtlsTrackDivId").show();
							setApplicantCourseDtls(applicantCourseDtls,applnId);
						}else{
							$("#courseDtlsTrackDivId").hide();
						} 
					} else {
						$("#statusMessage").text("Something went wrong.please try again later!");
						$("#statusMessage").focus();
					}

				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(errorThrown);
				}
			});
		}
		
		$("#dashboardMenuId").addClass('active');
	</script>

</body>
</html>