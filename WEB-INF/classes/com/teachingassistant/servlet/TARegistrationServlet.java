package com.teachingassistant.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.teachingassistant.bean.CourseDetails;
import com.teachingassistant.bean.UserDetails;
import com.teachingassistant.dao.IUserDao;
import com.teachingassistant.dao.UserDaompl;
import com.teachingassistant.service.IUserService;
import com.teachingassistant.service.UserServiceImpl;
import com.teachingassistant.util.CommonUtility;
import com.teachingassistant.util.DBUtil;

/**
 * Servlet implementation class TARegistrationServlet
 */
@WebServlet("/save-application")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 5, // 10 MB
		maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class TARegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TARegistrationServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * n tc
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String message = "FAIL";
		HttpSession session = null;
		try {
			session = request.getSession(false);
			if (session != null) {

				String userId = request.getParameter("userId");
				String studentId = request.getParameter("studentId");
				String qualification = request.getParameter("qualification");
				String isPrevExpAdded = request.getParameter("isPrevExpAdded");
				String[] prevExpCourseNameArr = request.getParameterValues("preExpCourseName");
				String[] prevExpCourseFromDateArr = request.getParameterValues("preExpCourseFromDate");
				String[] preExpCourseToDateArr = request.getParameterValues("preExpCourseToDate");
				//
				String newCoursesList = request.getParameter("multipleSelectCourseId");

				System.out.println("studentId:: " + studentId);
				System.out.println("qualification:: " + qualification);
				System.out.println("isPrevExpAdded:: " + isPrevExpAdded);
				System.out.println("newCoursesList:: " + newCoursesList);

				UserDetails userDetails = (UserDetails) session.getAttribute("userDetails");
				if (!userDetails.getIsJobApplnDone().equals("Y")) {

					if (isPrevExpAdded.equals("Y")) {
						for (int i = 0; i < prevExpCourseNameArr.length; i++) {
							System.out.println(prevExpCourseNameArr[i] + " " + prevExpCourseFromDateArr[i] + " "
									+ preExpCourseToDateArr[i]);
						}
					}

					Part filePart = request.getPart("file");
					String fileName = filePart.getSubmittedFileName();
					for (Part part : request.getParts()) {
						part.write(
								DBUtil.properties.getProperty("file.path") + File.separator + userId + "_" + fileName);
					}

					/* only for .docx file - word to pdf conversion start */
					if (!fileName.substring(fileName.lastIndexOf("."), fileName.length()).equals(".pdf")) {
						CommonUtility.convertWordFileToPdf(userId, fileName);
					}
					/* only for .docx file - word to pdf conversion end */

					IUserService userService = new UserServiceImpl();
					boolean isTxnSucess = userService.saveUserJobApplicationDetails(userId, studentId, qualification,
							isPrevExpAdded, fileName, prevExpCourseNameArr, prevExpCourseFromDateArr,
							preExpCourseToDateArr, newCoursesList);
					if (isTxnSucess) {
						message = "SUCCESS";
					}

				} else {

					Part filePart = request.getPart("file");
					String fileName = "";
					if (filePart != null) {
						fileName = filePart.getSubmittedFileName();
						if(fileName!=null && !fileName.trim().equals("")) {
							for (Part part : request.getParts()) {
								part.write(DBUtil.properties.getProperty("file.path") + File.separator + userId + "_"
										+ fileName);
							}
							/* only for .docx file - word to pdf conversion start */
							if (!fileName.substring(fileName.lastIndexOf("."), fileName.length()).equals(".pdf")) {
								CommonUtility.convertWordFileToPdf(userId, fileName);
							}
							/* only for .docx file - word to pdf conversion end */
						}
					}

					IUserService userService = new UserServiceImpl();
					boolean isTxnSucess = userService.updateUserJobApplicationDetails(userId, qualification,
							isPrevExpAdded, fileName, prevExpCourseNameArr, prevExpCourseFromDateArr,
							preExpCourseToDateArr, newCoursesList);
					/*
					 * List<CourseDetails> courseDetailsList = new ArrayList<CourseDetails>();
					 * for(String course:newCoursesList.split(",")) { CourseDetails courseDetails =
					 * new CourseDetails(); courseDetails.setCourseId(course);
					 * courseDetailsList.add(courseDetails); }
					 * 
					 * IUserDao userDao = new UserDaompl();
					 * userDao.saveUserNewCourseDetails(courseDetailsList, userId,fileName);
					 */
					if (isTxnSucess) {
						message = "SUCCESS";
					}
				}

				session.setAttribute("statusMessage", message);
			} else {
				response.sendRedirect("login.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.setAttribute("statusMsg", message);
				try {
					if (message.equals("SUCCESS")) {
						UserDetails userDetails = (UserDetails) session.getAttribute("userDetails");
						userDetails.setIsJobApplnDone("Y");
						session.setAttribute("userDetails", userDetails);
					}
				} catch (Exception e2) {
					e2.printStackTrace();
				}

			}
			response.getWriter().print(message);
			if (message.equals("SUCCESS")) {
				response.sendRedirect("application-track.jsp");
			} else {
				response.sendRedirect("applicant-registration.jsp");
			}

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
