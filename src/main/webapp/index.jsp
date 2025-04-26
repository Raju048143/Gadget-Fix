<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gadget.model.DAO"%>
<html>
<head>
<title>GadgetFix</title>
<%@ include file="resources/jspFile/header.jsp"%>
</head>
<body>

	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null && msg.contains("Thanks")){
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

				<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a>
				</li>
				
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="loginDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> Login / Register </a>
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="loginDropdown">
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#user-login">User Login</a> <a class="dropdown-item"
							href="#" data-toggle="modal" data-target="#user-register-Modal">User
							Register</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#admin-Modal">Admin Login</a> <a
							class="dropdown-item" href="#" data-toggle="modal"
							data-target="#repair-expert-Modal">Repair Expert Login</a>
					</div></li>

				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#my-Modal">Contact</a></li>

			</ul>
		</div>
	</nav>

	<section class="container-fluid  text-center p-4 bg-dark text-white ">
		<form method="post" action="index.jsp" class="  align-items-center">
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
	String state = request.getParameter("state");
	String city = request.getParameter("city");
	String area = request.getParameter("area");
	if (state != null) {
	%>
  		<h5 class="bg-primary text-white p-3 text-center mt-2">All Repair Experts [<%= area %>,<%= city %>,<%= state %>]</h5>
  <%
	  	DAO db=new DAO();
	  	ArrayList<HashMap> repairExperts=db.getAllRepairExpertsByStateCityArea(state,city,area);
		db.closeConnection();
		for(HashMap repairExpert:repairExperts){
			String status=(String)repairExpert.get("status");
			if(status.equalsIgnoreCase("active")){
  %>
	  		<p class="bg-warning p-2 my-2"> 
	  		Name: <b><%= repairExpert.get("name") %></b> 
	  		State: <b><%= repairExpert.get("state") %></b> 
	  		City: <b><%= repairExpert.get("city") %></b> 
	  		Area: <b><%= repairExpert.get("area") %></b> 
	  		&nbsp; &nbsp; <a class="btn btn-success btn-sm" href="RepairExpertDetails.jsp?email=<%= repairExpert.get("email") %>"> Details </a>
	  		</p>
  <%	
			}
		}
	}
  %>

	<section class="container my-5">
		<div class="row text-center align-items-center">
			<div class="col-sm" data-aos="fade-right" data-aos-duration="1000">
				<img src="resources/img1.jpg" class="img-fluid rounded-lg" alt="">
			</div>
			<div class="col-sm p-4" data-aos="zoom-in" data-aos-duration="1000">
				<h3>
					<span class="text-danger">Welcome</span> to GadgetFix
				</h3>
				<p>GadgetFix enables to Repair Gadgets. Whether your smartphone,
					tablet, laptop, or any other electronic device is experiencing
					issues, our platform offers a user-friendly experience to help you
					get your gadgets up and running again</p>
			</div>
		</div>
	</section>

	<section class="bg-dark text-white p-5 text-center" id="service">
		<h4>
			GadgetFix can handle all of your gadget repair solutions <br />
			SERVICES INCLUDING
		</h4>
		<div class="row mt-5 mb-3">
			<div class="col-sm">
				<div>
					<p>
						<i class="fa-solid fa-angle-right"></i>Screen
					</p>
					<p>
						<i class="fa-solid fa-angle-right"></i> Battery
					</p>
					<p>
						<i class="fa-solid fa-angle-right"></i>MIC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</p>

				</div>
			</div>
			<div class="col-sm">
				<div>
					<p>
						<i class="fa-solid fa-angle-right"></i> Charging Jack
					</p>
					<p>
						<i class="fa-solid fa-angle-right"></i>Speaker
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</p>
					<p>
						<i class="fa-solid fa-angle-right"></i> AUX
						Jack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</p>


				</div>
			</div>
			<div class="col-sm">
				<div>
					<p>
						<i class="fa-solid fa-angle-right"></i>FronT Camera
					</p>
					<p>
						<i class="fa-solid fa-angle-right"></i> Back Camera
					</p>
					<p>
						<i class="fa-solid fa-angle-right"></i> Back
						Panel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</p>

				</div>
			</div>
		</div>
		<button class="btn btn-warning btn-sm" data-toggle="modal"
			data-target="#my-Modal">Get In Touch</button>
	</section>
	<section class="container my-5">
		<div class="row text-center align-items-center">
			<div class="col-sm p-4" data-aos="zoom-in" data-aos-duration="1000">
				<h3>
					<span class="text-danger">About</span> our company
				</h3>
				<p>GadgetFix web application aims to provide a convenient,
					transparent, and efficient solution for users to get their
					electronic devices repaired by skilled technicians, ensuring
					optimal functionality and customer satisfaction.</p>
			</div>
			<div class="col-sm" data-aos="fade-left" data-aos-duration="1000">
				<img src="resources/img5.jpg" class="img-fluid rounded-lg" alt="">
			</div>
		</div>
	</section>
	<section class="container-fluid bg-light text-center p-3">
		<img class="mx-3" src="resources/apple.png" alt="" height="50px">
		<img class="mx-3" src="resources/dell.png" alt="" height="50px">
		<img class="mx-3" src="resources/hp.png" alt="" height="50px"> <img
			class="mx-3" src="resources/lenovo.png" alt="" height="50px"> <img
			class="mx-3" src="resources/lg.png" alt="" height="50px"> <img
			class="mx-3" src="resources/mi.png" alt="" height="50px"> <img
			class="mx-3" src="resources/nokia.png" alt="" height="50px"> <img
			class="mx-3" src="resources/samsung.png" alt="" height="50px">
	</section>
	<section class="container my-5 text-center" id="testimonials">
		<h4>TESTIMONIALS</h4>
		<div class="row my-5">
			<div class="col-sm">
				<div>
					<img src="resources/person1.jpg" alt="">
					<p>
						<span><i class="fa-solid fa-quote-left fa-3x"></i></span> I
						recently had the opportunity to use the GadgetFix web application,
						and I must say that it exceeded my expectations. As someone who
						frequently encounters technical issues with my devices, finding a
						reliable and efficient solution has always been a priority for me.
						GadgetFix proved to be the perfect tool to address my tech-related
						problems
					</p>
					<strong>Priyanka Kumari</strong>
				</div>
			</div>
			<div class="col-sm">
				<div>
					<img src="resources/person2.jpg" alt="">
					<p>
						<span><i class="fa-solid fa-quote-left fa-3x"></i></span> I
						recently had the opportunity to use the GadgetFix web application
						for repairing my smartphone, and I must say, it exceeded all my
						expectations. As someone who heavily relies on their gadgets,
						finding a reliable and efficient repair service is crucial.
						GadgetFix not only delivered on these fronts but also provided a
						seamless user experience.
					</p>
					<strong>Manish kumar</strong>
				</div>
			</div>
			<div class="col-sm">
				<div>
					<img src="resources/person1.jpg" alt="">
					<p>
						<span><i class="fa-solid fa-quote-left fa-3x"></i></span>I
						recently had the opportunity to use the GadgetFix web application
						to repair a malfunctioning smartphone, and I must say that I was
						impressed with its comprehensive features and user-friendly
						interface. GadgetFix offers a one-stop solution for gadget
						repairs, making it a valuable tool for both tech-savvy individuals
						and professionals in the industry.
					</p>
					<strong>Sunita Singh</strong>
				</div>
			</div>
		</div>
	</section>

	<footer class="bg-dark p-2 text-white text-center">
		<p>&copy; Rights Reserved.</p>
	</footer>

	<!-- Modal Get In Touch! -->
	<div class="modal fade" id="my-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info text-white">
					<h5 class="modal-title" id="exampleModalLabel">Get In Touch!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="AddEnquiry">
						<input name="name" class="form-control p-4 my-2" type="text"
							maxlength="20" pattern="[a-zA-Z ]+" placeholder="Your Name"
							required /> <input name="phone" class="form-control p-4 my-2"
							type="tel" maxlength="10" minlength="10" pattern="[0-9]+"
							placeholder="Your Phone" required />
						<button class="btn btn-success my-2">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- User Login! -->
	<div class="modal fade" id="user-login" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info text-white">
					<h5 class="modal-title" id="exampleModalLabel">User login!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="UserSignIn">
						<input name="email" class="form-control p-4 my-2" type="email"
							maxlength="45" placeholder="Email"
							pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
							title="Please enter a valid email address (e.g., user@example.com)"
							required /> <input name="password" class="form-control p-4 my-2"
							type="password" maxlength="20" placeholder=" Password"
							pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
							title="Password must be at least 8 characters long and include uppercase, lowercase, a number, and a special character."
							required />
						<div class="d-flex justify-content-end">
							<button class="btn btn-primary my-2">Sign In</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Adminlogin! -->
	<div class="modal fade" id="admin-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info text-white">
					<h5 class="modal-title" id="exampleModalLabel">Admin Login!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="AdminLogin">
						<input name="id" class="form-control p-4 my-2" type="text"
							maxlength="20" placeholder="Admin ID"
							pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
							title="Please enter a valid email address (e.g., user@example.com)"
							required /> <input name="password" class="form-control p-4 my-2"
							type="password" maxlength="20" placeholder="Admin Password"
							pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
							title="Password must be at least 8 characters long and include uppercase, lowercase, a number, and a special character."
							required />
						<div class="d-flex justify-content-end">
							<button class="btn btn-primary my-2">Login</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Repair Expert Login! -->
	<div class="modal fade" id="repair-expert-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info text-white">
					<h5 class="modal-title" id="exampleModalLabel">Repair Expert
						Login!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="RepairExpertLogin">
						<input name="email" class="form-control p-4 my-2" type="email"
							maxlength="100" placeholder="Email ID"
							pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
							title="Please enter a valid email address (e.g., user@example.com)"
							required /> <input name="password" class="form-control p-4 my-2"
							type="password" maxlength="20" placeholder="Password"
							pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
							title="Password must be at least 8 characters long and include uppercase, lowercase, a number, and a special character."
							required />
						<div class="d-flex justify-content-end">
							<button class="btn btn-info my-2">Login</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- User Registration -->
	<div class="modal fade" id="user-register-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info text-white">
					<h5 class="modal-title" id="exampleModalLabel">User
						Registration!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="UserSignUp">
						<input name="email" class="form-control p-2 my-2" type="email"
							maxlength="100" placeholder="Email"
							pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
							title="Please enter a valid email address (e.g., user@example.com)"
							required /> <input name="name" class="form-control p-2 my-2"
							type="text" maxlength="20" pattern="[a-zA-Z ]+"
							placeholder="Name" required /> <input name="phone"
							class="form-control p-2 my-2" type="tel" maxlength="10"
							minlength="10" pattern="[0-9]+" placeholder="Phone" required />
						<input name="password" class="form-control p-2 my-2"
							type="password" maxlength="20" placeholder="Password"
							pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
							title="Password must be at least 8 characters long and include uppercase, lowercase, a number, and a special character."
							required />
						<div class="d-flex justify-content-end">
							<button class="btn btn-info my-2">Sign Up</button>
						</div>
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