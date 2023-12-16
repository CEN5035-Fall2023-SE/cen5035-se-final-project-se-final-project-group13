package com.teachingassistant.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.teachingassistant.bean.UserApplicationDetails;
import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;
import com.teachingassistant.util.AppConstants;

/**
 * Servlet implementation class FetchJobApplicantsServlet
 */
@WebServlet(urlPatterns = { "/get-applicants", "/getUserApplnCourseDtls" })
public class FetchJobApplicantsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FetchJobApplicantsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String message = "FAIL";
		UserApplicationDetails userApplicationDetails = null;
		String finalJsonString = "";
		try {
			HttpSession session = request.getSession(false);
			if (session != null) {
				UserDetails userDetails = (UserDetails) session.getAttribute("userDetails");

				IUserDao userDao = new UserDaompl();
				userApplicationDetails = userDao.getUserCourseApplnDetails(userDetails.getUserId());

				if (userApplicationDetails != null) {
					JSONObject jsonObject = new JSONObject(userApplicationDetails);
					finalJsonString = jsonObject.toString();
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String message = "FAIL";
		List<UserApplicationDetails> applicantsList = null;
		String finalJsonString = "";
		try {
			HttpSession session = request.getSession(false);
			if (session != null) {
				String userId = request.getParameter("userId");
				String courseId = request.getParameter("courseId");
				String status = request.getParameter("status");

				IUserDao userDao = new UserDaompl();
				applicantsList = userDao.getApplicantCourseDetails(userId, courseId, status);

				if (applicantsList != null && applicantsList.size() > 0) {
					JSONArray jsonArray = new JSONArray(applicantsList);
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

}
