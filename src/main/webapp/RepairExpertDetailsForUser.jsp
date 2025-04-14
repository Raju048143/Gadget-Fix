<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
<%
	String user_name=(String)session.getAttribute("user_name");
	String user_email=(String)session.getAttribute("user_email");
	if(user_name==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("User.jsp");
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
                 <a href="UserHome.jsp">Home</a>
              </li>
              <li>
                 Welcome: <b><%= user_name %></b>
              </li>
              <li>
                 <a href="Logout" class="text-danger" >Logout</a>
              </li>
          </ul>
      </div>
  </nav>
  <section class="container-fluid ">
  <div class="row">
  <div class="col-sm  m-4 p-4">
  <%
  	String email=request.getParameter("email");
  	DAO db=new DAO();
  	HashMap<String,Object> repairExpert=db.getRepairExpertDetails(email);
	db.closeConnection();
  %>
  <h4 class="bg-info text-center p-2 rounded">Repair Expert Details!</h4>
  <div class="row bg-light mt-5 p-5 rounded" style="border:2px solid gray; ">
  
  <div  class="col-sm ">
    		<img class="rounded" style="border:2px solid gray; " alt="" src="GetPhoto?type=repair_expert&email=<%=email%>" height="150px"  width="150px">		
  
  </div>
  		<div  class="col-sm mt-2">
  		Name: <b><%= repairExpert.get("name") %></b> <br>
  		Email: <b><%= repairExpert.get("email") %></b><br> 	
  		Phone: <b><%= repairExpert.get("phone") %></b> <br>
  		State: <b><%= repairExpert.get("state") %></b> <br>
  		City: <b><%= repairExpert.get("city") %></b> <br>
  		Area: <b><%= repairExpert.get("area") %></b><br> 
  		</div>
  		
  </div>
  		
  </div>
  <div class="col-sm bg-light m-4 p-4 rounded">
 <h4 class="bg-info text-center p-2 rounded">Enter Your Gadget Details</h4>
  	<form method="post" action="AddGadget" enctype="multipart/form-data" >
        <input name="gadget_name" class="form-control p-4 my-2" type="text" maxlength="20" placeholder="Gadget Name" required />
        <input name="gadget_brand_name" class="form-control p-4 my-2" type="text" maxlength="20" placeholder="Gadget Brand Name" required />
        <textarea name="problem" placeholder="Gadget Issue" rows="3" class="form-control p-4 my-2" ></textarea>
        <label>Gadget Photo 1:</label> <input class="" name="photo1" type="file"  required /><br>
        <label>Gadget Photo 2:</label> <input class="" name="photo2" type="file"  required />
         <input name="address" class="form-control p-4 my-2" type="text" maxlength="20" placeholder="Address" required />
        <input type="hidden" name="repair_expert_email" value="<%= repairExpert.get("email") %>" >
        <input type="hidden" name="user_email" value="<%= user_email %>" >
        <button class="btn btn-info my-2">Submit</button>
    </form>

  </div>
  </div>
  </section>
  
  
  
  
  <footer class="bg-dark p-2 text-white text-center">
      <p>&copy; Rights Reserved.</p>
  </footer>
  <a id="top-button"><i class="fa-solid fa-circle-up"></i></a>

 
  <!-- Modal Get In Touch! -->
  <div class="modal fade" id="rmy-Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Get In Touch!</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form method="post" action="AddRepairEnquiry">
                <input name="name" class="form-control p-4 my-2" type="text" maxlength="20" pattern="[a-zA-Z ]+" placeholder="Your Name" required />
                <input name="phone" class="form-control p-4 my-2" type="tel" maxlength="10" minlength="10" pattern="[0-9]+" placeholder="Your Phone" required />
                <button class="btn btn-success my-2">Submit</button>
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