<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title>Checkout</title>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
	<script>
        var options = {
        		"key": "rzp_test_1WFhq0DBafo9t7",
                "amount": "<%= request.getAttribute("amount") %>", 
                "currency": "INR",
                "name": "Test Corp",
                "description": "Test Transaction",
                "order_id": "<%= request.getAttribute("order_id") %>",
                "handler": function (response) {
                    var paymentId = response.razorpay_payment_id;
                    var id = "<%= request.getAttribute("id") %>";
                    var status = "<%= request.getAttribute("status") %>";
                    var type = "<%= request.getAttribute("type") %>";
                    var email = "<%= request.getAttribute("email") %>";
                    var amount = "<%= request.getAttribute("amount") %>";

                    var redirectUrl = "success.jsp?payment_id=" + encodeURIComponent(paymentId) +
                                      "&id=" + encodeURIComponent(id) +
                                      "&status=" + encodeURIComponent(status) +
                                      "&type=" + encodeURIComponent(type) +
                                      "&email=" + encodeURIComponent(email) +
                                      "&amount=" + encodeURIComponent(amount);
                    console.log("Redirecting to: " + redirectUrl);
                    window.location.href = redirectUrl;
            },
            "theme": {
                "color": "#3399cc"
            }
        };
        var rzp = new Razorpay(options);
        rzp.open();
    </script>
</body>
</html>
