package com.teachingassistant.bean;

import java.io.Serializable;

public class UserDetails implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	private String firstName;
	private String lastName;
	private String mobileNumber;
	private String emailAddress;
	private String userName;
	private String password;
	private String userType;
	private String isJobApplnDone;

	private String createTime;
	private String lastUpdateTs;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getIsJobApplnDone() {
		return isJobApplnDone;
	}

	public void setIsJobApplnDone(String isJobApplnDone) {
		this.isJobApplnDone = isJobApplnDone;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getLastUpdateTs() {
		return lastUpdateTs;
	}

	public void setLastUpdateTs(String lastUpdateTs) {
		this.lastUpdateTs = lastUpdateTs;
	}

}
