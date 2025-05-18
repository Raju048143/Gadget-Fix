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
	<%
	DAO db = new DAO();
	ArrayList<HashMap> enquiries = db.getAllEnquiries();
	db.closeConnection();
	if (enquiries.size() != 0) {
	%>
	<h4 class="bg-primary text-white text-center p-2 mt-3"
		data-aos="fade-right" data-aos-duration="1000">All Enquiries:</h4>
	<div class="container-fluid mt-3" data-aos="fade-right"
		data-aos-duration="1000">
		<table class="container table table-bordered ">
			<thead class="text-center  bg-light">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Name</th>
					<th scope="col">Phone</th>
					<th scope="col">Status</th>
					<th scope="col">Date</th>

					<th scope="col">Change Status</th>
				</tr>
			</thead>
			<tbody class=" bg-light">
				<%
				for (HashMap enquiry : enquiries) {
				%>
				<tr>
					<td><%=enquiry.get("id")%></td>
					<td><%=enquiry.get("name")%></td>
					<td><%=enquiry.get("phone")%></td>
					<td><%=enquiry.get("status")%></td>
					<td><%=enquiry.get("enquery_date")%></td>
					<td>
						<%
						if (((String) enquiry.get("status")).equalsIgnoreCase("Pending")) {
						%> <a class="btn btn-success btn-sm"
						href="ChangeEnquiryStatus?id=<%=enquiry.get("id")%>&status=Done">Done</a>
						<%
						} else {
						%> <a class="btn btn-danger btn-sm"
						href="ChangeEnquiryStatus?id=<%=enquiry.get("id")%>&status=Pending">Pending</a>
						<%
						}
						%>
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
	<div class="d-flex justify-content-center align-items-center"
		style="min-height: 80vh;">
		<div class="text-center mt-4">
			<p>No enquiries yet!</p>
		</div>

	</div>

	<%
	}
	%>

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