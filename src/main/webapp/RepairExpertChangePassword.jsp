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
%>
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
				<!-- <ul class="navbar-nav mx-auto"> -->
				<li><a href="RepairExpertHome.jsp">Home</a></li>
				<li><a href="RepairExpertChangePassword.jsp">ChangePassword</a>
				</li>
				<li>Welcome: <b><%= repair_expert_name %></b>
				</li>
				<li><a href="Logout" class="text-danger">Logout</a></li>
			</ul>
		</div>
	</nav>

	<div class="bg-secondary p-4">
		<h5 class="text-white">Change Password</h5>
		<form method="post" action="ChangePassword">
			<input name="old_password" class="form-control p-2 my-2"
				type="password" maxlength="50" placeholder="Old Password" required />
			<input name="new_password" class="form-control p-2 my-2"
				type="password" maxlength="50" placeholder="New Password" required />
			<input name="confirm_password" class="form-control p-2 my-2"
				type="password" maxlength="50" placeholder="Confirm Password"
				required /> <input type="hidden" name="email"
				value="<%=repair_expert_email %>" /> <input type="hidden"
				name="type" value="repair_expert" />
			<button class="btn btn-success my-2">Update</button>
		</form>
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