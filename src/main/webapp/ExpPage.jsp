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

	<div class="alert alert-danger" role="alert">Exception aaya re!</div>

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
	<section class="container-fluid p-0">
		<iframe style="border: none;"
			src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3945.368104069876!2d76.87738631380658!3d8.560557298509!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390cea7e051fd949%3A0xefccd5003c9032b6!2sINCAPP!5e0!3m2!1sen!2sin!4v1669980568912!5m2!1sen!2sin"
			width="100%" height="250" allowfullscreen="" loading="lazy"
			referrerpolicy="no-referrer-when-downgrade"></iframe>
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