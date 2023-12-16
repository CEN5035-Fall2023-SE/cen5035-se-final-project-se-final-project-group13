package com.teachingassistant.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.ProfessorDetails;
import com.teachingassistant.bean.UserApplicationDetails;
import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.bean.UserPrevExpCourseDetails;
import com.teachingassistant.util.AppConstants;
import com.teachingassistant.util.DBUtil;

public class UserDaompl implements IUserDao {

	@Override
	public String saveUserDetails(UserDetails userDetails) throws Exception {

		boolean isSignUpPage = true;
		try (Connection connection = DBUtil.getConnection();) {

			if (isUserNameAlreadyExist(userDetails, connection)) {
				return "USERNAME_EXIST";
			}
			if (isMobileNoAlreadyExist(userDetails, connection, AppConstants.MOBILENO_EXIST_CHECK_SELECT_QRY,
					isSignUpPage)) {
				return "MOBILENO_EXIST";
			}
			if (isEmailAddressAlreadyExist(userDetails, connection, AppConstants.EMAIL_EXIST_CHECK_SELECT_QRY,
					isSignUpPage)) {
				return "EMAILADDRESS_EXIST";
			}
			PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.USER_DETAILS_INSERT_QRY);
			preparedStatement.setString(1, userDetails.getFirstName());
			preparedStatement.setString(2, userDetails.getLastName());
			preparedStatement.setString(3, userDetails.getMobileNumber());
			preparedStatement.setString(4, userDetails.getEmailAddress());
			preparedStatement.setString(5, userDetails.getUserType());
			preparedStatement.setString(6, userDetails.getUserName());
			preparedStatement.setString(7, userDetails.getPassword());

			preparedStatement.execute();
			return "SUCCESS";
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public String updateUserDetails(UserDetails userDetails) throws Exception {
		boolean isSignUpPage = false;
		try (Connection connection = DBUtil.getConnection();) {

			if (isMobileNoAlreadyExist(userDetails, connection, AppConstants.UPDATE_MOBILENO_EXIST_CHECK_SELECT_QRY,
					isSignUpPage)) {
				return "MOBILENO_EXIST";
			}
			if (isEmailAddressAlreadyExist(userDetails, connection, AppConstants.UPDATE_EMAIL_EXIST_CHECK_SELECT_QRY,
					isSignUpPage)) {
				return "EMAILADDRESS_EXIST";
			}

			PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.USER_DETAILS_UPDATE_QRY);
			preparedStatement.setString(1, userDetails.getFirstName());
			preparedStatement.setString(2, userDetails.getLastName());
			preparedStatement.setString(3, userDetails.getMobileNumber());
			preparedStatement.setString(4, userDetails.getEmailAddress());
			preparedStatement.setString(5, userDetails.getPassword());
			preparedStatement.setString(6, userDetails.getUserId());

			preparedStatement.execute();

			return "SUCCESS";
		} catch (Exception e) {
			throw e;
		}

	}

