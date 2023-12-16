package com.teachingassistant.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.util.IOUtils;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/view-file")
public class PDFViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PDFViewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fileName = request.getParameter("fileName");
		fileName = fileName.replace(".docx", ".pdf").replace(".doc", ".pdf");
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\" ");
		InputStream fis = null;
		OutputStream out = null;
		try {
			fis = new FileInputStream("C://Files//" + fileName);
			out = response.getOutputStream();
			
//			out.write(fis.readAllBytes());
			
			byte[] bytes = IOUtils.toByteArray(fis);
			out.write(bytes);
			
			out.flush();
			
//			String xmlContent =  new String(fos.toByteArray(), "UTF-8");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				fis.close();
				out.close();
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
