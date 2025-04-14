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
@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String old_password=request.getParameter("old_password");
			String new_password=request.getParameter("new_password");
			String confirm_password=request.getParameter("confirm_password");
			String email=request.getParameter("email");
			String type=request.getParameter("type");
			HttpSession session=request.getSession();
			if(new_password.equals(confirm_password)) {
				DAO db=new DAO();
				boolean result=db.changePassword(old_password,new_password,email,type);
				db.closeConnection();
				if(result) {
					session.setAttribute("msg", "Password Updation Success !");
				}else {
					session.setAttribute("msg", "Password Updation Failed !");
				}
			}else {
				session.setAttribute("msg", "Password Mismatched!");
			}
			response.sendRedirect("RepairExpertChangePassword.jsp");
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