	public boolean isUserNameAlreadyExist(UserDetails userDetails, Connection connection) throws Exception {
		boolean isExist = false;

		try (PreparedStatement pstmt = connection.prepareStatement(AppConstants.USERNAME_EXIST_CHECK_SELECT_QRY);) {

			pstmt.setString(1, userDetails.getUserName());
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				isExist = true;
			}
		} catch (Exception e) {
			throw e;
		}
		return isExist;
	}

	public boolean isMobileNoAlreadyExist(UserDetails userDetails, Connection connection, String query,
			boolean isSignUpPage) throws Exception {
		boolean isExist = false;

		try (PreparedStatement pstmt = connection.prepareStatement(query);) {

			pstmt.setString(1, userDetails.getMobileNumber());
			if (!isSignUpPage) {
				pstmt.setString(2, userDetails.getUserId());
			}
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				isExist = true;
			}
		} catch (Exception e) {
			throw e;
		}
		return isExist;
	}

	public boolean isEmailAddressAlreadyExist(UserDetails userDetails, Connection connection, String query,
			boolean isSignUpPage) throws Exception {
		boolean isExist = false;

		try (PreparedStatement pstmt = connection.prepareStatement(query);) {

			pstmt.setString(1, userDetails.getEmailAddress());
			if (!isSignUpPage) {
				pstmt.setString(2, userDetails.getUserId());
			}
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				isExist = true;
			}
		} catch (Exception e) {
			throw e;
		}
		return isExist;
	}

	@Override
	public boolean saveUserJobApplicationDetails(UserApplicationDetails userApplicationDetaills,
			List<UserPrevExpCourseDetails> userPrevExpCourseDetailsList, List<CourseDetails> courseDetailsList)
			throws Exception {

		boolean isTxnSuccess = false;
		try (Connection connection = DBUtil.getConnection();) {

			try {
				connection.setAutoCommit(false);

				PreparedStatement preparedStatement = connection
						.prepareStatement(AppConstants.USER_JOB_APPLICATION_INSERT_QRY);

				preparedStatement.setString(1, userApplicationDetaills.getUserId());
				preparedStatement.setString(2, userApplicationDetaills.getStudentId());
				preparedStatement.setString(3, userApplicationDetaills.getQualification());
				preparedStatement.setString(4, userApplicationDetaills.getPrevExperience());
				preparedStatement.setString(5, userApplicationDetaills.getCvFileName());
				preparedStatement.execute();

				if (userPrevExpCourseDetailsList != null) {
					saveUserPrevExpCourseDetails(userPrevExpCourseDetailsList, connection);
				}
				saveUserNewCourseDetails(courseDetailsList, userApplicationDetaills.getUserId(), connection);

				connection.commit();
				isTxnSuccess = true;
			} catch (Exception e) {
				if (connection != null) {
					connection.rollback();
				}
				throw e;
			} finally {
				if (connection != null) {
					connection.commit();
				}
			}

		} catch (Exception e) {
			throw e;
		}
		return isTxnSuccess;
	}

	@Override
	public boolean updateUserJobApplicationDetails(UserApplicationDetails userApplicationDetaills,
			List<UserPrevExpCourseDetails> userPrevExpCourseDetailsList, List<CourseDetails> courseDetailsList)
			throws Exception {

		boolean isTxnSuccess = false;
		String sqlQry = "";
		if (userApplicationDetaills.getCvFileName() != null && !userApplicationDetaills.getCvFileName().equals("")) {
			sqlQry = AppConstants.UPDATE_TA_APPLICATION_DTLS;
		} else {
			sqlQry = AppConstants.UPDATE_TA_QUALIFICATION;
		}
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sqlQry);) {

			try {
				connection.setAutoCommit(false);

				if (userApplicationDetaills.getCvFileName() != null
						&& !userApplicationDetaills.getCvFileName().equals("")) {
					preparedStatement.setString(1, userApplicationDetaills.getQualification());
					preparedStatement.setString(2, userApplicationDetaills.getCvFileName());
					preparedStatement.setString(3, userApplicationDetaills.getUserId());

				} else {
					preparedStatement.setString(1, userApplicationDetaills.getQualification());
					preparedStatement.setString(2, userApplicationDetaills.getUserId());
				}
				preparedStatement.execute();

				if (userPrevExpCourseDetailsList != null && userPrevExpCourseDetailsList.size() > 0) {
					saveUserPrevExpCourseDetails(userPrevExpCourseDetailsList, connection);
				}
				saveUserNewCourseDetails(courseDetailsList, userApplicationDetaills.getUserId(), connection);

				connection.commit();
				isTxnSuccess = true;
			} catch (Exception e) {
				if (connection != null) {
					connection.rollback();
				}
				throw e;
			} finally {
				if (connection != null) {
					connection.commit();
				}
			}

		} catch (Exception e) {
			throw e;
		}
		return isTxnSuccess;
	}

	public void saveUserPrevExpCourseDetails(List<UserPrevExpCourseDetails> userPrevExpCourseDetailsList,
			Connection connection) throws Exception {
		try (PreparedStatement preparedStatement = connection
				.prepareStatement(AppConstants.USER_PREV_EXP_COURSE_INSERT_QRY)) {

			for (UserPrevExpCourseDetails userPrevExpCourseDetails : userPrevExpCourseDetailsList) {
				preparedStatement.setString(1, userPrevExpCourseDetails.getUserId());
				preparedStatement.setString(2, userPrevExpCourseDetails.getCourseId());
				preparedStatement.setString(3, userPrevExpCourseDetails.getFromDate());
				preparedStatement.setString(4, userPrevExpCourseDetails.getToDate());
				preparedStatement.addBatch();
			}

			preparedStatement.executeBatch();

		} catch (Exception e) {
			throw e;
		}
	}

	public void saveUserNewCourseDetails(List<CourseDetails> courseDetailsList, String userId, Connection connection)
			throws Exception {
		try (PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.USER_COURSE_INSERT_QRY)) {

			for (CourseDetails courseDetails : courseDetailsList) {
				preparedStatement.setString(1, userId);
				preparedStatement.setString(2, courseDetails.getCourseName());
				preparedStatement.addBatch();
			}

			preparedStatement.executeBatch();

		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public boolean saveUserNewCourseDetails(List<CourseDetails> courseDetailsList, String userId, String cvFileName)
			throws Exception {
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(AppConstants.USER_COURSE_INSERT_QRY)) {

			if (cvFileName != null && cvFileName.trim().length() > 0) {
				if (updateTACVFileName(connection, cvFileName, userId)) {

					for (CourseDetails courseDetails : courseDetailsList) {
						preparedStatement.setString(1, userId);
						preparedStatement.setString(2, courseDetails.getCourseId());
						preparedStatement.addBatch();
					}

					preparedStatement.executeBatch();

				}
			} else {

				for (CourseDetails courseDetails : courseDetailsList) {
					preparedStatement.setString(1, userId);
					preparedStatement.setString(2, courseDetails.getCourseId());
					preparedStatement.addBatch();
				}

				preparedStatement.executeBatch();

			}

		} catch (Exception e) {
			throw e;
		}
		return false;
	}

	@Override
	public List<UserApplicationDetails> getApplicantCourseDetails(String userId, String courseId, String status)
			throws Exception {

		List<UserApplicationDetails> userAppDetailsList = new ArrayList<>();

		String sqlQuery = AppConstants.GET_APPLICANT_COURSES_SEL_QRY;

		if (!courseId.equals("ALL")) {
			sqlQuery += " AND t2.COURSE_ID=?";
		}

		if (!userId.equals("ALL")) {
			sqlQuery += " AND t1.USER_ID=?";
		}

		if (!status.equals("ALL")) {
			sqlQuery += " AND APPLICATION_STATUS=?";
		}

		sqlQuery += " ORDER BY t2.LAST_UPDATE_TS DESC";
		
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery)) {
			
			int index =0;
			
			if (!courseId.equals("ALL")) {
				pstmt.setString(++index, courseId);
			}

			if (!userId.equals("ALL")) {
				pstmt.setString(++index, userId);
			}

			if (!status.equals("ALL")) {
				pstmt.setString(++index, status);
			}

			ResultSet resultSetForJob = pstmt.executeQuery();

			while (resultSetForJob.next()) {
				UserApplicationDetails userAppDetails = new UserApplicationDetails();
				userAppDetails.setUserId(resultSetForJob.getString("USER_ID"));
				userAppDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));
				userAppDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				userAppDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				userAppDetails.setCvFileName(resultSetForJob.getString("CV_FILE_NAME"));
				userAppDetails.setIsRecommended(resultSetForJob.getString("IS_RECOMMENDED"));
				userAppDetails.setCourseUniqueId(resultSetForJob.getString("APPLICANT_COURSE_UNIQUE_ID"));
				userAppDetails.setApplicationStatus(resultSetForJob.getString("APPLICATION_STATUS"));
				userAppDetailsList.add(userAppDetails);

			}

		} catch (Exception e) {
			throw e;
		}
		return userAppDetailsList;
	}

	@Override
	public UserApplicationDetails getApplicantDetailsOnCourseId(String userId, String courseId, String status,
			String courseUniqueId) throws Exception {

		UserApplicationDetails userAppDetails = null;
		List<CourseDetails> courseDetailsList = new ArrayList<>();

		String sqlQuery = "";
		if (courseId.equals("ALL"))
			sqlQuery = AppConstants.GET_ALL_JOB_APPLICANTS_WITH_STATUS_SEL_QRY;
		else
			sqlQuery = AppConstants.GET_JOB_APPLICANTS_WITH_COURSE_ID_STATUS_SEL_QRY;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery);) {

			List<UserPrevExpCourseDetails> userPrevExpCoursesList = getUserPrevCourseDetails(userId);

			if (courseId.equals("ALL")) {
				pstmt.setString(1, status);
				pstmt.setString(2, userId);
				pstmt.setString(3, courseUniqueId);
			} else {
				pstmt.setString(1, courseId);
				pstmt.setString(2, status);
				pstmt.setString(3, userId);
				pstmt.setString(4, courseUniqueId);
			}

			ResultSet resultSetForJob = pstmt.executeQuery();

			while (resultSetForJob.next()) {

				userAppDetails = new UserApplicationDetails();
				userAppDetails.setUserId(resultSetForJob.getString("USER_ID"));
				userAppDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));
				userAppDetails.setStudentId(resultSetForJob.getString("STUDENT_ID"));
				userAppDetails.setQualification(
						AppConstants.getQualification().get(resultSetForJob.getString("QUALIFICATION")));
				userAppDetails.setPrevExperience(resultSetForJob.getString("PREV_EXP_PRESENT"));
				userAppDetails.setCvFileName(resultSetForJob.getString("CV_FILE_NAME"));
				//
				CourseDetails courseDetails = new CourseDetails();
				courseDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));
				//
				courseDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				courseDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				courseDetails.setApplicationStatus(resultSetForJob.getString("APPLICATION_STATUS"));
				courseDetails.setOfferStatus(resultSetForJob.getString("OFFER_STATUS"));
				courseDetails.setIsRecommended(resultSetForJob.getString("IS_RECOMMENDED"));
				courseDetails.setIsNotified(resultSetForJob.getString("IS_NOTIFIED"));
				//
				courseDetails.setCourseStartDate(resultSetForJob.getString("COURSE_START_DATE"));
				courseDetails.setCourseEndDate(resultSetForJob.getString("COURSE_END_DATE"));
				courseDetails.setFeedbackTs(resultSetForJob.getString("FEEDBACK_GIVEN_DATE"));
				courseDetails.setOfferAcceptedDate(resultSetForJob.getString("OFFER_ACCEPTED_ON"));
				courseDetails.setOfferRejectedDate(resultSetForJob.getString("OFFER_REJECTED_ON"));
				courseDetails.setCourseRecommendDate(resultSetForJob.getString("RECOMMENDED_ON"));
				courseDetails.setCourseNotifyDate(resultSetForJob.getString("NOTIFIED_ON"));
				courseDetails.setCourseApprvDate(resultSetForJob.getString("COURSE_APPROVED_TS"));
				courseDetails.setCourseRejDate(resultSetForJob.getString("COURSE_REJECTED_TS"));
