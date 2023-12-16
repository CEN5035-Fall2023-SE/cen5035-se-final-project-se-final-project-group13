package com.teachingassistant.dao;

import com.teachingassistant.bean.UserDetails;

public interface ILoginDao {

	public UserDetails getLoginDetails(String userName, String password) throws Exception;

}
