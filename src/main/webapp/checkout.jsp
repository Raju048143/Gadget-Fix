<%@ page contentType="text/html;charset=UTF-8" %>
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
                alert("Payment successful! Payment ID: " + response.razorpay_payment_id);
                window.location.href = "success.jsp";
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
