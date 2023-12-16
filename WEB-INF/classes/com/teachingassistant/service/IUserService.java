package com.teachingassistant.service;

public interface IUserService {

	public String saveUserDetails(String firstName, String lastName, String mobileNumber, String emailAddress,
			String userName, String password, String userType) throws Exception;

	public String updateUserDetails(String userId, String firstName, String lastName, String mobileNumber,
			String emailAddress, String password) throws Exception;

	public boolean saveUserJobApplicationDetails(String userId, String studentId, String qualification, String isPrevExpAdded,
			String fileName, String[] prevExpCourseNameArr, String[] prevExpCourseFromDateArr,
			String[] preExpCourseToDateArr,String newCoursesList) throws Exception;

	public boolean updateUserJobApplicationDetails(String userId,  String qualification,
			String isPrevExpAdded, String fileName, String[] prevExpCourseNameArr, String[] prevExpCourseFromDateArr,
			String[] preExpCourseToDateArr,String newCoursesList) throws Exception; 
}
