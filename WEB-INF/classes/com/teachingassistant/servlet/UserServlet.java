package com.teachingassistant.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;
import com.teachingassistant.service.IUserService;
import com.teachingassistant.service.UserServiceImpl;
import com.teachingassistant.util.AppConstants;
import com.teachingassistant.util.DBUtil;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet(urlPatterns={"/save-user","/getTAApplicantUserDetails"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @throws IOException 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String message = "FAIL";
		String finalJsonString = "";
		try {
			HttpSession session = request.getSession(false);
			if (session != null) {
				IUserDao userDao = new UserDaompl();
				List<UserDetails> taApplicantUsersList = userDao.getAllTAApplicants();

				if (taApplicantUsersList != null && taApplicantUsersList.size() > 0) {
					JSONArray jsonArray = new JSONArray(taApplicantUsersList);
					finalJsonString = jsonArray.toString();
				}

				message = "SUCCESS";
			} else {
				response.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			response.getWriter().print(message);
			response.getWriter().print(AppConstants.SEPARATOR_FOR_RESPONSE);
			response.getWriter().print(finalJsonString);
		}
	

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String message = "FAIL";
		String statusMessage = "";
		try {

			if (DBUtil.properties == null) {
				InputStream input = request.getServletContext().getResourceAsStream("/WEB-INF/application.properties");
				Properties properties = new Properties();
				properties.load(input);
				DBUtil.loadProperties(properties);
			}

			IUserService userService = new UserServiceImpl();

			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String mobileNumber = request.getParameter("mobileNumber");
			String emailAddress = request.getParameter("emailAddress");
			String userName = request.getParameter("userName");
			String password = request.getParameter("password");
			String userType = request.getParameter("userType");

			statusMessage = userService.saveUserDetails(firstName, lastName, mobileNumber, emailAddress, userName, password, userType);
			if (statusMessage != null && statusMessage.equals("SUCCESS")) {
				message = "SUCCESS";
			} 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			response.getWriter().print(message+AppConstants.SEPARATOR_FOR_RESPONSE+statusMessage);
		}
	}

}
