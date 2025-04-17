<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
<%
	String user_name=(String)session.getAttribute("user_name");
	String user_email=(String)session.getAttribute("user_email");
	if(user_name==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect(".jsp");
	}else{
%>
<!DOCTYPE html>
<html>

<head>
<title>GadgetFix</title>
<%@ include file="resources/jspFile/header.jsp"%>
</head>

<body class="">
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
				<li><a href="UserHome.jsp">Home</a></li>
				<li>Welcome: <b><%= user_name %></b>
				</li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>
	<section class="container-fluid  text-center p-4 bg-dark text-white ">
		<form method="post" action="UserHome.jsp" class="  align-items-center">
			<div class="form-row">
				<div class="col-sm-2">
					<h4>Search Repair Expert:</h4>
				</div>
				<div class="col-sm-3">
					<input class="form-control" name="state" type="text" maxlength="50"
						placeholder="State" required />
				</div>
				<div class="col-sm-3">
					<input class=" form-control" name="city" type="text" maxlength="50"
						placeholder="City" required />
				</div>
				<div class="col-sm-3">
					<input class=" form-control" name="area" type="text" maxlength="50"
						placeholder="Area (Sector or Village)" />
				</div>
				<div class="col-sm-1">
					<button class="btn btn-success btn-sm   form-control">Search</button>
				</div>
			</div>
		</form>
	</section>
	<%
  	String state=request.getParameter("state");
	String city=request.getParameter("city");
	String area=request.getParameter("area");
	if(state!=null){
  %>
	<h5 class="bg-primary text-white p-3 text-center mt-2">
		All Repair Experts [<%= area %>,<%= city %>,<%= state %>]
	</h5>
	<%
	  	DAO db=new DAO();
	  	ArrayList<HashMap> repairExperts=db.getAllRepairExpertsByStateCityArea(state,city,area);
		db.closeConnection();
		for(HashMap repairExpert:repairExperts){
			String status=(String)repairExpert.get("status");
			if(status.equalsIgnoreCase("active")){
  %>
	<p class="bg-warning p-2 my-2">
		Name: <b><%= repairExpert.get("name") %></b> State: <b><%= repairExpert.get("state") %></b>
		City: <b><%= repairExpert.get("city") %></b> Area: <b><%= repairExpert.get("area") %></b>
		&nbsp; &nbsp; <a class="btn btn-success btn-sm"
			href="RepairExpertDetailsForUser.jsp?email=<%= repairExpert.get("email") %>">
			Details </a>
	</p>
	<%	
			}
		}
	}
  %>
	<h5 class="bg-primary text-white p-3 text-center ">All Repair
		Requests</h5>

	<section class="container-fluid">
		<%
  	DAO db=new DAO();
  	ArrayList<HashMap> gadgets=db.getAllRepairRequestsByEmail("user",user_email);
	for(HashMap gadget:gadgets){
  %>
		<div class="row bg-info p-2 m-2 rounded"
			style="border: 2px solid gray;">
			<div class="col-sm">
				<p>
					ID: <b><%= gadget.get("id") %></b><br> Name: <b><%= gadget.get("name") %></b>
					<br> Brand Name: <b><%= gadget.get("brand_name") %></b> <br>
					Repair Expert Email: <b><%= gadget.get("repair_expert_email") %></b><br>
					Repair Amount: <b><%= gadget.get("repair_amount") %></b>
				</p>
				<%
				String status = (String) gadget.get("status");
				int id = (Integer) gadget.get("id");

				if (status.equalsIgnoreCase("WaitingApproval")) {
				%>
				<a class="btn btn-success btn-sm"
					href="ChangeGadgetStatus?id=<%=gadget.get("id")%>&status=Accept&type=user&email=<%=gadget.get("repair_expert_email")%>">Accept</a>
				<a class="btn btn-danger btn-sm"
					href="ChangeGadgetStatus?id=<%=gadget.get("id")%>&status=Decline&type=user&email=<%=gadget.get("repair_expert_email")%>">Decline</a>

				<%
				} else if (status.equalsIgnoreCase("pending")) {
				%>
				<a class="btn btn-danger btn-sm"
					href="DeleteGadget?id=<%=gadget.get("id")%>">Delete Request</a>
				<%
				}
				%>
			</div>
			<div class="col-sm">
				<section class="container">
					<div class="row m-2">
						<div class="col-sm m-2">
							<img class="w-100" alt=""
								src="GetGadgetPhoto?photo_no=1&id=<%=gadget.get("id")%>"
								height="100px">
						</div>
						<div class="col-sm m-2">
							<img class="w-100 " alt=""
								src="GetGadgetPhoto?photo_no=2&id=<%=gadget.get("id")%>"
								height="100px">
						</div>
					</div>
				</section>
				<div class="bg-light">
					<b>Problem:</b>
					<%= gadget.get("problem") %>
				</div>
			</div>
		</div>

		<div>

			<%
    	ArrayList<HashMap> gstatus=db.getAllRepairRequestsById(id);
  	
	for(HashMap gsg:gstatus){
		
		if(status.equalsIgnoreCase("pending")){
		%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gadget.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("WaitingApproval")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Request
			Confirmed:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount
			Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("accept")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>
			&nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount
			Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("decline")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>
			&nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount
			Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Decline:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("received")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>
			&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("repaired")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>
			&nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Amount
			Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>
			&nbsp;&nbsp;Repaired:<b><%= gsg.get("repaired") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("delivered")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Request
			Confirmed:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Amount
			Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>
			&nbsp;&nbsp;Repaired:<b><%= gsg.get("repaired") %></b>&nbsp;&nbsp;Delivered:<b><%= gsg.get("delivered") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gsg.get("status") %></b>

			<% 
		}else if(status.equalsIgnoreCase("confirmed")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Request
			Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("repairing")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>
			&nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount
			Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Repairing:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Current
			Status:<b><%= gsg.get("status") %></b>
			<% 
		}			 
	}
  %>
		</div>
		<%		
	}
  %>
		<hr>
		<section class="container my-3 p-1  ">
			<div class="row text-center align-items-center ">
				<div class="col-sm p-4" data-aos="zoom-in" data-aos-duration="1000">
					<h3>
						<span class="text-danger">About</span> our company
					</h3>
					<p class="">GadgetFix web application aims to provide a
						convenient, transparent, and efficient solution for users to get
						their electronic devices repaired by skilled technicians, ensuring
						optimal functionality and customer satisfaction.</p>
				</div>
				<div class="col-sm" data-aos="fade-left" data-aos-duration="1000">
					<img src="resources/img5.jpg" class="img-fluid rounded-lg" alt="">
				</div>
			</div>
		</section>
	</section>
	<section class="container-fluid bg-light text-center p-4">
		<img class="mx-3" src="resources/apple.png" alt="" height="50px">
		<img class="mx-3" src="resources/dell.png" alt="" height="50px">
		<img class="mx-3" src="resources/hp.png" alt="" height="50px"> <img
			class="mx-3" src="resources/lenovo.png" alt="" height="50px"> <img
			class="mx-3" src="resources/lg.png" alt="" height="50px"> <img
			class="mx-3" src="resources/mi.png" alt="" height="50px"> <img
			class="mx-3" src="resources/nokia.png" alt="" height="50px"> <img
			class="mx-3" src="resources/samsung.png" alt="" height="50px">
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
