<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Payment Success</title>
<%@ include file="resources/jspFile/header.jsp"%>
</head>
<body>
	<h1>Payment Successful</h1>

	<%
	String paymentId = request.getParameter("payment_id");
	String gadgetId = request.getParameter("id");
	String status = request.getParameter("status");
	String type = request.getParameter("type");
	String email = request.getParameter("email");
	String amount = request.getParameter("amount");
	%>

	<a class="btn btn-success btn-sm"
		href="ChangeGadgetStatus?id=<%=gadgetId%>&status=paid&type=user&email=<%=email%>">Ok</a>
</body>
</html>
