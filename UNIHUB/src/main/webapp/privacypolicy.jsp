<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when
		test="${not empty sessionScope.role and sessionScope.role == 'user'}">
		<jsp:include page="loggedUserHeader.jsp" />
	</c:when>
	<c:otherwise>
		<jsp:include page="header.jsp" />
	</c:otherwise>
</c:choose>

<meta charset="UTF-8">
<title>Privacy Policy - UniHub</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #f0f8ff, #e0f7fa);
	color: #333;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.header1 {
	text-align: center; /* Centers the text */
	color: #145d9b;
}

.header1 h1 {
	font-size: 2.8em;
	font-weight: 700;
	margin-bottom: 10px;
	text-decoration: underline;
}

.header1 p {
	font-size: 1.2em;
	font-weight: 400;
}

.container {
	flex: 1;
	max-width: 900px;
	margin: 40px auto;
	background: #ffffff;
	padding: 50px;
	border-radius: 15px;
	box-shadow: 1px 10px 10px #042b4b;
	transition: transform 0.3s ease;
}

.container:hover {
	transform: translateY(-5px);
}

h2 {
	color: #195485;
	font-weight: 560;
	margin-top: 30px;
}

p {
	margin: 12px 0;
	font-size: 15px;
	line-height: 1.6;
}

ul {
	margin-left: 20px;
	margin-top: 10px;
}

ul li {
	margin-bottom: 8px;
	font-size: 15px;
}

@media ( max-width : 768px) {
	.header h1 {
		font-size: 2em;
	}
	.container {
		padding: 30px;
		margin: 20px;
	}
}
</style>
</head>
<body>


	<div class="container">

		<div class="header1">
			<h1>Privacy Policy</h1>
			<p>Your data is safe with UniHub</p>
		</div>


		<h2>1. Introduction</h2>
		<p>At UniHub, we respect your privacy and are committed to
			protecting your personal data. This Privacy Policy explains how we
			collect, use, and secure your information.</p>

		<h2>2. Information We Collect</h2>
		<p>We may collect the following personal information:</p>
		<ul>
			<li>Your name, email, phone number</li>
			<li>University details, support tickets</li>
			<li>Usage patterns and feedback</li>
		</ul>

		<h2>3. How We Use Your Data</h2>
		<p>Your data is used to:</p>
		<ul>
			<li>Process support tickets</li>
			<li>Connect you with campus agents</li>
			<li>Improve our platform and services</li>
			<li>Send updates or notifications (with your consent)</li>
		</ul>

		<h2>4. Data Sharing</h2>
		<p>We never sell your data. We only share it when necessary to
			fulfill our services or comply with legal obligations.</p>

		<h2>5. Security Measures</h2>
		<p>We use secure servers, encryption, and access controls to
			protect your data from unauthorized access or misuse.</p>

		<h2>6. Cookies</h2>
		<p>Our site uses cookies to enhance your experience. You can
			disable cookies in your browser settings if preferred.</p>

		<h2>7. Your Rights</h2>
		<p>
			You may request access, update, or deletion of your data anytime by
			contacting us at <strong>support@unihub.lk</strong>.
		</p>

		<h2>8. Changes to Policy</h2>
		<p>We may update this policy. Any changes will be posted here with
			an updated effective date.</p>

		<h2>9. Contact Us</h2>
		<p>
			If you have any questions, feel free to email us at <strong>support@unihub.lk</strong>.
		</p>
		<p>This document was last updated on May 10,2025.</p>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
