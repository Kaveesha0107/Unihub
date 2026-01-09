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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Terms and Conditions</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	overflow-x: hidden;
	background-color: linear-gradient(135deg, #f0f8ff, #e0f7fa);
}

.container {
	display: flex;
	min-height: 100vh;
	width: 100%;
}

.left-section {
	width: 50%;
	padding: 80px 60px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	background-color: white;
}

.right-section {
	width: 50%;
	background-color: #B8C5D6;
	overflow: hidden;
}

.right-section img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.title {
	font-size: 48px;
	font-weight: bold;
	color: #111;
	line-height: 1.1;
	margin-bottom: 20px;
}

.description {
	color: #777;
	margin-bottom: 30px;
	line-height: 1.6;
}

.cta-button {
	background-color: #3783c2;
	color: white;
	border: none;
	padding: 8px 12px;
	border-radius: 16px;
	font-weight: bold;
	cursor: pointer;
	display: inline-block;
	text-decoration: none;
	text-transform: uppercase;
	font-size: 11px;
	letter-spacing: 0.4px;
	box-shadow: 0 2px 5px rgba(55, 131, 194, 0.3);
	width: auto;
	max-width: 100px;
	white-space: nowrap;
}

@media ( max-width : 768px) {
	.container {
		flex-direction: column;
	}
	.left-section, .right-section {
		width: 100%;
	}
	.left-section {
		padding: 40px 20px;
	}
	.right-section {
		height: 400px;
	}
}
</style>
</head>
<body>
	<div class="container">
		<div class="left-section">
			<h1 class="title">
				Terms<br>And Conditions
			</h1>
			<p class="description">Please review our Terms and Conditions to
				understand your rights, responsibilities, and the rules that guide
				your use of UniHub</p>
			<!-- ✅ Link to Terms and Conditions page -->
			<a href="TermsAndCondition.jsp" class="cta-button">Learn More..</a>
		</div>
		<div class="right-section">
			<img src="image/terms.jpg" alt="Terms and conditions illustration">
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
