package com.gadget.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.gadget.model.DAO;
import com.gadget.model.SendMail;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AddRepairAmount")
public class AddRepairAmount extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int repair_amount = Integer.parseInt(request.getParameter("amount"));
			int id = Integer.parseInt(request.getParameter("id"));
			String status = request.getParameter("status");
			String email = request.getParameter("email");
			DAO db = new DAO();
			db.addRepairAmount(id, repair_amount);
			db.changeGadgetStatus(id, status);
			db.closeConnection();
			String body = "";
			if (status.equalsIgnoreCase("WaitingApproval")) {
				body = "Your Gadget repair amount is Quoted, Please Accept or Declinr for further Process.";
			}
			// mail send code
			SendMail.sendMail(email, "Gadget Repair Request Status", body);
			// mail send code --end

			HttpSession session = request.getSession();
			session.setAttribute("msg", "Repair Amount Quoted Success!");
			response.sendRedirect("RepairExpertHome.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
