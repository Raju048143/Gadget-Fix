<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
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
</head>

<body>
	<%
	String msg = (String) session.getAttribute("msg");
	if (msg != null && msg.contains("Success")) {
	%>
	<div class="alert alert-success text-center" role="alert">
		<%=msg%>
	</div>
	<%
	session.setAttribute("msg", null);
	} else if (msg != null) {
	%>
	<div class="alert alert-danger text-center" role="alert">
		<%=msg%>
	</div>
	<%
	session.setAttribute("msg", null);
	}
	%>
	<%@ include file="resources/jspFile/info.jsp"%>
	<nav class="navbar navbar-expand-sm bg-light">
		<a href="index.jsp" id="logo" class="navbar-brand"> <img
			src="resources/logo.png" alt="">Gadget<span>Fix</span>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#my-navbar">
			<i class="fa-solid fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="my-navbar">
			<ul class="navbar-nav ml-auto">
				<!-- <ul class="navbar-nav mr-auto"> -->
				<!-- <ul class="navbar-nav mx-auto"> -->
				<li><a href="AdminHome.jsp">Home</a></li>
				<li><a href="RepairExperts.jsp">RepairExperts</a></li>
				<li><a href="RepairedGadget.jsp">RepairedGadget</a></li>

				<li>Welcome: <b><%=admin_name%></b>
				</li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>
	<h4 class="bg-primary text-white text-center p-2">Gadget Details</h4>
	<div class="bg-light p-2 m-2">
		<%
		int id = Integer.parseInt(request.getParameter("id"));
		DAO db = new DAO();
		ArrayList<HashMap> gstatus = db.getAllRepairRequestsById(id);
		db.closeConnection();
		String status = request.getParameter("status");
		for (HashMap gsg : gstatus) {
		%>
		<section class="Container">
			<div class="row bg-info rounded m-2 p-2">
				<div class="col-sm ">
					Gadget Id:&nbsp;&nbsp;<b><%=gsg.get("id")%></b><br> Gadget
					Name:&nbsp;&nbsp;<b><%=gsg.get("name")%></b><br> Gadget
					Brand name:&nbsp;&nbsp;<b><%=gsg.get("brand_name")%></b><br>
					Gadget Repaired amount:&nbsp;&nbsp;<b><%=gsg.get("repair_amount")%></b><br>
					Gadget Request User Id:&nbsp;&nbsp;<b><%=gsg.get("user_email")%></b><br>
					Gadget Repair Expert Id:&nbsp;&nbsp;<b><%=gsg.get("repair_expert_email")%></b><br>
				</div>
				<div class="col-sm">
					<div class="row">
						<div class="col-sm">
							<img class="w-100 m-2" alt=""
								src="GetGadgetPhoto?photo_no=1&id=<%=gsg.get("id")%>"
								height="100px">
						</div>
						<div class="col-sm m-2">
							<img class="w-100 " alt=""
								src="GetGadgetPhoto?photo_no=2&id=<%=gsg.get("id")%>"
								height="100px">
						</div>
					</div>
					<div class="bg-light">
						Problem: <b><%=gsg.get("problem")%></b>
					</div>
				</div>
			</div>
			<div class="col-sm m-3">
				<%
				if (status.equalsIgnoreCase("pending")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("WaitingApproval")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Request
				Confirmed:<b><%=gsg.get("requested")%></b> &nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
				Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("accept")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
				&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
				Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("decline")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
				&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
				Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Decline:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("received")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>
				&nbsp;&nbsp;Current Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("repaired")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
				&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Amount
				Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>
				&nbsp;&nbsp;Repaired:<b><%=gsg.get("repaired")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("delivered")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Request
				Confirmed:<b><%=gsg.get("requested")%></b> &nbsp;&nbsp;Amount
				Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>
				&nbsp;&nbsp;Repaired:<b><%=gsg.get("repaired")%></b>&nbsp;&nbsp;Delivered:<b><%=gsg.get("delivered")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>

				<%
				} else if (status.equalsIgnoreCase("confirmed")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Request
				Confirmed:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("repairing")) {
				%>
				Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
				&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
				Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Repairing:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%></b>
				<%
				}
				%>
			</div>
		</section>
		<%
		}
		%>

	</div>


	<footer class="bg-dark p-2 text-white text-center">
		<p>&copy; Rights Reserved.</p>
	</footer>
	<a id="top-button"><i class="fa-solid fa-circle-up"></i></a>

</body>
<script>
	AOS.init();
	//script for scroll to top
	$("#top-button").click(function() {
		$("html, body").animate({
			scrollTop : 0
		}, 1000);
	});
	//script for light box
	$(document).on('click', '[data-toggle="lightbox"]', function(event) {
		event.preventDefault();
		$(this).ekkoLightbox();
	});
</script>
</html>
<%
}
%>