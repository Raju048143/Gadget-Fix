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
  
  <%
  	DAO db=new DAO();
  	ArrayList<HashMap> enquiries=db.getAllEnquiries();
	db.closeConnection();
  %>

  <h4 class="bg-primary text-white text-center p-2 mt-3" data-aos="fade-right" data-aos-duration="1000">All Enquiries:</h4>
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
                    <td><%=enquiry.get("e_date")%></td> 
                    <td><%
  	      		if( ((String)enquiry.get("status")).equalsIgnoreCase("Pending")){
  	         	%>
  		     	<a class="btn btn-success btn-sm" href="ChangeEnquiryStatus?id=<%= enquiry.get("id") %>&status=Done">Done</a>
  		        <%		
  			    }else{
  	         	%>
  	  		<a class="btn btn-danger btn-sm" href="ChangeEnquiryStatus?id=<%= enquiry.get("id") %>&status=Pending">Pending</a>
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