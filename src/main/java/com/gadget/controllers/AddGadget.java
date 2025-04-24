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
import com.gadget.model.SendMail;

/**
 * Servlet implementation class AddGadget
 */
@MultipartConfig
@WebServlet("/AddGadget")
public class AddGadget extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String user_email = request.getParameter("user_email");
			String address = request.getParameter("address");
			String repair_expert_email = request.getParameter("repair_expert_email");
			String gadget_name = request.getParameter("gadget_name");
			String gadget_brand_name = request.getParameter("gadget_brand_name");
			String problem = request.getParameter("problem");
			Part part1 = request.getPart("photo1");
			InputStream photo1 = part1.getInputStream();
			Part part2 = request.getPart("photo2");
			InputStream photo2 = part2.getInputStream();
			DAO db = new DAO();
			db.addGadget(gadget_name, gadget_brand_name, problem, photo1, photo2, user_email, repair_expert_email,
					address);
			db.closeConnection();
			String body = "Gadget Repair Requeste has been send Successfully,";
			SendMail.sendMail(user_email, "Gadget Repair Request Status", body);
			HttpSession session = request.getSession();
			session.setAttribute("msg", "Gadget Repair Request Send Success!");
			response.sendRedirect("UserHome.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}
}
