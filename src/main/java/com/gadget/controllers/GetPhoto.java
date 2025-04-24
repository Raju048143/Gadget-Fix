package com.gadget.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.gadget.model.DAO;

/**
 * Servlet implementation class GetPhoto
 */
@WebServlet("/GetPhoto")
public class GetPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type");
		String email = request.getParameter("email");
		try {
			DAO db = new DAO();
			byte[] photo = db.getPhoto(type, email);
			db.closeConnection();
			response.getOutputStream().write(photo);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
