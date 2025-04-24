<!DOCTYPE html>
<html>

<head>
<title>GadgetFix</title>
<%@ include file="resources/jspFile/header.jsp"%>
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
				<li><a href="index.jsp">Home</a></li>
				<li><a href="User.jsp">User</a></li>
				<li><a href="" data-toggle="modal" data-target="#admin-Modal">Admin</a>
				</li>
				<li><a href="" data-toggle="modal"
					data-target="#repair-expert-Modal">RepairExpert</a></li>
				<li><a href="" data-toggle="modal" data-target="#my-Modal">Contact</a>
				</li>
			</ul>
		</div>
	</nav>

	<div class="row p-4">
		<div class="col-sm">
			<div class="bg-secondary p-4">
				<h5 class="text-white">User Sign In</h5>
				<form method="post" action="UserSignIn">
					<input name="email" class="form-control p-2 my-2" type="email"
						maxlength="100" placeholder="User Email" required /> <input
						name="password" class="form-control p-2 my-2" type="password"
						maxlength="20" placeholder="Password"
						pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
							title="Password must be at least 8 characters long and include uppercase, lowercase, a number, and a special character."
							 required />
					<button class="btn btn-success my-2">Sign In</button>
				</form>
			</div>
		</div>
		<div class="col-sm">
			<div class="bg-info p-4">
				<h5>User Sign Up</h5>
				<form method="post" action="UserSignUp">
					<input name="email" class="form-control p-2 my-2" type="email"
						maxlength="100" placeholder="Email" required /> <input
						name="name" class="form-control p-2 my-2" type="text"
						maxlength="20" pattern="[a-zA-Z ]+" placeholder="Name" required />
					<input name="phone" class="form-control p-2 my-2" type="tel"
						maxlength="10" minlength="10" pattern="[0-9]+" placeholder="Phone"
						required /> <input name="password" class="form-control p-2 my-2"
						type="password" maxlength="20" placeholder="Password"
						pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
							title="Password must be at least 8 characters long and include uppercase, lowercase, a number, and a special character."
							 required />
					<button class="btn btn-success my-2">Sign Up</button>
				</form>
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