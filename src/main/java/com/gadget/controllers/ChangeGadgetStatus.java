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
@WebServlet("/ChangeGadgetStatus")
public class ChangeGadgetStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int id=Integer.parseInt(request.getParameter("id"));
			String status=request.getParameter("status");
			String email=request.getParameter("email");
			DAO db=new DAO();
			db.changeGadgetStatus(id, status);
			db.closeConnection();		
			String body="";
			if(status.equalsIgnoreCase("pending")) 
			 {
				body="Your Gadget repair request has been approved.";
			}else if(status.equalsIgnoreCase("confirmed"))  {
				body="Your Gadget Repair Request has been accepted, Our team will receive Your Gadget Soon";
			}else if(status.equalsIgnoreCase("WaitingApproval"))  {
				body="Your Gadget repair amount is Quoted, Please Accept or Declinr for further Process.";
			}else if(status.equalsIgnoreCase("decline"))  {
				body="Your Gadget Repaired Request has been deleted";
			}else if(status.equalsIgnoreCase("accept")) {
				body="Your Gadget Repair amount is Accepted";
			}else if(status.equalsIgnoreCase("received")) {
				
				body="Your Gadget has been received By our repaire experts.";
			}else if(status.equalsIgnoreCase("repaired")){
				body="Your Gadget has been Repaired.";
			}else if(status.equalsIgnoreCase("repairing")){
				body="Your Gadget is under process.";
			}else if(status.equalsIgnoreCase("delivered")) {
				body="Your Gadget has been delivered.";
			}
			//mail send code
			SendMail.sendMail(email, "Gadget Repair Request Status", body);
			//mail send code --end
			
			HttpSession session=request.getSession();
			session.setAttribute("msg", "Status Updation Success !");
			String type=request.getParameter("type");
			if(type.equalsIgnoreCase("user")) {
				response.sendRedirect("UserHome.jsp");
			}else {
				response.sendRedirect("RepairExpertHome.jsp");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
