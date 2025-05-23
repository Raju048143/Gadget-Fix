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
				<li><a href="AdminHome.jsp">Home</a></li>
				<li><a href="RepairExperts.jsp">RepairExperts</a></li>
				<li><a href="userdetails.jsp">Users</a></li>
				<li><a href="RepairedGadget.jsp">RepairedGadget</a></li>
				<li>Welcome: <b><%=admin_name%></b>
				</li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>

	<div>
		<%
		DAO db = new DAO();
		ArrayList<HashMap> users = db.getusers();
		db.closeConnection();
		if (users.size() != 0) {
		%>
		<h4 class="bg-primary text-white text-center p-2 mt-3">All Users:</h4>
		<div class="container-fluid mt-3">
			<table class="container table table-bordered ">
				<thead class="text-center  bg-light">
					<tr>
						<th scope="col">Name</th>
						<th scope="col">Email</th>
						<th scope="col">Phone</th>
					</tr>
				</thead>
				<tbody class=" bg-light">
					<%
					for (HashMap user : users) {
					%>
					<tr>
						<td><%=user.get("name")%></td>
						<td><%=user.get("email")%></td>
						<td><%=user.get("phone")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<%
		} else {
		%>
		<div class="d-flex justify-content-center align-items-center"
			style="min-height: 80vh;">
			<div class="text-center mt-4">
				<p>User not registered yet!</p>
			</div>

		</div>

		<%
		}
		%>
	</div>
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