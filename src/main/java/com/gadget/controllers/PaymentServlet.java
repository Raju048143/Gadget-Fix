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
            RazorpayClient client = new RazorpayClient("rzp_test_1WFhq0DBafo9t7", "0a6hRfeF6XWSlZvTtRjtFGbs");

            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", 500); 
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "order_rcptid_11");

            Order order = client.orders.create(orderRequest);
            request.setAttribute("order_id", order.get("id"));
            request.setAttribute("amount", "500");

            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error creating Razorpay order", e);
        }
    }
}
