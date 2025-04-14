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
                 <a href="AdminHome.jsp">Home</a>
              </li>
              <li>
                 <a href="RepairExperts.jsp">RepairExperts</a>
              </li>
               <li>
                 <a href="RepairedGadget.jsp">RepairedGadget</a>
              </li>
              
              <li>
                 Welcome: <b><%= admin_name %></b>
              </li>
              <li>
                 <a href="Logout" class="text-danger" >Logout</a>
              </li>
          </ul>
      </div>
  </nav>
  <h4 class="bg-primary text-white text-center p-2">Gadget Details</h4>
  <div class="bg-light p-2 m-2" >
  <%
  
    int id=Integer.parseInt(request.getParameter("id"));
  	DAO db=new DAO();
  	ArrayList<HashMap> gstatus=db.getAllRepairRequestsById(id);
	db.closeConnection();
	String status=request.getParameter("status");
       for(HashMap gsg:gstatus){
		 %>
		 <section class="Container">
		 <div class="row bg-info rounded m-2 p-2">
		 <div class="col-sm ">
		  Gadget Id:&nbsp;&nbsp;<b><%= gsg.get("id") %></b><br>
		  Gadget Name:&nbsp;&nbsp;<b><%= gsg.get("name") %></b><br>
		  Gadget Brand name:&nbsp;&nbsp;<b><%= gsg.get("brand_name") %></b><br>
		  Gadget Repaired amount:&nbsp;&nbsp;<b><%= gsg.get("repair_amount") %></b><br>
		  Gadget Request User Id:&nbsp;&nbsp;<b><%= gsg.get("user_email") %></b><br>
		  Gadget Repair Expert Id:&nbsp;&nbsp;<b><%= gsg.get("repair_expert_email") %></b><br>  
		 </div>
		 <div class="col-sm">
		    <div class="row">
		       <div class="col-sm">
		        <img class="w-100 m-2" alt="" src="GetGadgetPhoto?photo_no=1&id=<%=gsg.get("id")%>" height="100px" >
		      </div>
		  <div class="col-sm m-2">
		     <img class="w-100 "alt="" src="GetGadgetPhoto?photo_no=2&id=<%=gsg.get("id")%>" height="100px"  >
		    </div>
		 </div>
		 <div class="bg-light">
  		Problem: <b><%= gsg.get("problem") %></b>
  		</div>
		 </div>
		  </div>
		  <div class="col-sm m-3">
		  <% 
			if(status.equalsIgnoreCase("pending")){
		%>
		Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
		<% 
		}else if(status.equalsIgnoreCase("WaitingApproval")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("accept")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("decline")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Decline:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("received")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>
					&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("repaired")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Amount Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>
					&nbsp;&nbsp;Repaired:<b><%= gsg.get("repaired") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("delivered")){
			%>
					Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Amount Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>
					&nbsp;&nbsp;Repaired:<b><%= gsg.get("repaired") %></b>&nbsp;&nbsp;Delivered:<b><%= gsg.get("delivered") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			
			<% 
		}else if(status.equalsIgnoreCase("confirmed")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
			<% 
		}else if(status.equalsIgnoreCase("repairing")){
			%>
			Status: &nbsp;&nbsp;Requested:<b><%= gsg.get("requested") %></b> &nbsp;&nbsp;Request Confirmed:<b><%= gsg.get("requested") %></b>&nbsp;&nbsp;Received:<b><%= gsg.get("received") %></b>&nbsp;&nbsp;Amount Received:<b><%= gsg.get("amount_rec") %></b>&nbsp;&nbsp;Approved:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Repairing:<b><%= gsg.get("approved") %></b>&nbsp;&nbsp;Current Status:<b><%= gsg.get("status") %></b>
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

  <!-- Modal -->
  <div class="modal fade" id="my-Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Get In Touch!</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form name="google-sheet">
                <input name="Name" class="form-control p-4 my-2" type="text" maxlength="20" pattern="[a-zA-Z ]+" placeholder="Your Name" required />
                <input name="Phone" class="form-control p-4 my-2" type="tel" maxlength="10" minlength="10" pattern="[0-9]+" placeholder="Your Phone" required />
                <button class="btn btn-success my-2">Submit</button>
            </form>
        </div>
      </div>
    </div>
  </div>
  <div class="modal fade" id="admin-Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title" id="exampleModalLabel">AdminLogin!</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form method="post" action="AdminLogin">
                <input name="id" class="form-control p-4 my-2" type="text" maxlength="20"  placeholder="Admin ID" required />
                <input name="password" class="form-control p-4 my-2" type="password" maxlength="20" placeholder="Admin Password" required />
                <button class="btn btn-primary my-2">Submit</button>
            </form>
        </div>
      </div>
    </div>
  </div>
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