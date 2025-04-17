<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
<%
	String repair_expert_name=(String)session.getAttribute("repair_expert_name");
	String repair_expert_email=(String)session.getAttribute("repair_expert_email");
	if(repair_expert_name==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("index.jsp");
	}else{
		DAO db=new DAO();
	  	boolean result=db.checkRepairExpertPassword(repair_expert_email);
		
		if(result){
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
				<li><a href="RepairExpertHome.jsp">Home</a></li>
				<li><a href="RepairExpertChangePassword.jsp">ChangePassword</a>
				</li>
				<li>Welcome: <b><%= repair_expert_name %></b>
				</li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>

	<section class="container-fluied">
		<%
  	ArrayList<HashMap> gadgets=db.getAllRepairRequestsByEmail("repair_expert",repair_expert_email);
	
		if (gadgets.size() != 0) {
			%>
			<h4 class="bg-primary text-white text-center p-2">All Repair Requests:</h4>
			<div class="container-fluid mt-3">
				<table class="container table table-bordered ">
					<thead class="text-center  bg-light">
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Name</th>
							<th scope="col">Brand Name</th>
							<th scope="col">Status</th>
							<th scope="col">Details</th>
						</tr>
					</thead>
					<tbody class=" bg-light">
						<%
						for (HashMap gadget : gadgets) {
						%>
						<tr>
							<td><%=gadget.get("id")%></td>
							<td><%=gadget.get("name")%></td>
							<td><%=gadget.get("brand_name")%></td>
							<td><%=gadget.get("status")%></td>
							<td><a class="btn btn-success btn-sm"
									href="GadgetDetailsForRepairExpert.jsp?id=<%= gadget.get("id") %>">
										Details </a></td>
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
					<p>No Gadget Request Found yet!</p>
				</div>

			</div>

			<%
			}
			%>

	</section>
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
