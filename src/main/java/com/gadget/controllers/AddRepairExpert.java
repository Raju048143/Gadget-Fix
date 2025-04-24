package com.gadget.controllers;

import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.gadget.model.DAO;

/**
 * Servlet implementation class AddRepairExpert
 */
@MultipartConfig
@WebServlet("/AddRepairExpert")
public class AddRepairExpert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String state = request.getParameter("state");
			String city = request.getParameter("city");
			String area = request.getParameter("area");
			Part part = request.getPart("photo");
			InputStream photo = part.getInputStream();
			DAO db = new DAO();
			String result = db.addRepairExpert(name, phone, email, state, city, area, photo);
			db.closeConnection();
			HttpSession session = request.getSession();
			session.setAttribute("msg", result);
			response.sendRedirect("RepairExperts.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
