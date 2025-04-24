package com.gadget.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.gadget.model.DAO;

/**
 * Servlet implementation class ChangeEnquiryStatus
 */
@WebServlet("/ChangeEnquiryStatus")
public class ChangeEnquiryStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			String status = request.getParameter("status");
			DAO db = new DAO();
			db.changeEnquiryStatus(id, status);
			db.closeConnection();
			HttpSession session = request.getSession();
			session.setAttribute("msg", "Status Updation Success !");
			response.sendRedirect("AdminHome.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
