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
  <link rel="icon" href="resources/logo.png" />

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" />

  <!-- font-awesome  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"></script>

  <!-- Lightbox CSS & Script -->
  <script src="resources/lightbox/ekko-lightbox.js"></script>
  <link rel="stylesheet" href="resources/lightbox/ekko-lightbox.css"/>
  <!-- Lightbox END -->

  <!-- AOS css and JS -->
  <link rel="stylesheet" href="resources/aos/aos.css">
  <script src="resources/aos/aos.js"></script>
  <!-- AOS css and JS END-->

  <!-- custom css -->
  <link rel="stylesheet" href="resources/custom.css">

  <meta name="author" content="Rahul Chauhan" />
  <meta name="description" content="This is a website for Gadget Repaire Service." />
  <meta name="keywords" content="" />
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
  <section class="bg-dark" id="contact">
      <a id="contact-mail" href="mailto:info@gadgetfix.com"><i class="fa-solid fa-envelope"></i> info@gadgetfix.com</a>
      <a id="contact-phone" href="tel:9811981198"><i class="fa-solid fa-mobile-screen-button"></i> <strong>9811981198</strong></a>
  </section>
  <nav class="navbar navbar-expand-sm bg-light">
      <a href="index.jsp" id="logo" class="navbar-brand">
        <img src="resources/logo.png" alt="">Gadget<span>Fix</span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
      <div class="collapse navbar-collapse" id="my-navbar">
          <ul class="navbar-nav ml-auto">
          <!-- <ul class="navbar-nav mr-auto"> -->
          <!-- <ul class="navbar-nav mx-auto"> -->
              <li>
                 <a href="RepairExpertHome.jsp">Home</a>
              </li>
              <li>
                 <a href="RepairExpertChangePassword.jsp">ChangePassword</a>
              </li>
              <li>
                 Welcome: <b><%= repair_expert_name %></b>
              </li>
              <li>
                 <a href="Logout" class="text-danger" >Logout</a>
              </li>
          </ul>
      </div>
  </nav>
  
 <section class="container-fluied">
 <h5 class="bg-primary text-white p-3 text-center ">All Repair Requests</h5> 
	
  <%
  	ArrayList<HashMap> gadgets=db.getAllRepairRequestsByEmail("repair_expert",repair_expert_email);
	
	for(HashMap gadget:gadgets){
  %>
  <div class="row bg-info rounded p-2 m-2">
		<div class=" col-sm">
			<p>
				ID: <b><%= gadget.get("id") %></b><br>
			    Name: <b><%= gadget.get("name") %></b><br>
				Brand Name: <b><%= gadget.get("brand_name") %></b><br>
			
				Status: <b><%= gadget.get("status") %></b> <br>
				Repair Amount: <b><%= gadget.get("repair_amount") %></b><br>
				User Email: <b><%= gadget.get("user_email") %></b> 
				User Address: <b><%= gadget.get("address") %></b> 
			</p>
				<%
				String status = (String) gadget.get("status");
				if (status.equalsIgnoreCase("pending")) {
				%>
				<a class="btn btn-success btn-sm"
					href="ChangeGadgetStatus?id=<%=gadget.get("id")%>&status=Confirmed&type=repair_expert&email=<%=gadget.get("user_email")%>">Confirmed</a>
				<%
				} else if (status.equalsIgnoreCase("confirmed")) {
				%>
				<a class="btn btn-success btn-sm"
					href="ChangeGadgetStatus?id=<%=gadget.get("id")%>&status=Received&type=repair_expert&email=<%=gadget.get("user_email")%>">Received</a>
				<%
				} else if (status.equalsIgnoreCase("accept")) {
					%>
					<a class="btn btn-success btn-sm"
					href="ChangeGadgetStatus?id=<%=gadget.get("id")%>&status=Repairing&type=repair_expert&email=<%=gadget.get("user_email")%>">Repairing</a>
				<%
				} else if (status.equalsIgnoreCase("repairing")) {
				%>
				<a class="btn btn-success btn-sm"
				href="ChangeGadgetStatus?id=<%=gadget.get("id")%>&status=Repaired&type=repair_expert&email=<%=gadget.get("user_email")%>">Repaired</a>
			<%
			} else if (status.equalsIgnoreCase("repaired")) {
			%>
			<a class="btn btn-success btn-sm"
				href="ChangeGadgetStatus?id=<%=gadget.get("id")%>&status=Delivered&type=repair_expert&email=<%=gadget.get("user_email")%>">Delivered</a>
			<%
			} else if (status.equalsIgnoreCase("received")) {
				%>
				<form method="post" action="AddRepairAmount">
				<input name="amount" class="form-control p-2 my-2" type="number"
					min="100" placeholder="Repair Amount" required /> <input
					type="hidden" name="id" value="<%= gadget.get("id") %>" />
	           <input type="hidden" name="status" value="WaitingApproval" />
				<input type="hidden" name="email" value="<%=gadget.get("user_email")%>" >	
				<button class="btn btn-success my-2">Submit</button>
			</form>
				<%
				}
			%>
		</div>
	  <div class="col-sm">
  		 <section class="container">
  		  <div class="row m-2">
  		     <div class="col-sm m-2">
  			    <img class="w-100" alt="" src="GetGadgetPhoto?photo_no=1&id=<%=gadget.get("id")%>" height="100px" >
  		     </div>
  		     <div class="col-sm m-2">
 		         <img class="w-100 "alt="" src="GetGadgetPhoto?photo_no=2&id=<%=gadget.get("id")%>" height="100px"  >
  		    </div>
  		  </div>
  		</section>
  		<div class="bg-light">
  		Problem: <b><%= gadget.get("problem") %></b>
  		</div> 
  	  </div> 		
  </div>
		<div class="ml-2">
			<%
			int id = (Integer) gadget.get("id");
			ArrayList<HashMap> gstatus = db.getAllRepairRequestsById(id);

			for (HashMap gsg : gstatus) {
				if (status.equalsIgnoreCase("pending")) {
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Current
			Status:<b><%=gadget.get("status")%></b>
			<%
			} else if (status.equalsIgnoreCase("WaitingApproval")) {
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Request
			Confirmed:<b><%=gsg.get("confirmed")%></b> &nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
			Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Current
			Status:<b><%=gsg.get("status")%></b>
			<%
			} else if (status.equalsIgnoreCase("accept")) {
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
			&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("confirmed")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
			Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Current
			Status:<b><%=gsg.get("status")%></b>
			<%
			} else if (status.equalsIgnoreCase("decline")) {
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
			&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("confirmed")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
			Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Decline:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Current
			Status:<b><%=gsg.get("status")%></b>
			<%
			} else if (status.equalsIgnoreCase("received")) {
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;confirmed:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>
			&nbsp;&nbsp;Current Status:<b><%=gsg.get("status")%></b>
			<%
			} else if (status.equalsIgnoreCase("repaired")) {
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
			&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("confirmed")%></b>&nbsp;&nbsp;Amount
			Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>
			&nbsp;&nbsp;Repaired:<b><%=gsg.get("repaired")%></b>&nbsp;&nbsp;Current
			Status:<b><%=gsg.get("status")%></b>
			<%
			} else if (status.equalsIgnoreCase("delivered")) {
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Request
			Confirmed:<b><%=gsg.get("confirmed")%></b> &nbsp;&nbsp;Amount
			Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>
			&nbsp;&nbsp;Repaired:<b><%=gsg.get("repaired")%></b>&nbsp;&nbsp;Delivered:<b><%=gsg.get("delivered")%></b>&nbsp;&nbsp;Current
			Status:<b><%=gsg.get("status")%></b>

			<%
			} else if (status.equalsIgnoreCase("confirmed")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>&nbsp;&nbsp;Request
			Confirmed:<b><%=gsg.get("confirmed")%></b>&nbsp;&nbsp;Current
			Status:<b><%=gsg.get("status")%></b>
				<%
				} else if (status.equalsIgnoreCase("repairing")) {
				%> Status: &nbsp;&nbsp;Requested:<b><%=gsg.get("requested")%></b>
				&nbsp;&nbsp;Request Confirmed:<b><%=gsg.get("confirmed")%></b>&nbsp;&nbsp;Received:<b><%=gsg.get("received")%></b>&nbsp;&nbsp;Amount
				Received:<b><%=gsg.get("amount_rec")%></b>&nbsp;&nbsp;Approved:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Repairing:<b><%=gsg.get("approved")%></b>&nbsp;&nbsp;Current
				Status:<b><%=gsg.get("status")%> </b><% 
			}
					 
		}
	  %>
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
