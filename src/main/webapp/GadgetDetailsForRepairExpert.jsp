<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
<%
String repair_expert_name = (String) session.getAttribute("repair_expert_name");
String repair_expert_email = (String) session.getAttribute("repair_expert_email");
if (repair_expert_name == null) {
	session.setAttribute("msg", "Please Login First!");
	response.sendRedirect("index.jsp");
} else {
	DAO db = new DAO();
	boolean result = db.checkRepairExpertPassword(repair_expert_email);

	if (result) {
		response.sendRedirect("RepairExpertChangePassword.jsp");
	}
%>
<!DOCTYPE html>
<html>

<head>
<title>GadgetFix</title>
<%@ include file="resources/jspFile/header.jsp"%>
</head>

<body class="container-fluied">
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
				<li><a href="RepairExpertHome.jsp">Home</a></li>
				<li>Welcome: <b><%=repair_expert_name%></b>
				</li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>

	<h4 class="bg-primary text-white text-center p-2">Gadget Details</h4>
	<div class="bg-light p-2 m-2">
		<%
		int id = Integer.parseInt(request.getParameter("id"));
		ArrayList<HashMap> gstatus = db.getAllRepairRequestsById(id);
		db.closeConnection();
		for (HashMap gsg : gstatus) {
			String status = (String) gsg.get("status");
		%>
		<section class="Container">
			<div class="row rounded m-2 p-2">
				<div class="col-sm">
					<div class="row">
						<div class="col-sm">
							<img class="w-100 m-2" alt=""
								src="GetGadgetPhoto?photo_no=1&id=<%=gsg.get("id")%>"
								height="250px">
						</div>
						<div class="col-sm m-2">
							<img class="w-100 " alt=""
								src="GetGadgetPhoto?photo_no=2&id=<%=gsg.get("id")%>"
								height="250px">
						</div>
					</div>
					<div class="bg-light">
						Problem: <b><%=gsg.get("problem")%></b>
					</div>
					Gadget Id:&nbsp;&nbsp;<b><%=gsg.get("id")%></b><br> Gadget
					Name:&nbsp;&nbsp;<b><%=gsg.get("name")%></b><br> Gadget Brand
					name:&nbsp;&nbsp;<b><%=gsg.get("brand_name")%></b><br> Gadget
					Repaired amount:&nbsp;&nbsp;<b><%=gsg.get("repair_amount")%></b><br>
					Gadget Request User Id:&nbsp;&nbsp;<b><%=gsg.get("user_email")%></b><br>
					Gadget Repair Expert Id:&nbsp;&nbsp;<b><%=gsg.get("repair_expert_email")%></b><br>
					<%
					if (status.equalsIgnoreCase("pending")) {
					%>
					<a class="btn btn-success btn-sm"
						href="ChangeGadgetStatus?id=<%=gsg.get("id")%>&status=Confirmed&type=repair_expert&email=<%=gsg.get("user_email")%>">Confirmed</a>
					<%
					} else if (status.equalsIgnoreCase("confirmed")) {
					%>
					<a class="btn btn-success btn-sm"
						href="ChangeGadgetStatus?id=<%=gsg.get("id")%>&status=Received&type=repair_expert&email=<%=gsg.get("user_email")%>">Received</a>
					<%
					} else if (status.equalsIgnoreCase("accept")) {
					%>
					<a class="btn btn-success btn-sm"
						href="ChangeGadgetStatus?id=<%=gsg.get("id")%>&status=Repairing&type=repair_expert&email=<%=gsg.get("user_email")%>">Repairing</a>
					<%
					} else if (status.equalsIgnoreCase("repairing")) {
					%>
					<a class="btn btn-success btn-sm"
						href="ChangeGadgetStatus?id=<%=gsg.get("id")%>&status=Repaired&type=repair_expert&email=<%=gsg.get("user_email")%>">Repaired</a>
					<%
					} else if (status.equalsIgnoreCase("repaired")) {
					%>
					<a class="btn btn-success btn-sm"
						href="ChangeGadgetStatus?id=<%=gsg.get("id")%>&status=Delivered&type=repair_expert&email=<%=gsg.get("user_email")%>">Delivered</a>
					<%
					} else if (status.equalsIgnoreCase("received")) {
					%>
					<form method="post" action="AddRepairAmount">
						<input name="amount" class="form-control p-2 my-2" type="number"
							min="100" placeholder="Repair Amount" required /> <input
							type="hidden" name="id" value="<%=gsg.get("id")%>" /> <input
							type="hidden" name="status" value="WaitingApproval" /> <input
							type="hidden" name="email" value="<%=gsg.get("user_email")%>">
						<button class="btn btn-success my-2">Submit</button>
					</form>
					<%
					}
					%>
				</div>
				<div class="col-sm ">

					<div class="col-sm m-3 text-center">
						<%
						if (status.equalsIgnoreCase("pending")) {
						%>
						<i class="fas fa-hourglass-half"></i>
						<!-- Pending Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Current Status: <b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("WaitingApproval")) {
						%>
						<i class="fas fa-clock"></i>
						<!-- Waiting Approval Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Request Confirmed: <b><%=gsg.get("requested")%></b><br />
						Received: <b><%=gsg.get("received")%></b><br /> Amount Received:
						<b><%=gsg.get("amount_rec")%></b><br /> Current Status: <b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("accept")) {
						%>
						<i class="fas fa-check-circle"></i>
						<!-- Accepted Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Request Confirmed: <b><%=gsg.get("requested")%></b><br />
						Received: <b><%=gsg.get("received")%></b><br /> Amount Received:
						<b><%=gsg.get("amount_rec")%></b><br /> Approved: <b><%=gsg.get("approved")%></b><br />
						Current Status: <b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("decline")) {
						%>
						<i class="fas fa-times-circle"></i>
						<!-- Declined Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Request Confirmed: <b><%=gsg.get("requested")%></b><br />
						Received: <b><%=gsg.get("received")%></b><br /> Amount Received:
						<b><%=gsg.get("amount_rec")%></b><br /> Decline: <b><%=gsg.get("approved")%></b><br />
						Current Status: <b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("received")) {
						%>
						<i class="fas fa-download"></i>
						<!-- Received Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Received: <b><%=gsg.get("received")%></b><br /> Current Status: <b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("repaired")) {
						%>
						<i class="fas fa-wrench"></i>
						<!-- Repaired Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Request Confirmed: <b><%=gsg.get("requested")%></b><br /> Amount
						Received: <b><%=gsg.get("amount_rec")%></b><br /> Approved: <b><%=gsg.get("approved")%></b><br />
						Received: <b><%=gsg.get("received")%></b><br /> Repaired: <b><%=gsg.get("repaired")%></b><br />
						Current Status: <b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("delivered")) {
						%>
						<i class="fas fa-truck"></i>
						<!-- Delivered Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Request Confirmed: <b><%=gsg.get("requested")%></b><br /> Amount
						Received: <b><%=gsg.get("amount_rec")%></b><br /> Approved: <b><%=gsg.get("approved")%></b><br />
						Received: <b><%=gsg.get("received")%></b><br /> Repaired: <b><%=gsg.get("repaired")%></b><br />
						Delivered: <b><%=gsg.get("delivered")%></b><br /> Current Status:
						<b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("confirmed")) {
						%>
						<i class="fas fa-check"></i>
						<!-- Confirmed Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Request Confirmed: <b><%=gsg.get("requested")%></b><br /> Current
						Status: <b><%=gsg.get("status")%></b>
						<hr />
						<%
						} else if (status.equalsIgnoreCase("repairing")) {
						%>
						<i class="fas fa-tools"></i>
						<!-- Repairing Icon -->
						<br /> Status:<br /> Requested: <b><%=gsg.get("requested")%></b><br />
						Request Confirmed: <b><%=gsg.get("requested")%></b><br />
						Received: <b><%=gsg.get("received")%></b><br /> Amount Received:
						<b><%=gsg.get("amount_rec")%></b><br /> Approved: <b><%=gsg.get("approved")%></b><br />
						Repairing: <b><%=gsg.get("approved")%></b><br /> Current Status:
						<b><%=gsg.get("status")%></b>
						<hr />
						<%
						}
						%>
					</div>
				</div>

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
