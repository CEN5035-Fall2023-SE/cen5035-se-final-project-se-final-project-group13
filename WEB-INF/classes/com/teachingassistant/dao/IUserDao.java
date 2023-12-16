package com.teachingassistant.dao;

import java.util.List;

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.ProfessorDetails;
import com.teachingassistant.bean.UserApplicationDetails;
import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.bean.UserPrevExpCourseDetails;

public interface IUserDao {
	public String saveUserDetails(UserDetails userDetails) throws Exception;

	public String updateUserDetails(UserDetails userDetails) throws Exception;

	/* user job application saving start */
	public boolean isApplicantEligibleToApplyForCourse(String userId, String courseId) throws Exception;

	public boolean saveUserJobApplicationDetails(UserApplicationDetails userApplicationDetaills,
			List<UserPrevExpCourseDetails> userPrevExpCourseDetailsList, List<CourseDetails> courseDetailsList)
			throws Exception;

	public boolean updateUserJobApplicationDetails(UserApplicationDetails userApplicationDetaills,
			List<UserPrevExpCourseDetails> userPrevExpCourseDetailsList, List<CourseDetails> courseDetailsList)
			throws Exception;
	/* user job application saving end */

//	public UserApplicationDetails getUserJobAppDetails(String userId) throws Exception;

	/* application tracking start */
	public List<CourseDetails> getApplicantCourseWiseStatusDtlsForTracking(String userId) throws Exception;

	public CourseDetails getApplicantCourseStatusDtlsForTracking(String userId, String courseId,String courseUniqueId) throws Exception;

	public List<CourseDetails> getApplicantPrevCourseHistryDtlsForTracking(String userId, String courseId)
			throws Exception;
	/* application tracking end */

	public UserApplicationDetails getApplicantDetailsOnCourseId(String userId, String courseId, String status,String courseUniqueId)
			throws Exception;

	public List<UserPrevExpCourseDetails> getUserPrevCourseDetails(String userId) throws Exception;

	public UserApplicationDetails getUserCourseApplnDetails(String userId) throws Exception;

	public boolean saveUserNewCourseDetails(List<CourseDetails> courseDetailsList, String userId, String cvFileName)
			throws Exception;

	public List<UserDetails> getAllTAApplicants() throws Exception;

	public boolean approveOrRejectTaApplicant(String userId, String actionType, String selRowCourseId,String courseUniqueId)
			throws Exception;

	public boolean updateTAOfferStatus(String offerStatus, String courseId, String userId) throws Exception;

	public List<UserApplicationDetails> getAppointedTAs() throws Exception;

	public boolean updateTAPerformanceAsPerCourse(String userId, String courseId, String rating, String feedback,
			String instructorId) throws Exception;

	public List<ProfessorDetails> getProfessordetails() throws Exception;

	public List<UserApplicationDetails> getApplicantCourseDetails(String userId, String courseId, String status)
			throws Exception;

	public boolean isPositionOpenForCourse(String courseId) throws Exception;
	
	public List<UserDetails> getUserDetailsBasedOnUserType(String userType) throws Exception;
}
