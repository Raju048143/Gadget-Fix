
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
<%@page import="java.util.*"%>
<%
String admin_name = (String) session.getAttribute("admin_name");
if (admin_name == null) {
	session.setAttribute("msg", "Please Login First!");
	response.sendRedirect("index.jsp");
} else {
%>
<!DOCTYPE html>
<html>

<head>
	<title>GadgetFix</title>
	<%@ include file="resources/jspFile/header.jsp"%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>
	<%@ include file="resources/jspFile/info.jsp"%>
	<nav class="navbar navbar-expand-sm bg-light">
		<a href="index.jsp" id="logo" class="navbar-brand">
			<img src="resources/logo.png" alt="">Gadget<span>Fix</span>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar">
			<i class="fa-solid fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="my-navbar">
			<ul class="navbar-nav ml-auto">
				<li><a href="AdminHome.jsp">Home</a></li>
				<li><a href="RepairExperts.jsp">RepairExperts</a></li>
				<li><a href="RepairedGadget.jsp">RepairedGadget</a></li>
				<li>Welcome: <b><%=admin_name%></b></li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>

	<h4 class="bg-primary text-white text-center p-2">Gadget Details</h4>
	<div class="bg-light p-2 m-2">
	<%
		DAO db = new DAO();
		int id = Integer.parseInt(request.getParameter("id"));
		ArrayList<HashMap> gstatus = db.getAllRepairRequestsById(id);
		db.closeConnection();
		for (HashMap gsg : gstatus) {
			String currentStatus = (String) gsg.get("status");

			List<String> statuses = Arrays.asList(
				"pending", "WaitingApproval", "confirmed", "accept",
				"received", "repairing", "repaired", "delivered", "decline"
			);

			Map<String, String[]> steps = new LinkedHashMap<>();
			steps.put("pending", new String[] {
				"<i class='fas fa-hourglass-half icon'></i>", 
				"Requested: <b>" + gsg.get("requested").toString().substring(0, 10) + "</b>"
			});
			steps.put("WaitingApproval", new String[] {
				"<i class='fas fa-clock icon'></i>", 
				"Received: <b>" + gsg.get("received").toString().substring(0, 10) + "</b><br>Amount Received: <b>" + gsg.get("amount_rec") + "</b>"
			});
			steps.put("confirmed", new String[] {
				"<i class='fas fa-check icon'></i> ", 
				"Confirmed: <b>" + gsg.get("requested").toString().substring(0, 10) + "</b>"
			});
			steps.put("accept", new String[] {
				"<i class='fas fa-check-circle icon'></i>", 
				"Approved: <b>" + gsg.get("approved").toString().substring(0, 10) + "</b>"
			});
			steps.put("received", new String[] {
				"<i class='fas fa-download icon'></i>", 
				"Received: <b>" + gsg.get("received").toString().substring(0, 10) + "</b>"
			});
			steps.put("repairing", new String[] {
				"<i class='fas fa-tools icon'></i> ", 
				"Repairing: <b>" + gsg.get("approved").toString().substring(0, 10) + "</b>"
			});
			steps.put("repaired", new String[] {
				"<i class='fas fa-wrench icon'></i> ", 
				"Repaired: <b>" + gsg.get("repaired").toString().substring(0, 10) + "</b>"
			});
			steps.put("delivered", new String[] {
				"<i class='fas fa-truck icon'></i>", 
				"Delivered: <b>" + gsg.get("delivered").toString().substring(0, 10) + "</b>"
			});
			steps.put("decline", new String[] {
				"<i class='fas fa-times-circle icon'></i>", 
				"Declined: <b>" + gsg.get("approved").toString().substring(0, 10) + "</b>"
			});

			int currentIndex = statuses.indexOf(currentStatus);
	%>
		<section class="Container">
			<div class="row rounded m-2 p-2">
				<div class="col-sm">
					<div class="row">
						<div class="col-sm">
							<img class="w-100 m-2" alt=""
								src="GetGadgetPhoto?photo_no=1&id=<%=gsg.get("id")%>" height="250px">
						</div>
						<div class="col-sm m-2">
							<img class="w-100" alt=""
								src="GetGadgetPhoto?photo_no=2&id=<%=gsg.get("id")%>" height="250px">
						</div>
					</div>
					<div class="bg-light">Problem: <b><%=gsg.get("problem")%></b></div>
					Gadget Id: <b><%=gsg.get("id")%></b><br>
					Gadget Name: <b><%=gsg.get("name")%></b><br>
					Gadget Brand Name: <b><%=gsg.get("brand_name")%></b><br>
					Gadget Repair Amount: <b><%=gsg.get("repair_amount")%></b><br>
					User Email: <b><%=gsg.get("user_email")%></b><br>
					Repair Expert Email: <b><%=gsg.get("repair_expert_email")%></b><br>
				</div>

				<div class="col-sm">
					<h2>Repair Status Tracking</h2>
					<div class="order-tracking">
						<%
							for (int i = 0; i < statuses.size(); i++) {
								String key = statuses.get(i);
								String[] content = steps.get(key);
								String cssClass = "";
								if (i < currentIndex) cssClass = "completed";
								else if (i == currentIndex) cssClass = "in-progress";
						%>
						<div class="step <%= cssClass %>">
							<div class="status-icon "></div>
							<div class="line"></div>
							<div>
								<div class="status-text"><%= content[0] %></div>
								<div class="detail-text"><%= content[1] %></div>
							</div>
						</div>
						<% } %>
					</div>
				</div>
			</div>
		</section>
	<% } %>
	</div>

	<footer class="bg-dark p-2 text-white text-center">
		<p>&copy; Rights Reserved.</p>
	</footer>

	<a id="top-button"><i class="fa-solid fa-circle-up"></i></a>

	<script>
		AOS.init();
		$("#top-button").click(function () {
			$("html, body").animate({ scrollTop: 0 }, 1000);
		});
		$(document).on('click', '[data-toggle="lightbox"]', function (event) {
			event.preventDefault();
			$(this).ekkoLightbox();
		});
	</script>
</body>
</html>
<% } %>
