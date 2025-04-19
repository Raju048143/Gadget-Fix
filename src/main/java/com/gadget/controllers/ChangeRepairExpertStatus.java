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
 * Servlet implementation class AdminLogin
 */
@WebServlet("/ChangeRepairExpertStatus")
public class ChangeRepairExpertStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String email = request.getParameter("email");
			String status = request.getParameter("status");
			DAO db = new DAO();
			db.changeRepairExpertStatus(email, status);
			db.closeConnection();
			HttpSession session = request.getSession();
			session.setAttribute("msg", "Status Updation Success !");
			response.sendRedirect("RepairExpertDetails.jsp?email=" + email);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
