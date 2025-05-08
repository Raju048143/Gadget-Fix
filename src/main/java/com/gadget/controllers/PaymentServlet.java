package com.gadget.controllers;

import com.razorpay.RazorpayClient;
import com.razorpay.Order;
import org.json.JSONObject;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Servlet implementation class PaymentServlet
 */
@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			String status = request.getParameter("status");
			String amountStr = request.getParameter("amount");
			String type = request.getParameter("type");
			String email = request.getParameter("email");
			int amount = Integer.parseInt(amountStr) + 50;
			RazorpayClient client = new RazorpayClient("rzp_test_1WFhq0DBafo9t7", "0a6hRfeF6XWSlZvTtRjtFGbs");

			JSONObject orderRequest = new JSONObject();
			orderRequest.put("amount", amount * 100);
			orderRequest.put("currency", "INR");
			orderRequest.put("receipt", "order_rcptid_" + id);

			Order order = client.orders.create(orderRequest);

			String orderId = order.toJson().get("id").toString();
			request.setAttribute("amount", amount * 100);
			request.setAttribute("id", id);
			request.setAttribute("status", status);
			request.setAttribute("type", type);
			request.setAttribute("email", email);
			request.setAttribute("order_id", order.get("id"));

			RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			throw new ServletException("Error creating Razorpay order", e);
		}
	}
}
