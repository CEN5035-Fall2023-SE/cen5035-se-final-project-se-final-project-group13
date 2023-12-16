<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Application Form</title>
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
			<c:if test="${not empty statusMsg}">
				<c:if test="${statusMsg eq 'FAIL'}">
					<b><p id="statusMsg" style="color: red">Something went
							wrong.please try again!!</p></b>
				</c:if>
			</c:if>

			<b><p id="statusMsg1" style="color: red"></p></b>


			<section class="vh-100"
				style="background-color: #2779e2; overflow-x: scroll; overflow-y: scroll;"
				id="jobApplicationSectionId">

				<form id="upload-form" class="upload-box"
					action="${pageContext.request.contextPath}/save-application"
					method="post" enctype="multipart/form-data">
					
					<input type="text" id="isUserAlreadyAppliedJob" style="display: none;">

					<input type="text" style="display: none;" id="userId" name="userId"
						value="${userDetails.userId}"> <input type="text"
						style="display: none;" id="isPrevExpAdded" name="isPrevExpAdded">
					<input type="text" style="display: none;" name="id1" value="12">
					<input type="text" style="display: none;" name="id1" value="12">

					<input type="text" style="display: none;" id="appliedCoursesLength">

					<div class="container h-100">
						<div
							class="row d-flex justify-content-center align-items-center h-100">
							<div class="col-xl-9">

								<h1 class="text-white mb-4">Apply for a job</h1>

								<div class="card" style="border-radius: 15px;">
									<div class="card-body">
										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-3 ps-5">

												<h6 class="mb-0">Full Name</h6>

											</div>
											<div class="col-md-9 pe-5">

												<input readonly="readonly" disabled="disabled" type="text"
													class="form-control form-control-lg"
													value="${userDetails.lastName} ${userDetails.firstName}" />

											</div>
										</div>



										<hr class="mx-n3">

										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-3 ps-5">

												<h6 class="mb-0">Student ID</h6>

											</div>
											<div class="col-md-9 pe-5">

												<input type="text" name="studentId" id="studentId"
													class="form-control form-control-lg" maxlength="9"
													style="text-transform: uppercase" autocomplete="off" /> <b><span
													id="studentIdError" style="font-size: 10px; color: red"></span></b>

											</div>
										</div>


										<hr class="mx-n3">

										<div class="row align-items-center pt-1 pb-1">
											<div class="col-md-3 ps-5">

												<h6 class="mb-0">Highest Qualification</h6>

											</div>
											<div class="col-md-9 pe-5">

												<select class="form-select" id="qualification"
													name="qualification">
													<option value="NA">Select Degree</option>
													<option value="DEPLOMA">High School Deploma</option>
													<option value="BACHELORS">Bachelors Degree</option>
													<option value="MASTERS">Masters Degree</option>
												</select> <b><span id="qualificationError"
													style="font-size: 10px; color: red"></span></b>

											</div>
										</div>

										<hr class="mx-n3">


										<div class="row align-items-center py-1">
											<div class="col-md-10 ps-5" id="id1">

												<h6 class="mb-0">
													Did you work as a TA previously at North University?
													<!--  <div class="form-check form-check-inline mb-0 me-4"> -->
													<input class="form-check-input" type="radio"
														name="preExpCheckYesOrNoRadioBtn"
														id="preExpCheckYesRadioBtnId" value="YES" /> <label
														class="form-check-label">Yes</label>
													<!--</div> -->

													<!-- <div class="form-check form-check-inline mb-0 me-4"> -->
													<input class="form-check-input" type="radio"
														name="preExpCheckYesOrNoRadioBtn"
														id="preExpCheckNoRadioBtnId" value="NO" checked="true" />
													<label class="form-check-label">No</label>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
														class="fa-solid fa-square-plus" onclick="addCourse()"
														style="display: none;" id="addCourseBtnId"></i>
												</h6>
												<!-- </div> -->
												<c:if test="${not empty userDetails.isJobApplnDone and userDetails.isJobApplnDone eq 'Y'}">
												<br/>
													<button type="button" class="btn btn-primary btn-sm"
														data-bs-toggle="modal" data-bs-target="#prevCoursesModal"
														onclick="getUserPrevCourses()" id="viewPrevCoursedBtnId">View Previous
														Courses</button>
												</c:if>
											</div>
											<b><span class="col-md-4 ps-5 py-3"
												id="preExpCourseDtlsCommonError"
												style="font-size: 10px; color: red"></span></b>
											<div class="col-md-4 ps-5 py-3" id="oldTACourseDivId"
												style="display: none;">

												<span>course</span> <select class="form-select"
													id="preExpCourseName" name="preExpCourseName">
													<option value="NA">Select Course Name</option>
													<c:forEach items="${coursesList}" var="course"
														varStatus="counter">
														<option value="${course.courseId}">${course.courseName}</option>
													</c:forEach>
												</select>


											</div>

											<div class="col-md-4 ps-4 py-2" id="oldTACourseFromDateDivId"
												style="display: none;">

												<span>From Date</span> <input type="date"
													class="form-control" id="preExpCourseFromDate"
													name="preExpCourseFromDate">

											</div>

											<div class="col-md-4 ps-4 py-2" id="oldTACourseToDateDivId"
												style="display: none;">


												<span>To Date</span> <input type="date" class="form-control"
													id="preExpCourseToDate" name="preExpCourseToDate">

											</div>

											<div class="col-md-12 ps-6" id="subCourseDivId"></div>

										</div>




										<!-- New TA -->

										<div class="row align-items-center py-1" id="newTACourseDivId">

											<div class="col-md-3 ps-5">

												<h6 class="mb-0">Course Name</h6>

											</div>

											<div class="col-md-9 pe-5">
												<select id="multipleSelectCourseId" multiple
													name="multipleSelectCourseId" placeholder="Select course"
													data-search="true" data-silent-initial-value-set="true">

													<!-- <option value="NA">Select course</option>-->
													<c:forEach items="${coursesList}" var="course"
														varStatus="counter">
														<option value="${course.courseId}">${course.courseName}</option>
													</c:forEach>
												</select> <b><span id="multipleSelectCourseIdError"
													style="font-size: 10px; color: red"></span></b>
											</div>

										</div>
										<c:if test="${not empty coursesList}">
											<input type="text" value="${coursesList.size()}"
												style="display: none;" id="courseListSize">
										</c:if>

										<hr class="mx-n3">


										<!-- <div class="row align-items-center py-1">
										<div class="col-md-3 ps-5">

											<h6 class="mb-0">Full name</h6>

										</div>
										<div class="col-md-9 pe-5">

											<textarea class="form-control" rows="3"
												placeholder="Message sent to the employer"></textarea>

										</div>
									</div>

									<hr class="mx-n3"> -->

										<div class="row align-items-center py-1">
											<div class="col-md-3 ps-5">

												<h6 class="mb-0">Upload CV</h6>

											</div>
											<div class="col-md-9 pe-5">

												<input class="form-control form-control-lg" id="file"
													name="file" type="file" />
												<div class="small text-muted mt-2">Upload your
													CV/Resume or any other relevant file. Max file size 50 MB</div>
												<b><span id="fileError"
													style="font-size: 10px; color: red"></span></b>
											</div>
										</div>

										<hr class="mx-n3">

										<div class="px-5 py-4">
											<input type="submit" class="btn btn-primary btn-md"
												onclick="return saveApplicationDetails();"
												id="applnSubmitBtnId">
										</div>

									</div>
								</div>

							</div>
						</div>
					</div>
				</form>
			</section>


		</div>



		<div class="modal fade" id="prevCoursesModal" tabindex="-1"
			aria-labelledby="prevCoursesModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="prevCoursesModalLabel">Previous
							Courses</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-hover" border="1px"
							style="overflow-x: scroll; overflow-y: scroll;" id="prevCoursesMainTableId">
							<thead>
								<tr>
									<th scope="col">S.No.</th>
									<th scope="col">Course Name</th>
									<th scope="col">From Date</th>
									<th scope="col">To Date</th>
								</tr>
							</thead>
							<tbody id="prevCourseTableId">
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<!-- <button type="button" class="btn btn-primary">Save
							changes</button> -->
					</div>
				</div>
			</div>
		</div>

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
	/* get user application details start */
	function getUserApplicationDetails() {
		$
				.ajax({
					type : "get",
					url : "getUserApplnCourseDtls",
					data : {
						"" : ""
					},
					success : function(responseData, textStatus, jqXHR) {
						//alert("responseData:: " + responseData)
						if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {

							var dataList = responseData.split("@@SEPARATOR@@")[1];
							//alert(dataList);
							if (dataList == null || dataList == "") {
								//alert("empty");
								$("#isUserAlreadyAppliedJob").val("N");
							} else {

								$("#isUserAlreadyAppliedJob").val("Y");

								$("#studentId").attr("disabled", true);
								//$("#qualification").attr("disabled", true);

								var json = JSON.parse(dataList);

								//$("#preExpCheckYesRadioBtnId").attr('disabled', 'disabled');
								//$("#preExpCheckNoRadioBtnId").attr('disabled', 'disabled');

								var tableString = "";
								var index = 1;
								var options = [];
								var courseListSize = $("#courseListSize").val();
								
								if (json.prevExperience == "N") {
									$("#viewPrevCoursedBtnId").hide();
								}
								$("#studentId").val(json.studentId);
								$("#qualification").val(json.qualification);
								
								if (json.prevExperience == "Y") {
									$("#addCourseBtnId").show();
									$("#preExpCheckYesRadioBtnId").prop("checked", true);
									$("#preExpCheckNoRadioBtnId").attr('disabled', 'disabled');
								}
								/*if (json.prevExperience == "Y") {
									$("#preExpCheckYesRadioBtnId").prop("checked", true);
								}*/
								
								//json.courseDetailsList
								for (let i = 0; i < json.courseDetailsList.length; i++) {
									let courseObj = json.courseDetailsList[i];	
									
									if( (courseObj.courseEndDate!=null && courseObj.courseEndDate!="" && courseObj.courseEndDate!="undefined") ||
										(courseObj.offerRejectedDate!=null && courseObj.offerRejectedDate!="" && courseObj.offerRejectedDate!="undefined") ||
										(courseObj.courseRejDate!=null && courseObj.courseRejDate!="" && courseObj.courseRejDate!="undefined") ){
										
										//do nothing
									}else{
										options.push(courseObj.courseId);
									}
									
								}
								document.querySelector('#multipleSelectCourseId').setDisabledOptions(options);
								/*alert(obj.courseEndDate)
								if(obj.courseEndDate==null || obj.courseEndDate==""){
									document.querySelector('#multipleSelectCourseId').setDisabledOptions(options);
								}*/

								$("#appliedCoursesLength").val(options.length);
								if ($("#appliedCoursesLength").val() == courseListSize) {
									$("#file").attr("disabled", true);
									$("#applnSubmitBtnId").attr("disabled",true);
									$("#statusMsg1").text("you have already applied for all the courses available!!");
									$("#statusMsg1").focus();
								}
							}

						} else {
							//do nothing
						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(errorThrown);
					}
				})
		}
	/* get user application details end */
	
		VirtualSelect.init({
			ele : '#multipleSelectCourseId',
			disableSelectAll : false

		});

		$(function() {
			$("input:file[id=file]").change(
					function() {
						//                      var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
						var fileExtension = [ 'pdf', 'docx', 'doc' ];
						if ($.inArray($(this).val().split('.').pop()
								.toLowerCase(), fileExtension) == -1) {
							alert("Only formats are allowed : "
									+ fileExtension.join(', '));
							$("#file").val("");
							return false;
						}
					});
		});

		function addCourse() {
			//alert("===")

			var dynamicDivString = '<div class="row align-items-center py-1"><i class="fa-solid fa-square-minus" onclick="removeCourse(this)"></i>';
			dynamicDivString += '<div class="col-md-4 ps-5 py-3" id="oldTACourseDivId">';
			dynamicDivString += $("#oldTACourseDivId").html();
			dynamicDivString += '</div>'
			dynamicDivString += '<div class="col-md-4 ps-4 py-2" id="oldTACourseFromDateDivId">';
			dynamicDivString += $("#oldTACourseFromDateDivId").html();
			dynamicDivString += '</div>'
			dynamicDivString += '<div class="col-md-4 ps-4 py-2" id="oldTACourseToDateDivId">';
			dynamicDivString += $("#oldTACourseToDateDivId").html();
			dynamicDivString += '</div>'
			dynamicDivString += '</div>';
			//			alert(dynamicDivString)
			$("#subCourseDivId").append(dynamicDivString);
		}

		function removeCourse(input) {
			$(input).parent().remove();
		}

		$("input[name='preExpCheckYesOrNoRadioBtn']").change(function() {

			if ($(this).val() === 'YES') {
				$("#oldTACourseDivId").show();
				$("#oldTACourseFromDateDivId").show();
				$("#oldTACourseToDateDivId").show();

				$("#addCourseBtnId").show();
				$("#subCourseDivId").show();
			} else if ($(this).val() === 'NO') {

				$("#oldTACourseDivId").hide();
				$("#oldTACourseFromDateDivId").hide();
				$("#oldTACourseToDateDivId").hide();
				$("#subCourseDivId").hide();
				$("#addCourseBtnId").hide();
			}
		});

		function saveApplicationDetails() {

			var isValidationPassed = true;

			var studentId = $("#studentId").val();
			var qualification = $("#qualification").val();
			var multipleSelectCourseId = $("#multipleSelectCourseId").val();

			//if ($("#isUserAlreadyAppliedJob").val() == "Y") {
				//if (multipleSelectCourseId == "") {
					//$("#multipleSelectCourseIdError").text("Select courses");
					//isValidationPassed = false;
				//}
			//}else{
				
				/*var element = document.getElementById('subCourseDivId');
				var children = element.children;
				for(var i=0; i<children.length; i++){
				    var child = children[i];
				   
				}*/

				$("#studentIdError").text("");
				$("#qualificationError").text("");
				$("#multipleSelectCourseIdError").text("");
				$("#fileError").text("");
				$("#preExpCourseDtlsCommonError").text("");

				var isPrevExpAdded = "N";
				if ($('#preExpCheckYesRadioBtnId').is(':checked')) {
					isPrevExpAdded = "Y";
				}
				$("#isPrevExpAdded").val(isPrevExpAdded);
				//alert(multipleSelectCourseId)
				//alert($('#multipleSelectCourseId').has('option').length)

				if (studentId == null || studentId.trim() == "") {
					$("#studentIdError").text("Student ID can't be empty");
					isValidationPassed = false;

				} else if (studentId.toUpperCase().charAt(0) != "Z"
						|| studentId.length != 9) {
					$("#studentIdError")
							.text(
									"please make sure Student ID should start with Z and should be 9 characters");
					isValidationPassed = false;

				} else if (qualification == null || qualification.trim() == ""
						|| qualification == "NA") {
					$("#qualificationError").text("Qualification can't be empty");
					isValidationPassed = false;

				} else if (multipleSelectCourseId == "") {
					$("#multipleSelectCourseIdError").text("Select courses");
					isValidationPassed = false;

				} else if ($('#preExpCheckYesRadioBtnId').is(':checked')) {
					var preExpCourseName = $("#preExpCourseName").val();
					var preExpCourseFromDate = $("#preExpCourseFromDate").val();
					var preExpCourseToDate = $("#preExpCourseToDate").val();

					$("select[name=preExpCourseName]").each(function(idx) {
								if($(this).is(":hidden")==false){
									var course = $(this).val();
									//alert("course:: "+course)
									if (course == null || course.trim() == ""
											|| course.trim() == "NA") {
										isValidationPassed = false;

									}
								}
								
							});
					$("input[name=preExpCourseFromDate]").each(function(idx) {
						if($(this).is(":hidden")==false){
							var fromDate = $(this).val();
							//alert("fromDate:: "+fromDate)
							if (fromDate == null || fromDate.trim() == "") {
								isValidationPassed = false;
								
							}
						}
						
					});
					$("input[name=preExpCourseToDate]").each(function(idx) {
						if($(this).is(":hidden")==false){
							var toDate = $(this).val();
							//alert("toDate:: "+toDate)
							if (toDate == null || toDate.trim() == "") {
								isValidationPassed = false;
								
							}
						}
						
					});

					if (!isValidationPassed) {
						$("#preExpCourseDtlsCommonError")
								.text(
										"please fill all the details - course,from date and to date for all the sections added");
					}

				}

				if ($("#isUserAlreadyAppliedJob").val() == "Y") {
					//do nothing
				}else{
					if (isValidationPassed
							&& ($("#file").val() == null || $("#file").val().trim() == "")) {
						$("#fileError").text("Please upload CV/resume");
						isValidationPassed = false;

					}else {
						var fileSize = $('#file')[0].files[0].size/1024/1024;
						if(fileSize>5){
							$("#fileError").text("File size is allowed upto 5MB");
							isValidationPassed = false;
						}

					}
				}
				
			//}

			return isValidationPassed;
		}

		//function saveApplicationDetails() {
		//alert("student id:: " + $("#studentId").val())
		//alert("degree " + $("#qualification").val())
		//alert("preExpCourseName " + $("#preExpCourseName").val())
		//alert("preExpCourseFromDate " + $("#preExpCourseFromDate").val())
		//alert("preExpCourseToDate " + $("#preExpCourseToDate").val())
		//alert("multipleSelectCourseId "
		//		+ $("#multipleSelectCourseId").val())

		/*if(validateJobApplicationDetails()){
			var isPrevExpAdded = "N";
			if ($('#preExpCheckYesRadioBtnId').is(':checked')) {
				isPrevExpAdded = "Y";
			}
			$("#isPrevExpAdded").val(isPrevExpAdded);
			//alert("isPrevExpAdded:: " + isPrevExpAdded);
			//course name..
			var courseArr = document.getElementsByName("preExpCourseName");
			var coursesString = "";
			for (var i = 0; i < courseArr.length; i++) {
				coursesString += courseArr[i].value + ",";
			}
			//alert("preExpCourseName:: " + coursesString)
			//course start date..
			var preExpCourseFromDateArr = document
					.getElementsByName("preExpCourseFromDate");
			var coursesFromDateString = "";
			for (var i = 0; i < preExpCourseFromDateArr.length; i++) {
				coursesFromDateString += preExpCourseFromDateArr[i].value + ",";
			}
			//alert("coursesFromDateString:: " + coursesFromDateString)
			//course end date..
			var preExpCourseToDateArr = document
					.getElementsByName("preExpCourseToDate");
			var coursesToDateString = "";
			for (var i = 0; i < preExpCourseToDateArr.length; i++) {
				coursesToDateString += preExpCourseToDateArr[i].value + ",";
			}
			return true;
		}*/

		//}
		$(document).ready(function() {
			$('#upload-form')[0].reset();
			
			var today = new Date().toISOString().split('T')[0];
			//alert(today)
			$("#preExpCourseFromDate").attr("max",today);
			$("#preExpCourseToDate").attr("max",today);
			
			getUserApplicationDetails();

			$("#studentId").on("keypress", function(e) {
				
				var studentId = $("#studentId").val();
				var length = studentId.length;
				if(length==0){
					if (e.charCode == 90 || e.charCode == 122) {
						return true;
					}else{
						return false;
					}
				}else{
					if (e.charCode == 90 || e.charCode == 122) {
						e.preventDefault();
						return false;
					}
				}
				
				var $this = $(this);
				var regex = new RegExp("^[0-9\b]+$");
				var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
				// for 10 digit number only
				if ($this.val().length > 9) {
					e.preventDefault();
					return false;
				}
				/*if (e.charCode == 90 || e.charCode == 122) {
					return true;
				}*/
				if (regex.test(str)) {
					return true;
				}
				e.preventDefault();
				return false;
			});
			
		});
		$("#applicationFormMenuId").addClass('active');
		//
		/*Get Previous course details based on userId -  start*/
		function getUserPrevCourses(userId) {
			//alert("===")

			var formData = {
				userId : $("#userId").val()
			};
			//alert("==")
			$
					.ajax({
						type : "post",
						url : "get-prev-courses",
						data : formData,
						success : function(responseData, textStatus, jqXHR) {
							//alert("responseData:: " + responseData)
							console.log("data fetched");
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								var courseList = responseData.split("@@SEPARATOR@@")[1];
								$("#prevCourseTableId tr").remove();
								setTableDataForPrevCourses(courseList);
								//$("#statusMsg").text("Updation is success.");
								//$("#statusMsg").css("color", "blue");
								//$("#statusMsg").focus();
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

			$('#prevCoursesMainTableId').DataTable().clear().destroy();
			$("#prevCourseTableId").append(tableString);
			$('#prevCoursesMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});

		}
		
		/*check applicant eligibility for course start*/
		
		function getProfessorDetailsByCourseId(courseId) {
			$
					.ajax({
						type : "get",
						url : "checkApplicantEligibleForCourse",
						data : {
							courseId : courseId
						},
						success : function(responseData, textStatus, jqXHR) {
							alert(responseData)
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
		/*check applicant eligibility for course end*/
	</script>

</body>
</html>