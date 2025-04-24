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
 * Servlet implementation class AddEnquiry
 */
@WebServlet("/AddEnquiry")
public class AddEnquiry extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		try {
			DAO db = new DAO();
			db.addEnquiry(name, phone);
			db.closeConnection();
			HttpSession session = request.getSession();
			session.setAttribute("msg", "Thanks for Contacting us..! We Will Contact You Soon...!");
			response.sendRedirect("index.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}
}
