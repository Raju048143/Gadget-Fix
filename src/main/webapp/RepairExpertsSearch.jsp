<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
<%
	String admin_name=(String)session.getAttribute("admin_name");
	if(admin_name==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("index.jsp");
	}else{
%>
<!DOCTYPE html>
<html>

<head>
<title>GadgetFix</title>
<%@ include file="resources/jspFile/header.jsp"%>
</head>

<body>
	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null && msg.contains("Success")){
	%>
	<div class="alert alert-success text-center" role="alert">
		<%= msg %>
	</div>
	<%		  
			session.setAttribute("msg", null);
		}else if(msg!=null){
	%>
	<div class="alert alert-danger text-center" role="alert">
		<%= msg %>
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
				<li><a href="AdminHome.jsp">Home</a></li>
				<li><a href="RepairExperts.jsp">RepairExperts</a></li>
				<li>Welcome: <b><%= admin_name %></b>
				</li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>
<%
	String state = request.getParameter("state");
	String city = request.getParameter("city");
	String area = request.getParameter("area");

	if (state != null && city != null && area != null) {
		state = state.trim();
		city = city.trim();
		area = area.trim();

		DAO db = new DAO();
		ArrayList<HashMap> repairExperts = db.getAllRepairExpertsByStateCityArea(state, city, area);
		db.closeConnection();

		// Filter only active experts
		ArrayList<HashMap<String, String>> activeExperts = new ArrayList<>();
		for (HashMap<String, String> expert : repairExperts) {
			String status = expert.get("status");
			if (status != null && "active".equalsIgnoreCase(status)) {
				activeExperts.add(expert);
			}
		}

		if (!activeExperts.isEmpty()) {
%>
			<h5 class="bg-info text-white p-3 text-center">
				All Repair Experts [<%= area %>, <%= city %>, <%= state %>]
			</h5>
			<div class="table-responsive mt-3 text-center">
				<table class="table table-bordered table-striped">
					<thead class="table-dark">
						<tr>
							<th>Name</th>
							<th>State</th>
							<th>City</th>
							<th>Area</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (HashMap<String, String> expert : activeExperts) {
						%>
						<tr>
							<td><%= expert.get("name") %></td>
							<td><%= expert.get("state") %></td>
							<td><%= expert.get("city") %></td>
							<td><%= expert.get("area") %></td>
							<td>
								<a class="btn btn-success btn-sm"
								   href="RepairExpertDetails.jsp?email=<%= expert.get("email") %>">
									Details
								</a>
							</td>
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
			<p class="text-danger text-center mt-3">
				No repair experts available in the selected location.
			</p>
<%
		}
	} else {
%>
		<p class="text-warning text-center mt-3">
			Please select state, city, and area to view repair experts.
		</p>
<%
	}
%>


	<footer class="bg-dark p-2 text-white text-center">
		<p>&copy; Rights Reserved.</p>
	</footer>
	<a id="top-button"><i class="fa-solid fa-circle-up"></i></a>

</body>
<script>
    AOS.init();
    //script for scroll to top
    $("#top-button").click(function () {
        $("html, body").animate({scrollTop: 0}, 1000);
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