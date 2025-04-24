package com.gadget.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.gadget.model.DAO;

/**
 * Servlet implementation class GetGadgetPhoto
 */
@WebServlet("/GetGadgetPhoto")
public class GetGadgetPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			int photo_no = Integer.parseInt(request.getParameter("photo_no"));
			int id = Integer.parseInt(request.getParameter("id"));
			DAO db = new DAO();
			byte[] photo = db.getGadgetPhoto(photo_no, id);
			db.closeConnection();
			response.getOutputStream().write(photo);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
