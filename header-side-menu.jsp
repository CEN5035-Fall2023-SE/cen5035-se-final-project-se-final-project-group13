
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

<script src="https://kit.fontawesome.com/2b9cdc1c9a.js"
	crossorigin="anonymous"></script>



<link rel="stylesheet" href="virtual-select.min.css" />
<script src="virtual-select.min.js"></script>

<link rel="stylesheet" href="custom-css.css">

<!-- datatable start-->
<script
	src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
<script
	src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<link
	href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css"
	rel="stylesheet">
<script
	src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>
<link
	href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css"
	rel="stylesheet">
<!-- datatable end -->

<script type="text/javascript">
	var lastActiveTimeMs = new Date().getTime(); //This is set to current time on page load
	var SESSION_TIMEOUT_MILLIS = 30 * 60 * 1000; //1 min in milliseconds
	var CHECK_TIME_MILLIS = 60 * 1000; //1 mins in milliseconds

	setTimeout(fnCheckTimeout, CHECK_TIME_MILLIS); //Check the timeout once in a minute
	function fnCheckTimeout() {
		var curMs = new Date().getTime();
		if ((curMs - lastActiveTimeMs) > SESSION_TIMEOUT_MILLIS) {
			window.location.href = 'login.jsp';
		}
	}
</script>



</head>
<body>

	<c:if test="${empty userDetails}">
		<script>
			window.location.href = 'login.jsp';
		</script>
	</c:if>


	<nav id="sidebarMenu"
		class="collapse d-lg-block sidebar collapse bg-white">
		<div class="position-sticky">
			<div class="list-group list-group-flush mx-3 mt-4">

				<a href="profile.jsp"
					class="list-group-item list-group-item-action py-2 ripple"
					id="profileMenuId"> <i
					class="fa-solid fa-user-circle fa-fw me-3"></i> <span>Profile</span>
				</a>


				<c:if test="${userDetails.userType eq 'TA Applicant'}">
					<a href="application-track.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="dashboardMenuId" aria-current="true"> <i
						class="fas fa-tachometer-alt fa-fw me-3"></i><span>Application
							Status</span>
					</a>
					
					<!-- <a href="old-application-track.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="oldApplnTrackMenuId" aria-current="true"> <i
						class="fas fa-tachometer-alt fa-fw me-3"></i><span>Old Application
							Status</span>
					</a> -->

					<%-- <c:if test="${empty userDetails.isJobApplnDone or userDetails.isJobApplnDone eq 'N'}"> --%>
					<a href="applicant-registration.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="applicationFormMenuId"><img src="form-filling.jpg"
						width="22" height="20" alt="Sample image"><span>&nbsp;&nbsp;
							Application Form</span></a>
					<%-- </c:if> --%>

				</c:if>



				<c:if test="${userDetails.userType eq 'TA Admin'}">

					<a href="add-course.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="addCourseMenuId"><i
						class="fa fas fa-circle-plus fa-fw me-3"></i><span>Add
							Course</span></a>

					<a href="applicants-details.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="applicantsDetailsMenuId"><i
						class="fa-solid fa-user fa-fw me-3"></i><span>Applicants
							Details</span></a>
					</a>

					<a href="view-committee-members.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="applicantsDetailsMenuId"><i
						class="fa-solid fa-user fa-fw me-3"></i><span>Committee Details</span></a>
					</a>

					<a href="view-instructors.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="applicantsDetailsMenuId"><i
						class="fa-solid fa-user fa-fw me-3"></i><span>Instructors</span></a>
					</a>
				</c:if>


				<c:if test="${userDetails.userType eq 'TA Committee'}">

					<a href="applicants-details.jsp"
						class="list-group-item list-group-item-action py-2 ripple"
						id="applicantsDetailsMenuId"><i
						class="fa-solid fa-user fa-fw me-3"></i><span>Applicants
							Details</span></a>

				</c:if>


				<c:if test="${userDetails.userType eq 'TA Instructor'}">

					<a href="applicants-rating.jsp"
						class="list-group-item list-group-item-action py-2 ripple" id="applicantsRatingMenuId"> <i
						class="fa-solid fa-person-chalkboard me-3"></i> <span>TA
							Instructor</span>
					</a>
					
				</c:if>

			</div>
		</div>
	</nav>


	<nav id="main-navbar"
		class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
		<!-- Container wrapper -->
		<div class="container-fluid">
			<!-- Toggle button -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#sidebarMenu"
				aria-controls="sidebarMenu" aria-expanded="false"
				aria-label="Toggle navigation">
				<i class="fa fas fa-bars"></i>
			</button>

			<!-- Brand -->
			<a class="navbar-brand" href="#"> <img
				src="https://mdbootstrap.com/img/logo/mdb-transaprent-noshadows.png"
				height="25" alt="" loading="lazy" />
			</a> <b style="color: black; text-transform: uppercase;">Welcome
				${userDetails.lastName} ${userDetails.firstName}</b>
			<!-- Right links -->
			<ul class="navbar-nav ms-auto d-flex flex-row">
				<!-- Notification dropdown -->
				<li class="nav-item dropdown"><a
					class="nav-link me-3 me-lg-0 dropdown-toggle hidden-arrow" href="#"
					id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown"
					aria-expanded="false"> <i class="fa fas fa-bell"></i> <span
						class="badge rounded-pill badge-notification bg-danger">1</span>
				</a>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="navbarDropdownMenuLink">
						<!-- <li><a class="dropdown-item" href="#">Some news</a></li>
						<li><a class="dropdown-item" href="#">Another news</a></li>
						<li><a class="dropdown-item" href="#">Something else here</a></li> -->
					</ul></li>

				<!-- Icon -->
				<li class="nav-item"><a class="nav-link me-3 me-lg-0" href="#">
						<i class="fas fa-fill-drip"></i>
				</a></li>
				<!-- Icon -->
				<li class="nav-item me-3 me-lg-0"><a class="nav-link" href="#">
						<i class="fa fab fa-github"></i>
				</a></li>

				<!-- Icon dropdown -->
				<li class="nav-item dropdown"><a
					class="nav-link me-3 me-lg-0 dropdown-toggle hidden-arrow" href="#"
					id="navbarDropdown" role="button" data-bs-toggle="dropdown"
					aria-expanded="false"> <i class="united kingdom flag m-0"></i>
				</a></li>

				<!-- Avatar -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle hidden-arrow d-flex align-items-center"
					href="#" id="navbarDropdownMenuLink" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> <img
						src="https://mdbootstrap.com/img/Photos/Avatars/img (31).jpg"
						class="rounded-circle" height="22" alt="" loading="lazy" />
				</a>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="navbarDropdownMenuLink">
						<!-- <li><a class="dropdown-item" href="#">My profile</a></li>
						<li><a class="dropdown-item" href="#">Settings</a></li> -->
						<form id="logoutFormId" name="logoutFormId" method="get"
							action="${pageContext.request.contextPath}/logout">
							<li><a class="dropdown-item" href="javascript:void()"
								onclick="$('#logoutFormId').submit();">Logout</a></li>
						</form>
					</ul></li>
			</ul>
		</div>
		<!-- Container wrapper -->
	</nav>


</body>
</html>