//				courseDetails.setLastUpdateTs(resultSetForJob.getString("LAST_UPDATE_TS"));
				//
				ProfessorDetails professorDetails = new ProfessorDetails();
				professorDetails.setEmailAddress(resultSetForJob.getString("prfEmail"));
				professorDetails.setMobileNumber(resultSetForJob.getString("prfMobileNo"));
				courseDetails.setProfessorDetails(professorDetails);
				//
				courseDetails
						.setRating(AppConstants.getRatingDesc().get(resultSetForJob.getString("PERFORMANCE_RATING")));
				courseDetails.setFeedback(resultSetForJob.getString("INSTRUCTOR_FEEDBACK"));
				//
				courseDetails.setInstructorEmail(resultSetForJob.getString("instrctorEmail"));
				courseDetails.setInstructorMobileNo(resultSetForJob.getString("instrctorMobileNo"));
				//
				courseDetailsList.add(courseDetails);

			}
			if (userAppDetails != null) {
				userAppDetails.setCourseDetailsList(courseDetailsList);
				userAppDetails.setUserPrevExpCoursesList(userPrevExpCoursesList);
			}

		} catch (Exception e) {
			throw e;
		}
		return userAppDetails;
	}

	@Override
	public List<UserPrevExpCourseDetails> getUserPrevCourseDetails(String userId) throws Exception {

		List<UserPrevExpCourseDetails> userPrevExpCoursesList = new ArrayList<>();

		try (Connection connection = DBUtil.getConnection();) {

			PreparedStatement pstmt = connection.prepareStatement(AppConstants.GET_USER_PREV_COURSES_SELECT_QRY);
			pstmt.setString(1, userId);

			ResultSet resultSetForJob = pstmt.executeQuery();

			while (resultSetForJob.next()) {
				UserPrevExpCourseDetails userPrevExpCourseDetails = new UserPrevExpCourseDetails(); //
				userPrevExpCourseDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				userPrevExpCourseDetails.setFromDate(resultSetForJob.getString("FROM_DATE"));
				userPrevExpCourseDetails.setToDate(resultSetForJob.getString("TO_DATE"));

				userPrevExpCoursesList.add(userPrevExpCourseDetails);

			}

		} catch (Exception e) {
			throw e;
		}
		return userPrevExpCoursesList;
	}

	@Override
	public UserApplicationDetails getUserCourseApplnDetails(String userId) throws Exception {

		UserApplicationDetails userApplicationDetails = null;
		CourseDetails courseDetails = null;
		try (Connection connection = DBUtil.getConnection();) {

			PreparedStatement pstmt = connection.prepareStatement(AppConstants.GET_USER_APPLN_COURSE_DTLS_SEL_QRY);
			pstmt.setString(1, userId);

			ResultSet resultSetForJob = pstmt.executeQuery();

			int count = 1;
			List<CourseDetails> CourseDetailsList = new ArrayList<CourseDetails>();
			while (resultSetForJob.next()) {
				if (count == 1) {
					userApplicationDetails = new UserApplicationDetails();
					userApplicationDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));
					userApplicationDetails.setStudentId(resultSetForJob.getString("STUDENT_ID"));
					userApplicationDetails.setQualification(resultSetForJob.getString("QUALIFICATION"));
					userApplicationDetails.setPrevExperience(resultSetForJob.getString("PREV_EXP_PRESENT"));
					userApplicationDetails.setCvFileName(resultSetForJob.getString("CV_FILE_NAME"));
				}
				//
				courseDetails = new CourseDetails();
				courseDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				courseDetails.setCourseEndDate(resultSetForJob.getString("COURSE_END_DATE"));
				courseDetails.setOfferRejectedDate(resultSetForJob.getString("OFFER_REJECTED_ON"));
				courseDetails.setCourseRejDate(resultSetForJob.getString("COURSE_REJECTED_TS"));
				CourseDetailsList.add(courseDetails);
			}
			if (userApplicationDetails != null) {
				userApplicationDetails.setCourseDetailsList(CourseDetailsList);
			}

		} catch (Exception e) {
			throw e;
		}
		return userApplicationDetails;
	}

	@Override
	public List<UserDetails> getAllTAApplicants() throws Exception {

		List<UserDetails> taApplicantsList = new ArrayList<>();

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(AppConstants.GET_TA_APPLICANT_USER_DTLS_SEL_QRY)) {

			ResultSet resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				UserDetails userDetails = new UserDetails();
				userDetails.setUserId(resultSet.getString("USER_ID"));
				userDetails.setUserName(resultSet.getString("LAST_NAME") + " " + resultSet.getString("FIRST_NAME"));
				taApplicantsList.add(userDetails);
			}

		} catch (Exception e) {
			throw e;
		}
		return taApplicantsList;
	}

	@Override
	public boolean approveOrRejectTaApplicant(String userId, String actionType, String selRowCourseId,
			String courseUniqueId) throws Exception {

		boolean isSuccess = false;
		try (Connection connection = DBUtil.getConnection();) {

			String sqlQuery = AppConstants.UPDATE_TA_APPLICANT_COURSE_REJECT_STATUS;

			if (actionType.equals("RECOMMEND")) {
				sqlQuery = AppConstants.UPDATE_TA_APPLICANT_COURSE_STAUS_RECOMMEND_FLAG;

			} else if (actionType.equals("NOTIFIED")) {
				sqlQuery = AppConstants.UPDATE_TA_APPLICANT_COURSE_STAUS_NOTIFY_FLAG;
			} else if (actionType.equals("APPROVED")) {
				sqlQuery = AppConstants.UPDATE_TA_APPLICANT_COURSE_APPROVE_STATUS;
			}

			System.out.println("sqlQuery:: " + sqlQuery);
			try (PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
					PreparedStatement pstmt = connection
							.prepareStatement(AppConstants.UPDATE_APPLICANT_DTLS_LAST_UPDATE_TS)) {

				if (actionType.equals("APPROVED") || actionType.equals("REJECTED")) {
					preparedStatement.setString(1, actionType);
					preparedStatement.setString(2, userId);

				} else if (actionType.equals("RECOMMEND")) {
					preparedStatement.setString(1, "Y");
					preparedStatement.setString(2, userId);

				} else if (actionType.equals("NOTIFIED")) {
					preparedStatement.setString(1, "Y");
					preparedStatement.setString(2, userId);
				}
				preparedStatement.setString(3, selRowCourseId);
				preparedStatement.setString(4, courseUniqueId);

				int updateCount = preparedStatement.executeUpdate();

				if (updateCount > 0) {
					pstmt.setString(1, userId);
					if (pstmt.executeUpdate() > 0) {
						isSuccess = true;
					}

				}
			} catch (Exception e) {
				throw e;
			}

		} catch (Exception e) {
			throw e;
		}
		return isSuccess;
	}

	@Override
	public boolean updateTAOfferStatus(String offerStatus, String courseId, String userId) throws Exception {
		boolean isSuccess = false;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.UPDATE_TA_OFFER_STATUS);
				PreparedStatement pstmt = connection
						.prepareStatement(AppConstants.UPDATE_APPLICANT_DTLS_LAST_UPDATE_TS);) {

			preparedStatement.setString(1, offerStatus);

			if (offerStatus.equals("ACCEPTED")) {
				preparedStatement.setString(2, "APPOINTED");
				preparedStatement.setTimestamp(3, new Timestamp(new Date().getTime()));
				preparedStatement.setString(4, null);
				preparedStatement.setTimestamp(5, new Timestamp(new Date().getTime()));
			} else {
				preparedStatement.setString(2, "REJECTED");
				preparedStatement.setString(3, null);
				preparedStatement.setTimestamp(4, new Timestamp(new Date().getTime()));
				preparedStatement.setString(5, null);
			}
			preparedStatement.setTimestamp(6, new Timestamp(new Date().getTime()));
			//
			preparedStatement.setString(7, courseId);
			preparedStatement.setString(8, userId);

			int updateCount = preparedStatement.executeUpdate();
			if (updateCount > 0) {
				pstmt.setString(1, userId);
				if (pstmt.executeUpdate() > 0) {
					isSuccess = true;
				}
			}

		} catch (Exception e) {
			throw e;
		}
		return isSuccess;
	}

	public boolean updateTACVFileName(Connection connection, String cvFileName, String userId) throws Exception {
		boolean isSuccess = false;
		try (PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.UPDATE_TA_CV_FILENAME)) {

			preparedStatement.setString(1, cvFileName);
			preparedStatement.setString(2, userId);

			int updateCount = preparedStatement.executeUpdate();
			if (updateCount > 0) {
				isSuccess = true;
			}

		} catch (Exception e) {
			throw e;
		}
		return isSuccess;
	}

	@Override
	public List<UserApplicationDetails> getAppointedTAs() throws Exception {

		List<UserApplicationDetails> userAppDetailsList = new ArrayList<>();

		String sqlQuery = AppConstants.GET_APPOINTED_APPLICANTS_SEL_QRY;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery)) {

			ResultSet resultSetForJob = pstmt.executeQuery();

			while (resultSetForJob.next()) {
				UserApplicationDetails userAppDetails = new UserApplicationDetails();
				userAppDetails.setUserId(resultSetForJob.getString("USER_ID"));
				userAppDetails.setFirstName(resultSetForJob.getString("FIRST_NAME"));
				userAppDetails.setLastName(resultSetForJob.getString("LAST_NAME"));
				userAppDetails.setStudentId(resultSetForJob.getString("STUDENT_ID"));
				userAppDetails.setQualification(
						AppConstants.getQualification().get(resultSetForJob.getString("QUALIFICATION")));
				userAppDetails.setPrevExperience(resultSetForJob.getString("PREV_EXP_PRESENT"));
				userAppDetails.setCvFileName(resultSetForJob.getString("CV_FILE_NAME"));
				//
				userAppDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				userAppDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				userAppDetails.setCourseApplicationTime(resultSetForJob.getString("courseApplicationTime"));
				userAppDetails.setApplicationStatus(resultSetForJob.getString("APPLICATION_STATUS"));
				userAppDetails.setOfferStatus(resultSetForJob.getString("OFFER_STATUS"));
				userAppDetails.setIsRecommended(resultSetForJob.getString("IS_RECOMMENDED"));
				userAppDetails.setIsNotified(resultSetForJob.getString("IS_NOTIFIED"));
				userAppDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));

				userAppDetailsList.add(userAppDetails);

			}

		} catch (Exception e) {
			throw e;
		}
		return userAppDetailsList;
	}

	@Override
	public boolean updateTAPerformanceAsPerCourse(String userId, String courseId, String rating, String feedback,
			String instructorId) throws Exception {

		boolean isSuccess = false;
		String sqlQuery = AppConstants.UPDATE_TA_PERFORMANCE;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery);
				PreparedStatement pstmtUpdate = connection
						.prepareStatement(AppConstants.UPDATE_APPLICANT_DTLS_LAST_UPDATE_TS)) {

			pstmt.setString(1, rating);
			pstmt.setString(2, feedback);
			pstmt.setString(3, instructorId);
			pstmt.setString(4, userId);
			pstmt.setString(5, courseId);

			int count = pstmt.executeUpdate();
			if (count > 0) {
				pstmtUpdate.setString(1, userId);
				if (pstmtUpdate.executeUpdate() > 0) {
					isSuccess = true;
				}
			}

		} catch (Exception e) {
			throw e;
		}
		return isSuccess;
	}

	@Override
	public List<ProfessorDetails> getProfessordetails() throws Exception {

		List<ProfessorDetails> facultiesList = new ArrayList<>();

		String sqlQuery = AppConstants.GET_PROFESSOR_DTLS_SEL_QRY;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery)) {

			ResultSet resultSetForJob = pstmt.executeQuery();

			while (resultSetForJob.next()) {
				ProfessorDetails facultyDetails = new ProfessorDetails();
				facultyDetails.setProfessorId(resultSetForJob.getString("PROFESSOR_ID"));
				facultyDetails.setName(resultSetForJob.getString("NAME"));
				facultyDetails.setMobileNumber(resultSetForJob.getString("MOBILE_NO"));
				facultyDetails.setEmailAddress(resultSetForJob.getString("EMAIL_ADDRESS"));

				facultiesList.add(facultyDetails);

			}

		} catch (Exception e) {
			throw e;
		}
		return facultiesList;
	}

	/* Application tracking start */
	@Override
	public List<CourseDetails> getApplicantCourseWiseStatusDtlsForTracking(String userId) throws Exception {

		List<CourseDetails> userCoursesStatusList = new ArrayList<>();

		try (Connection connection = DBUtil.getConnection();) {

			PreparedStatement preparedStatementForJob = connection
					.prepareStatement(AppConstants.APPLICANT_COURSEWISE_STATUS_TRACKING_DTLS_SEL_QRY);
			preparedStatementForJob.setString(1, userId);
			ResultSet resultSetForJob = preparedStatementForJob.executeQuery();

			while (resultSetForJob.next()) {
				CourseDetails courseDetails = new CourseDetails();
				courseDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				courseDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				courseDetails.setApplicationStatus(resultSetForJob.getString("APPLICATION_STATUS"));
				courseDetails.setOfferStatus(resultSetForJob.getString("OFFER_STATUS"));
				courseDetails.setIsRecommended(resultSetForJob.getString("IS_RECOMMENDED"));
				courseDetails.setIsNotified(resultSetForJob.getString("IS_NOTIFIED"));
				courseDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));
				courseDetails.setCourseEndDate(resultSetForJob.getString("COURSE_END_DATE"));
				courseDetails.setCourseUniqueId(resultSetForJob.getString("APPLICANT_COURSE_UNIQUE_ID"));
				//
				ProfessorDetails professorDetails = new ProfessorDetails();
				professorDetails.setEmailAddress(resultSetForJob.getString("EMAIL_ADDRESS"));
				courseDetails.setProfessorDetails(professorDetails);
				//
				userCoursesStatusList.add(courseDetails);
			}

		} catch (Exception e) {
			throw e;
		}
		return userCoursesStatusList;
	}

	@Override
	public CourseDetails getApplicantCourseStatusDtlsForTracking(String userId, String courseId, String courseUniqueId)
			throws Exception {

		CourseDetails courseDetails = null;
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatementForJob = connection
						.prepareStatement(AppConstants.APPLICANT_COURSE_STATUS_TRACKING_DTLS_SEL_QRY);) {

			preparedStatementForJob.setString(1, userId);
			preparedStatementForJob.setString(2, courseId);
			preparedStatementForJob.setString(3, courseUniqueId);
			//
			ResultSet resultSetForJob = preparedStatementForJob.executeQuery();

			if (resultSetForJob.next()) {
				courseDetails = new CourseDetails();
				courseDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));
				//
				courseDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				courseDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				courseDetails.setApplicationStatus(resultSetForJob.getString("APPLICATION_STATUS"));
				courseDetails.setOfferStatus(resultSetForJob.getString("OFFER_STATUS"));
				courseDetails.setIsRecommended(resultSetForJob.getString("IS_RECOMMENDED"));
				courseDetails.setIsNotified(resultSetForJob.getString("IS_NOTIFIED"));
				//
				courseDetails.setCourseStartDate(resultSetForJob.getString("COURSE_START_DATE"));
				courseDetails.setCourseEndDate(resultSetForJob.getString("COURSE_END_DATE"));
				//
				courseDetails
						.setRating(AppConstants.getRatingDesc().get(resultSetForJob.getString("PERFORMANCE_RATING")));
				courseDetails.setFeedbackTs(resultSetForJob.getString("FEEDBACK_GIVEN_DATE"));
				courseDetails.setFeedback(resultSetForJob.getString("INSTRUCTOR_FEEDBACK"));
				//
				courseDetails.setOfferAcceptedDate(resultSetForJob.getString("OFFER_ACCEPTED_ON"));
				courseDetails.setOfferRejectedDate(resultSetForJob.getString("OFFER_REJECTED_ON"));
				//
				courseDetails.setCourseRecommendDate(resultSetForJob.getString("RECOMMENDED_ON"));
				courseDetails.setCourseNotifyDate(resultSetForJob.getString("NOTIFIED_ON"));
				courseDetails.setCourseApprvDate(resultSetForJob.getString("COURSE_APPROVED_TS"));
				courseDetails.setCourseRejDate(resultSetForJob.getString("COURSE_REJECTED_TS"));
				courseDetails.setLastUpdateTs(resultSetForJob.getString("LAST_UPDATE_TS"));
				//
				ProfessorDetails professorDetails = new ProfessorDetails();
				professorDetails.setEmailAddress(resultSetForJob.getString("EMAIL_ADDRESS"));
				courseDetails.setProfessorDetails(professorDetails);
			}

		} catch (Exception e) {
			throw e;
		}
		return courseDetails;
	}

	@Override
	public List<CourseDetails> getApplicantPrevCourseHistryDtlsForTracking(String userId, String courseId)
			throws Exception {

		List<CourseDetails> oldCourseHistryList = new ArrayList<CourseDetails>();
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatementForJob = connection
						.prepareStatement(AppConstants.APPLICANT_OLD_COURSE_STATUS_TRACKING_DTLS_SEL_QRY);) {

			preparedStatementForJob.setString(1, userId);
			preparedStatementForJob.setString(2, courseId);
			//
			ResultSet resultSetForJob = preparedStatementForJob.executeQuery();

			while (resultSetForJob.next()) {
				CourseDetails courseDetails = new CourseDetails();
				courseDetails.setApplicationId(resultSetForJob.getString("APPLICATION_ID"));
				//
				courseDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				courseDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				courseDetails.setApplicationStatus(resultSetForJob.getString("APPLICATION_STATUS"));
				courseDetails.setOfferStatus(resultSetForJob.getString("OFFER_STATUS"));
				courseDetails.setIsRecommended(resultSetForJob.getString("IS_RECOMMENDED"));
				courseDetails.setIsNotified(resultSetForJob.getString("IS_NOTIFIED"));
				courseDetails.setFeedback(resultSetForJob.getString("INSTRUCTOR_FEEDBACK"));
				//
				courseDetails.setCourseStartDate(resultSetForJob.getString("COURSE_START_DATE"));
				courseDetails.setCourseEndDate(resultSetForJob.getString("COURSE_END_DATE"));
				courseDetails.setFeedbackTs(resultSetForJob.getString("FEEDBACK_GIVEN_DATE"));
				courseDetails.setOfferAcceptedDate(resultSetForJob.getString("OFFER_ACCEPTED_ON"));
				courseDetails.setOfferRejectedDate(resultSetForJob.getString("OFFER_REJECTED_ON"));
				courseDetails.setCourseRecommendDate(resultSetForJob.getString("RECOMMENDED_ON"));
				courseDetails.setCourseNotifyDate(resultSetForJob.getString("NOTIFIED_ON"));
				courseDetails.setCourseApprvDate(resultSetForJob.getString("COURSE_APPROVED_TS"));
				courseDetails.setCourseRejDate(resultSetForJob.getString("COURSE_REJECTED_TS"));
				courseDetails.setLastUpdateTs(resultSetForJob.getString("LAST_UPDATE_TS"));
				//
				ProfessorDetails professorDetails = new ProfessorDetails();
				professorDetails.setEmailAddress(resultSetForJob.getString("EMAIL_ADDRESS"));
				courseDetails.setProfessorDetails(professorDetails);
				//
				oldCourseHistryList.add(courseDetails);
			}

		} catch (Exception e) {
			throw e;
		}
		return oldCourseHistryList;
	}
	/* application tracking end */

	@Override
	public boolean isApplicantEligibleToApplyForCourse(String userId, String courseId) throws Exception {

		boolean isEligible = false;
		String sqlQuery = AppConstants.CHECK_APPLICANT_ELIGIBLE_FOR_COURSE;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery)) {

			pstmt.setString(1, userId);
			pstmt.setString(2, courseId);

			ResultSet resultSetForJob = pstmt.executeQuery();

			if (resultSetForJob.next()) {
				isEligible = true;

			}

		} catch (Exception e) {
			throw e;
		}
		return isEligible;
	}

	@Override
	public boolean isPositionOpenForCourse(String courseId) throws Exception {

		boolean isAvailable = false;
		String sqlQuery = AppConstants.CHECK_OPEN_POSITIONS_FOR_COURSE;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery)) {

			pstmt.setString(1, courseId);
			pstmt.setString(2, courseId);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				String openPositions = rs.getString("OPEN_POSITIONS");
				if (Double.parseDouble(openPositions) > 0) {
					isAvailable = true;
				}

			}

		} catch (Exception e) {
			throw e;
		}
		return isAvailable;
	}

	@Override
	public List<UserDetails> getUserDetailsBasedOnUserType(String userType) throws Exception {

		List<UserDetails> userDtlsList = new ArrayList<UserDetails>();
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement(AppConstants.GET_USER_DETAILS_BASED_ON_USERTYPE_SEL_QRY)) {

			preparedStatement.setString(1, userType);

			ResultSet rs = preparedStatement.executeQuery();

			UserDetails userDetails = null;
			while (rs.next()) {
				userDetails = new UserDetails();
				userDetails.setFirstName(rs.getString("FIRST_NAME"));
				userDetails.setLastName(rs.getString("LAST_NAME"));
				userDetails.setMobileNumber(rs.getString("MOBILE_NUMBER"));
				userDetails.setEmailAddress(rs.getString("EMAIL_ADDRESS"));
				userDetails.setUserId(rs.getString("USER_ID"));
				userDetails.setCreateTime(rs.getString("CREATE_TIME"));
				userDetails.setLastUpdateTs(rs.getString("LAST_UPDATE_TIME"));
				userDetails.setUserName(rs.getString("USER_NAME"));

				userDtlsList.add(userDetails);
			}

		} catch (Exception e) {
			throw e;
		}
		return userDtlsList;

	}

}
