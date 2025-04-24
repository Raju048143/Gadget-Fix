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
 * Servlet implementation class UserSignUp
 */
@WebServlet("/UserSignUp")
public class UserSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		try {
			DAO db = new DAO();
			String msg = db.userSignUp(name, phone, email, password);
			db.closeConnection();
			HttpSession session = request.getSession();
			if (msg.equalsIgnoreCase("success")) {
				session.setAttribute("user_name", name);
				session.setAttribute("user_email", email);
				response.sendRedirect("UserHome.jsp");
			} else {
				session.setAttribute("msg", msg);
				response.sendRedirect("User.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
