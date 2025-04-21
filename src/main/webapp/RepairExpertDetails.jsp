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
    String msg = (String) session.getAttribute("msg");
if (msg != null && !msg.isEmpty()) { %>
	<div class="modal fade show" id="msgModal" tabindex="-1" role="dialog"
		style="display: block; background-color: rgba(0, 0, 0, 0.5);"
		aria-modal="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content border-0">
				<div
					class="modal-header bg-<%=msg.contains("Success") ? "success" : "danger"%> text-white">
					<h5 class="modal-title">
						<%=msg.contains("Success") ? "Success" : "Error"%>
					</h5>
					<button type="button" class="close text-white"
						onclick="closeMsgModal()" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body text-center fs-5">
					<%=msg%>
				</div>
			</div>
		</div>
	</div>
	<%
        session.setAttribute("msg", null);
    }
    %>
	<h4 class="bg-primary text-white p-2 text-center ">Repair Expert
		Details</h4>
	<section class="container bg-light mt-5 p-5 rouded">
		<div class="row">
			<div class="col-sm p-1">

				<%
  	String email=request.getParameter("email");
  	DAO db=new DAO();
  	HashMap<String,Object> repairExpert=db.getRepairExpertDetails(email);
	db.closeConnection();
  %>
				<img class="rounded mt-3" style="border: 2px solid gray;" alt=""
					src="GetPhoto?type=repair_expert&email=<%=email%>" height="150px">

				<br> Email: <b><%= repairExpert.get("email") %></b><br>
				Name: <b><%= repairExpert.get("name") %></b><br> Phone: <b><%= repairExpert.get("phone") %></b>
				<br>
				<% String status=(String)repairExpert.get("status"); %>
				Status: <b><%= status %></b><br> State: <b><%= repairExpert.get("state") %></b>
				<br> City: <b><%= repairExpert.get("city") %></b> <br>
				Area: <b><%= repairExpert.get("area") %></b>

			</div>
			<div class="col-sm mt-5 p-5">
				<%
					if (status.equalsIgnoreCase("active")) {
					%>
				<a class="btn btn-danger btn-sm mt-5"
					href="ChangeRepairExpertStatus?email=<%=repairExpert.get("email")%>&status=Deactive">Deactivate</a>
				<%
					} else {
					%>
				<a class="btn btn-success btn-sm mt-5"
					href="ChangeRepairExpertStatus?email=<%=repairExpert.get("email")%>&status=Active">Activate</a>
				<%
					}
					%>
			</div>
		</div>

	</section>

	<footer class="bg-dark p-2 text-white text-center mt-5">
		<p>&copy; Rights Reserved.</p>
	</footer>

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
function closeMsgModal() {
    const modal = document.getElementById("msgModal");
    modal.classList.remove("show");
    modal.style.display = "none";
}

// Auto close after 3 seconds
setTimeout(() => closeMsgModal(), 3000);

</script>
</html>
<%		
	}
%>