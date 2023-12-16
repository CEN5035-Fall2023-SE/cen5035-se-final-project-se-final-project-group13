package com.teachingassistant.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.dao.CourseDaoImpl;
import com.teachingassistant.dao.ICourseDao;
import com.teachingassistant.dao.ILoginDao;
import com.teachingassistant.dao.LoginDaoImpl;
import com.teachingassistant.util.DBUtil;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final Logger logger = Logger.getLogger(LoginServlet.class.getName());

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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

		logger.info("[doPost] method starts..");
		String message = "FAIL";
		try {

			if (DBUtil.properties == null) {
				InputStream input = request.getServletContext().getResourceAsStream("/WEB-INF/application.properties");
				Properties properties = new Properties();
				properties.load(input);
				DBUtil.loadProperties(properties);
			}

			HttpSession session = request.getSession(true);
			String userName = request.getParameter("userName");
			String password = request.getParameter("password");

			logger.log(Level.INFO, "userName:: " + userName);

//			logger.debug("userName:: ", userName);

			ILoginDao loginDao = new LoginDaoImpl();

			UserDetails userDetails = loginDao.getLoginDetails(userName, password);
			if (userDetails != null) {
				logger.info("userDetails is not null");
				session.setAttribute("userDetails", userDetails);
				session.setAttribute("filePath", DBUtil.properties.getProperty("file.path"));

				ICourseDao courseDao = new CourseDaoImpl();
				List<CourseDetails> coursesList = courseDao.loadCourseDetails();
				session.setAttribute("coursesList", coursesList);

				System.out.println("coursesList ssize:: " + coursesList.size());

				message = "SUCCESS";
				logger.log(Level.INFO, "login entry is found for user - " + userName);
			} else {
				logger.info("userDetails is null");
				logger.log(Level.INFO, "No login entry found for user - " + userName);
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.log(Level.SEVERE, "Exception occured:: " + e);
//			logger.error("Exception occured - ", e);
		} finally {
			logger.log(Level.INFO, "statusMessage:: " + message);
//			logger.debug("statusMessage:: {}", message);
			response.getWriter().print(message);
		}
		logger.info("[doPost] method ends..");
	}

}
