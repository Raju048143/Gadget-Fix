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
   <%@ include file="resources/jspFile/header.jsp" %>
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
                 <a href="userdetails.jsp">Users</a>
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
  
  <div class="row p-4" >
  		<div class="col-sm">
  			<div class="bg-info p-4">
	  			<h5>Add New Repair Expert</h5>
	  			<form method="post" action="AddRepairExpert" enctype="multipart/form-data">
                		<input name="email" class="form-control p-2 my-2" type="email" maxlength="100" placeholder="Email" required />
                		<input name="name" class="form-control p-2 my-2" type="text" maxlength="20" pattern="[a-zA-Z ]+" placeholder="Name" required />
                		<input name="phone" class="form-control p-2 my-2" type="tel" maxlength="10" minlength="10" pattern="[0-9]+" placeholder="Phone" required />
                		<input name="state" class="form-control p-2 my-2" type="text" maxlength="50" placeholder="State" required />
                		<input name="city" class="form-control p-2 my-2" type="text" maxlength="50" placeholder="City" required />
                		<input name="area" class="form-control p-2 my-2" type="text" maxlength="50" placeholder="Area (Sector or Village)" required />
                		<input name="photo" class="form-control p-2 my-2" type="file" accept=".jpg,.png,.jpeg" required />
                		<button class="btn btn-success my-2">Add</button>
            		</form>
  			</div>
  		</div>
  		<div class="col-sm">
  			<div class="bg-secondary p-4">
	  			<h5 class="text-white">Search Repair Expert</h5>
	  			<form method="post" action="RepairExpertsSearch.jsp">
                		<input name="state" class="form-control p-2 my-2" type="text" maxlength="50" placeholder="State" required />
                		<input name="city" class="form-control p-2 my-2" type="text" maxlength="50" placeholder="City" required />
                		<input name="area" class="form-control p-2 my-2" type="text" maxlength="50" placeholder="Area (Sector or Village)"  />
                		<button class="btn btn-success my-2">Search</button>
            		</form>
  			</div>
  			<div >
			  <%
			  	DAO db=new DAO();
			  	ArrayList<HashMap> repairExperts=db.getAllRepairExperts();
				db.closeConnection();
				if(repairExperts.size()!= 0)
				{
					%>
					<h5 class="bg-primary text-white p-3 text-center mt-2">All Repair Experts</h5>
					<div class="container-fluid">
				<table class="container table table-bordered ">
					<thead class="text-center  bg-light">
						<tr>
							<th scope="col">Name</th>
							<th scope="col">Phone</th>
							<th scope="col">State</th>
							<th scope="col">Details</th>
						</tr>
			    	</thead>
					<tbody class=" bg-light">
					<% 
								 for(HashMap repairExpert:repairExperts){
								  %>
								  <tr>
							<td><%=repairExpert.get("name")%></td>
							<td><%=repairExpert.get("phone")%></td>
							<td><%=repairExpert.get("state")%></td>
		                    <td> <a class="btn btn-success btn-sm"
		                     href="RepairExpertDetails.jsp?email=<%= repairExpert.get("email") %>"> Details </a>
								  		</td> 
		               
						</tr>
								  <%		
							  }
					%>
					</tbody>
				</table>
				<% 
				}else{
					%>
			       <div class="text-center mt-4">
			         <p>Repair Expert Does not registered yet!</p>
			      </div>
			       <% 
				}
				%>
			  </div>
  		</div>
  </div>
 </div>
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