package com.teachingassistant.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.teachingassistant.service.IUserService;
import com.teachingassistant.service.UserServiceImpl;
import com.teachingassistant.util.AppConstants;

/**
 * Servlet implementation class EditUserProfileServlet
 */
@WebServlet("/update-profile")
public class UpdateUserProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUserProfileServlet() {
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
		String statusMessage = "";
		try {

			HttpSession session = request.getSession(false);
			if (session != null) {
				String userId = request.getParameter("userId");
				String firstName = request.getParameter("firstName");
				String lastName = request.getParameter("lastName");
				String mobileNumber = request.getParameter("mobileNumber");
				String emailAddress = request.getParameter("emailAddress");
				String password = request.getParameter("password");

				IUserService userService = new UserServiceImpl();
				statusMessage = userService.updateUserDetails(userId, firstName, lastName, mobileNumber, emailAddress,
						password);
				if (statusMessage != null && statusMessage.equals("SUCCESS")) {
					message = "SUCCESS";
				}
			} else {
				response.sendRedirect("login.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			response.getWriter().print(message + AppConstants.SEPARATOR_FOR_RESPONSE + statusMessage);
		}
	}

}
