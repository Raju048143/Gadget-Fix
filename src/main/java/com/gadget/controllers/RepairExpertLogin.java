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
@WebServlet("/RepairExpertLogin")
public class RepairExpertLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		try {
			DAO db=new DAO();
			String name=db.repairExpertLogin(email, password);
			db.closeConnection();
			HttpSession session=request.getSession();
			if(name==null) {
				session.setAttribute("msg", "Invalid Entries!");
				response.sendRedirect("index.jsp");
			}else{
				session.setAttribute("repair_expert_name", name);
				session.setAttribute("repair_expert_email", email);
				response.sendRedirect("RepairExpertHome.jsp");
			}
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
