package com.teachingassistant.bean;

import java.util.List;

public class UserApplicationDetails {

	private String userId;
	private String firstName;
	private String lastName;
	private String studentId;
	private String qualification;
	private String prevExperience;
	private String cvFileName;

	private String courseId;
	private String courseUniqueId;
	private String courseName;
	private String courseApplicationTime;
	private String applicationStatus;
	private String offerStatus;
	private String isRecommended;
	private String isNotified;
	private String rating;
	private String applicationId;
	private String feedback;

	private List<CourseDetails> courseDetailsList;

	private List<UserPrevExpCourseDetails> userPrevExpCoursesList;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public String getPrevExperience() {
		return prevExperience;
	}

	public void setPrevExperience(String prevExperience) {
		this.prevExperience = prevExperience;
	}

	public String getCvFileName() {
		return cvFileName;
	}

	public void setCvFileName(String cvFileName) {
		this.cvFileName = cvFileName;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCourseApplicationTime() {
		return courseApplicationTime;
	}

	public void setCourseApplicationTime(String courseApplicationTime) {
		this.courseApplicationTime = courseApplicationTime;
	}

	public String getApplicationStatus() {
		return applicationStatus;
	}

	public void setApplicationStatus(String applicationStatus) {
		this.applicationStatus = applicationStatus;
	}

	public String getOfferStatus() {
		return offerStatus;
	}

	public void setOfferStatus(String offerStatus) {
		this.offerStatus = offerStatus;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public List<UserPrevExpCourseDetails> getUserPrevExpCoursesList() {
		return userPrevExpCoursesList;
	}

	public void setUserPrevExpCoursesList(List<UserPrevExpCourseDetails> userPrevExpCoursesList) {
		this.userPrevExpCoursesList = userPrevExpCoursesList;
	}

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getIsRecommended() {
		return isRecommended;
	}

	public void setIsRecommended(String isRecommended) {
		this.isRecommended = isRecommended;
	}

	public String getIsNotified() {
		return isNotified;
	}

	public void setIsNotified(String isNotified) {
		this.isNotified = isNotified;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(String applicationId) {
		this.applicationId = applicationId;
	}

	public String getFeedback() {
		return feedback;
	}

	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}

	public List<CourseDetails> getCourseDetailsList() {
		return courseDetailsList;
	}

	public void setCourseDetailsList(List<CourseDetails> courseDetailsList) {
		this.courseDetailsList = courseDetailsList;
	}

	public String getCourseUniqueId() {
		return courseUniqueId;
	}

	public void setCourseUniqueId(String courseUniqueId) {
		this.courseUniqueId = courseUniqueId;
	}

}
