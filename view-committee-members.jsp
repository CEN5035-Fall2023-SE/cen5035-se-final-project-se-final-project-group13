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

		<c:when
			test="${not empty userDetails && userDetails.userType eq 'TA Admin'}">
			<!--Main layout-->
			<main style="margin-top: 58px">

				<div class="container pt-4">

					<section class="vh-100"
						style="background-color: ash; overflow-x: scroll; overflow-y: scroll;">

						<form id="get-applicants-form" name="get-applicants-form">

							<div class="container h-100">

								<div
									class="row d-flex justify-content-center align-items-center h-100">
									<div class="col-xl-12">

										<h2 class="mb-6"
											style="font-family: Calibri; color: black; font-size: 22px;">
											<b>Committee Members </b>
										</h2>

										<div class="card" style="border-radius: 15px;">
											<b id="statusMessage" style="color: blue"></b>


											<div class="card-body"
												style="overflow-x: scroll; overflow-y: scroll;">



												<table class="table table-bordered table-hover" border="1px"
													style="overflow-x: scroll; overflow-y: scroll;"
													id="committeeMembersMainTableId">
													<thead>
														<tr>
															<th scope="col">First Name</th>
															<th scope="col">Last Name</th>
															<th scope="col">Mobile No.</th>
															<th scope="col">Email Address</th>
															<th scope="col">Created Time</th>
														</tr>
													</thead>
													<tbody id="committeeMembersTableId">
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
		function getUserDetailsByUserType() {

			var formData = {
				userType : 'TA Committee'
			};
			$
					.ajax({
						type : "post",
						url : "getUserDtlsByUserType",
						data : formData,
						success : function(responseData, textStatus, jqXHR) {
							//alert("responseData:: " + responseData)
							console.log("data fetched");
							if (responseData.split("@@SEPARATOR@@")[0] == "SUCCESS") {
								$("#committeeMembersTableId tr").remove();
								var usersList = responseData
										.split("@@SEPARATOR@@")[1];
								if (usersList != null && usersList != "") {
									$("#committeeMembersTableId tr").remove();
									setTableData(usersList);
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

		function setTableData(usersList) {
			var json = JSON.parse(usersList);
			var tableString = "";
			var index = 1;
			for (let i = 0; i < json.length; i++) {
				let obj = json[i];
				tableString += "<tr>";

				tableString += '<td>';
				tableString += obj.firstName;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.lastName;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.mobileNumber;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.emailAddress;
				tableString += "</td>";

				tableString += "<td>";
				tableString += obj.createTime;
				tableString += "</td>";

				tableString += "</tr>";

				index++;
			}

			$('#committeeMembersMainTableId').DataTable().clear().destroy();
			$("#committeeMembersTableId").append(tableString);
			$('#committeeMembersMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});

		}
		/* datatable initialization start*/

		$(document).ready(function() {

			//$('#applnStatustableId').DataTable();
			$('#committeeMembersMainTableId').dataTable({
				"lengthMenu" : [ 5, 10, 25, 75, 100 ]
			});
			getUserDetailsByUserType();

		});
		/* datatable initialization end*/

		$("#applicantsRatingMenuId").addClass('active');
	</script>
</body>
</html>