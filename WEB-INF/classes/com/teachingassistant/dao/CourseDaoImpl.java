package com.teachingassistant.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.ProfessorDetails;
import com.teachingassistant.util.AppConstants;
import com.teachingassistant.util.DBUtil;

public class CourseDaoImpl implements ICourseDao {

	@Override
	public void addCourse(String courseId, String courseName, String professorId, String openPositions)
			throws Exception {
		try (Connection connection = DBUtil.getConnection();) {

			PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.COURSE_INSERT_QRY);

			preparedStatement.setString(1, courseId);
			preparedStatement.setString(2, courseName);
			preparedStatement.setString(3, professorId);
			preparedStatement.setString(4, openPositions);
			preparedStatement.execute();

		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<CourseDetails> updateOrDeleteCourse(String actionType, String courseId, String openPositions)
			throws Exception {
		List<CourseDetails> courseList = null;
		String sqlQry = "";
		if (actionType.equals("UPDATE")) {
			sqlQry = AppConstants.COURSE_UPDATE_QRY;
		} else {
			sqlQry = AppConstants.COURSE_DELETE_QRY;
		}
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sqlQry);) {

			if (actionType.equals("UPDATE")) {
				preparedStatement.setString(1, openPositions);
				preparedStatement.setString(2, courseId);
			} else {
				preparedStatement.setString(1, courseId);
			}
			preparedStatement.executeUpdate();

			courseList = loadCourseDetails();

		} catch (Exception e) {
			throw e;
		}
		return courseList;

	}

	@Override
	public List<CourseDetails> loadCourseDetails() throws Exception {
		List<CourseDetails> coursesList = new ArrayList<>();

		try (Connection connection = DBUtil.getConnection();) {
			coursesList = loadCourseDetails(connection);
		} catch (Exception e) {
			throw e;
		}
		return coursesList;
	}

	public List<CourseDetails> loadCourseDetails(Connection connection) throws Exception {
		List<CourseDetails> coursesList = new ArrayList<>();

		try (PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.COURSE_DTLS_SELECT_QRY)) {

			ResultSet resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				CourseDetails courseDetails = new CourseDetails();
				courseDetails.setCourseId(resultSet.getString("COURSE_ID"));
				courseDetails.setCourseName(resultSet.getString("COURSE_NAME"));
				courseDetails.setProfessorId(resultSet.getString("PROFESSOR_ID"));
				courseDetails.setOpenPositions(resultSet.getString("OPEN_POSITIONS"));
				coursesList.add(courseDetails);
			}

		} catch (Exception e) {
			throw e;
		}
		return coursesList;
	}

	@Override
	public CourseDetails getProfessorDetailsByCourseId(String courseId) throws Exception {

		CourseDetails courseDetails = null;

		String sqlQuery = AppConstants.GET_PROFESSOR_DTLS_FOR_COURSEID_SEL_QRY;

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sqlQuery)) {

			pstmt.setString(1, courseId);

			ResultSet resultSetForJob = pstmt.executeQuery();

			if (resultSetForJob.next()) {
				courseDetails = new CourseDetails();

				courseDetails.setCourseId(resultSetForJob.getString("COURSE_ID"));
				courseDetails.setCourseName(resultSetForJob.getString("COURSE_NAME"));
				courseDetails.setOpenPositions(resultSetForJob.getString("OPEN_POSITIONS"));
				//
				ProfessorDetails professorDetails = new ProfessorDetails();
				professorDetails.setProfessorId(resultSetForJob.getString("PROFESSOR_ID"));
				professorDetails.setName(resultSetForJob.getString("NAME"));
				professorDetails.setMobileNumber(resultSetForJob.getString("MOBILE_NO"));
				professorDetails.setEmailAddress(resultSetForJob.getString("EMAIL_ADDRESS"));

				courseDetails.setProfessorDetails(professorDetails);

			}

		} catch (Exception e) {
			throw e;
		}
		return courseDetails;
	}

}
