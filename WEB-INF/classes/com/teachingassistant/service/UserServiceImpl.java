package com.teachingassistant.service;

import java.util.ArrayList;
import java.util.List;

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.UserApplicationDetails;
import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.bean.UserPrevExpCourseDetails;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;

public class UserServiceImpl implements IUserService {

	@Override
	public String saveUserDetails(String firstName, String lastName, String mobileNumber, String emailAddress,
			String userName, String password, String userType) throws Exception {

		try {
			UserDetails userDetails = new UserDetails();

			userDetails.setFirstName(firstName);
			userDetails.setLastName(lastName);
			userDetails.setMobileNumber(mobileNumber);
			userDetails.setEmailAddress(emailAddress);
			userDetails.setUserName(userName);
			userDetails.setPassword(password);
			userDetails.setUserType(userType);

			IUserDao userDao = new UserDaompl();
			return userDao.saveUserDetails(userDetails);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public String updateUserDetails(String userId, String firstName, String lastName, String mobileNumber,
			String emailAddress, String password) throws Exception {

		try {
			UserDetails userDetails = new UserDetails();

			userDetails.setFirstName(firstName);
			userDetails.setLastName(lastName);
			userDetails.setMobileNumber(mobileNumber);
			userDetails.setEmailAddress(emailAddress);
			userDetails.setPassword(password);
			userDetails.setUserId(userId);

			IUserDao userDao = new UserDaompl();
			return userDao.updateUserDetails(userDetails);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public boolean saveUserJobApplicationDetails(String userId, String studentId, String qualification,
			String isPrevExpAdded, String fileName, String[] prevExpCourseNameArr, String[] prevExpCourseFromDateArr,
			String[] preExpCourseToDateArr,String newCoursesList) throws Exception {
		List<UserPrevExpCourseDetails> userPrevExpCourseDetailsList = null;
		try {
			UserApplicationDetails userApplicationDetails = new UserApplicationDetails();

			userApplicationDetails.setUserId(userId);
			userApplicationDetails.setStudentId(Character.toUpperCase(studentId.charAt(0)) + studentId.substring(1));
			userApplicationDetails.setQualification(qualification);
			userApplicationDetails.setCvFileName(fileName);
			userApplicationDetails.setPrevExperience(isPrevExpAdded);


			if (isPrevExpAdded.equals("Y")) {
				userPrevExpCourseDetailsList = new ArrayList<UserPrevExpCourseDetails>();

				for (int i = 0; i < prevExpCourseNameArr.length; i++) {

					if(prevExpCourseNameArr[i]!=null && !prevExpCourseNameArr[i].trim().equals("")) {
						UserPrevExpCourseDetails userPrevExpCourseDetails = new UserPrevExpCourseDetails();
						userPrevExpCourseDetails.setUserId(userId);
						userPrevExpCourseDetails.setCourseId(prevExpCourseNameArr[i]);
						userPrevExpCourseDetails.setFromDate(prevExpCourseFromDateArr[i]);
						userPrevExpCourseDetails.setToDate(preExpCourseToDateArr[i]);

						userPrevExpCourseDetailsList.add(userPrevExpCourseDetails);
					}
					
				}
			}
			
			List<CourseDetails> courseDetailsList = new ArrayList<CourseDetails>();
			for(String course:newCoursesList.split(",")) {
				CourseDetails courseDetails = new CourseDetails();
				courseDetails.setCourseName(course);
				courseDetailsList.add(courseDetails);
			}
			
			IUserDao userDao = new UserDaompl();
			return userDao.saveUserJobApplicationDetails(userApplicationDetails, userPrevExpCourseDetailsList,courseDetailsList);
		} catch (Exception e) {
			throw e;
		}

	}
	
	@Override
	public boolean updateUserJobApplicationDetails(String userId,  String qualification,
			String isPrevExpAdded, String fileName, String[] prevExpCourseNameArr, String[] prevExpCourseFromDateArr,
			String[] preExpCourseToDateArr,String newCoursesList) throws Exception {
		List<UserPrevExpCourseDetails> userPrevExpCourseDetailsList = null;
		try {
			UserApplicationDetails userApplicationDetails = new UserApplicationDetails();

			userApplicationDetails.setUserId(userId);
			userApplicationDetails.setQualification(qualification);
			userApplicationDetails.setCvFileName(fileName);

			if (prevExpCourseNameArr!=null && prevExpCourseNameArr.length>0) {
				userPrevExpCourseDetailsList = new ArrayList<UserPrevExpCourseDetails>();

				for (int i = 0; i < prevExpCourseNameArr.length; i++) {

					if(prevExpCourseFromDateArr[i]!=null && !prevExpCourseFromDateArr[i].trim().equals("")) {
						UserPrevExpCourseDetails userPrevExpCourseDetails = new UserPrevExpCourseDetails();
						userPrevExpCourseDetails.setUserId(userId);
						userPrevExpCourseDetails.setCourseId(prevExpCourseNameArr[i]);
						userPrevExpCourseDetails.setFromDate(prevExpCourseFromDateArr[i]);
						userPrevExpCourseDetails.setToDate(preExpCourseToDateArr[i]);

						userPrevExpCourseDetailsList.add(userPrevExpCourseDetails);
					}
					
				}
			}
			
			List<CourseDetails> courseDetailsList = new ArrayList<CourseDetails>();
			for(String course:newCoursesList.split(",")) {
				CourseDetails courseDetails = new CourseDetails();
				courseDetails.setCourseName(course);
				courseDetailsList.add(courseDetails);
			}
			
			IUserDao userDao = new UserDaompl();
			return userDao.updateUserJobApplicationDetails(userApplicationDetails, userPrevExpCourseDetailsList,courseDetailsList);
		} catch (Exception e) {
			throw e;
		}

	}


}
