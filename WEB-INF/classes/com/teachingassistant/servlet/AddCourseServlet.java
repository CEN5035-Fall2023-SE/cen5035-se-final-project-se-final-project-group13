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

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.dao.CourseDaoImpl;
import com.teachingassistant.dao.ICourseDao;
import com.teachingassistant.util.AppConstants;

/**
 * Servlet implementation class CourseServlet
 */
@WebServlet("/add-course")
public class AddCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCourseServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String message = "FAIL";
		List<CourseDetails> coursesList = null;
		String finalJsonString = "";
		try {

			HttpSession session = request.getSession(false);
			if (session != null) {
				String courseId = request.getParameter("courseId");
				String courseName = request.getParameter("courseName");
				String professorId = request.getParameter("professorId");
				String openPositions = request.getParameter("openPositions");

				ICourseDao courseDao = new CourseDaoImpl();
				courseDao.addCourse(courseId, courseName,professorId,openPositions);

				coursesList = courseDao.loadCourseDetails();
				session.setAttribute("coursesList", coursesList);

				if (coursesList != null && coursesList.size() > 0) {
					JSONArray jsonArray = new JSONArray(coursesList);
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
