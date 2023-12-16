package com.teachingassistant.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;

/**
 * Servlet implementation class CheckApplicantEligibleForCourseServlet
 */
@WebServlet("/checkApplicantEligibleForCourse")
public class CheckApplicantEligibleForCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CheckApplicantEligibleForCourseServlet() {
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
		try {

			HttpSession session = request.getSession(false);
			if (session != null) {
				String courseId = request.getParameter("courseId");
				UserDetails userDetails = (UserDetails) session.getAttribute("userDetails");

				IUserDao userDao = new UserDaompl();
				boolean isEligible = userDao.isApplicantEligibleToApplyForCourse(userDetails.getUserId(), courseId);

				if (isEligible) {
					message = "SUCCESS";
				}

			} else {
				response.sendRedirect("login.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			response.getWriter().print(message);
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
