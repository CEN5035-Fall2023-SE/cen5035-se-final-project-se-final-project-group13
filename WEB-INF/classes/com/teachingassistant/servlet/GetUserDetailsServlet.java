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

import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;
import com.teachingassistant.util.AppConstants;

/**
 * Servlet implementation class GetUserDetailsServlet
 */
@WebServlet("/getUserDtlsByUserType")
public class GetUserDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetUserDetailsServlet() {
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
		String finalJsonString = "";
		List<UserDetails> userDtlsList = null;
		try {

			HttpSession session = request.getSession(false);
			if (session != null) {
				String userType = request.getParameter("userType");

				IUserDao userDao = new UserDaompl();
				userDtlsList = userDao.getUserDetailsBasedOnUserType(userType);

				if (userDtlsList != null && userDtlsList.size() > 0) {
					JSONArray jsonArray = new JSONArray(userDtlsList);
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
