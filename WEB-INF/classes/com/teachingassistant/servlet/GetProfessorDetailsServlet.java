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

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.ProfessorDetails;
import com.teachingassistant.dao.CourseDaoImpl;
import com.teachingassistant.dao.ICourseDao;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;
import com.teachingassistant.util.AppConstants;

/**
 * Servlet implementation class GetProfessorDetailsServlet
 */
@WebServlet(urlPatterns = { "/getProfessorDtls", "/getProfessorDtlsByCourseId" })
public class GetProfessorDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetProfessorDetailsServlet() {
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
		CourseDetails CourseAndProfessorDtls = null;
		String finalJsonString = "";
		try {

			HttpSession session = request.getSession(false);
			if (session != null) {
				String courseId = request.getParameter("courseId");

				ICourseDao courseDao = new CourseDaoImpl();
				CourseAndProfessorDtls = courseDao.getProfessorDetailsByCourseId(courseId);

				if (CourseAndProfessorDtls!=null) {
					JSONObject jsonObject = new JSONObject(CourseAndProfessorDtls);
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
		List<ProfessorDetails> professorsList = null;
		String finalJsonString = "";
		try {

			HttpSession session = request.getSession(false);
			if (session != null) {

				IUserDao userDao = new UserDaompl();
				professorsList = userDao.getProfessordetails();

				if (professorsList != null && professorsList.size() > 0) {
					JSONArray jsonArray = new JSONArray(professorsList);
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
