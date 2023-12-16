package com.teachingassistant.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.teachingassistant.bean.UserApplicationDetails;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;
import com.teachingassistant.util.AppConstants;

/**
 * Servlet implementation class GetApplicantDetailsServlet
 */
@WebServlet("/getApplicantDtlsByCourseId")
public class GetApplicantDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetApplicantDetailsServlet() {
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
		UserApplicationDetails applicantCourseDtls = null;
		String finalJsonString = "";
		try {
			HttpSession session = request.getSession(false);
			if (session != null) {
				String userId = request.getParameter("userId");
				String courseId = request.getParameter("courseId");
				String status = request.getParameter("status");
				String courseUniqueId = request.getParameter("courseUniqueId");

				IUserDao userDao = new UserDaompl();
				applicantCourseDtls = userDao.getApplicantDetailsOnCourseId(userId, courseId, status,courseUniqueId);

				if (applicantCourseDtls != null) {
					JSONObject jsonObject = new JSONObject(applicantCourseDtls);
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
