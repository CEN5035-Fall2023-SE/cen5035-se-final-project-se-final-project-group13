package com.teachingassistant.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.util.AppConstants;
import com.teachingassistant.util.DBUtil;

public class LoginDaoImpl implements ILoginDao {

	private static final Logger logger = Logger.getLogger(LoginDaoImpl.class.getName());

	@Override
	public UserDetails getLoginDetails(String userName, String password) throws Exception {

		logger.info("[getLoginDetails] method starts..");

		logger.log(Level.INFO, "userName:: " + userName);

		UserDetails userDetails = null;

		try (Connection connection = DBUtil.getConnection();) {

			logger.log(Level.INFO, "USER_DETAILS_SELECT_QRY:: " + AppConstants.USER_DETAILS_SELECT_QRY);
//			logger.debug("USER_DETAILS_SELECT_QRY:: {}",AppConstants.USER_DETAILS_SELECT_QRY);

			PreparedStatement preparedStatement = connection.prepareStatement(AppConstants.USER_DETAILS_SELECT_QRY);
			preparedStatement.setString(1, userName.trim());
			preparedStatement.setString(2, userName.trim());
			preparedStatement.setString(3, userName.trim());
			preparedStatement.setString(4, password.trim());

			ResultSet resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				logger.info("user is exist!!");
				userDetails = new UserDetails();
				userDetails.setUserId(resultSet.getString("USER_ID"));
				userDetails.setFirstName(resultSet.getString("FIRST_NAME"));
				userDetails.setLastName(resultSet.getString("LAST_NAME"));
				userDetails.setMobileNumber(resultSet.getString("MOBILE_NUMBER"));
				userDetails.setEmailAddress(resultSet.getString("EMAIL_ADDRESS"));
				userDetails.setUserType(resultSet.getString("USER_TYPE"));
				userDetails.setUserName(resultSet.getString("USER_NAME"));
				userDetails.setPassword(resultSet.getString("PASSWORD"));
				userDetails.setIsJobApplnDone("N");
			}

			if (userDetails != null) {
				try (PreparedStatement pstmt = connection.prepareStatement(AppConstants.CHECK_EXISTING_APPLICANT)) {
					pstmt.setString(1, userDetails.getUserId());
					ResultSet rs = pstmt.executeQuery();
					if (rs.next()) {
						logger.info("user is exist!!");
						userDetails.setIsJobApplnDone("Y");
					}
				} catch (Exception e) {
					throw e;
				}

			}

		} catch (Exception e) {
			throw e;
		}
		logger.info("[getLoginDetails] method ends..");
		return userDetails;
	}

}
