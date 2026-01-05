<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<title>Contact Us - UniHub</title>
<style>

/* ===== Header ===== */
body {
	margin: 0;
	font-family: 'Segoe UI', sans-serif;
	background-color: #f4f6f8;
}

.header {
	background: white;
	position: sticky;
	top: 0;
	z-index: 1000;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.navbar {
	max-width: 1200px;
	margin: 0 auto;
	padding: 18px 20px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
}

.logo {
	display: flex;
	align-items: center;
	animation: fadeIn 1s ease-out;
}

.logo h1 {
	font-size: 24px;
	font-weight: 700;
	color: #2c3e50;
}

.logo span {
	color: #3498db;
	position: relative;
}

.logo span::after {
	content: '';
	position: absolute;
	bottom: -3px;
	left: 0;
	width: 100%;
	height: 2px;
	background-color: #3498db;
	transform: scaleX(0);
	transition: transform 0.3s ease-out;
	transform-origin: bottom right;
}

.logo:hover span::after {
	transform: scaleX(1);
	transform-origin: bottom left;
}

.menu-toggle {
	display: none;
	font-size: 30px;
	color: black;
	background: none;
	border: none;
	cursor: pointer;
}

.nav-links-container {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 20px;
}

.nav-links ul {
	list-style: none;
	display: flex;
	gap: 18px;
	margin: 0;
	padding: 0;
}

.nav-links ul li a {
	position: relative;
	text-decoration: none;
	color: black;
	font-weight: 500;
	padding: 8px 14px;
	border-radius: 6px;
	transition: color 0.3s ease;
}

.nav-links ul li a::after {
	content: '';
	position: absolute;
	left: 0;
	bottom: 0;
	width: 100%;
	height: 2px;
	background-color: #3498db;
	transform: scaleX(0);
	transform-origin: bottom right;
	transition: transform 0.3s ease;
}

.nav-links ul li a:hover::after, .nav-links ul li a.active::after {
	transform: scaleX(1);
	transform-origin: bottom left;
}

.nav-links ul li a:hover {
	color: #3498db;
}

.auth-links {
	display: flex;
	gap: 10px;
}

.auth-links a {
	padding: 8px 14px;
	border: 2px solid black;
	border-radius: 6px;
	text-decoration: none;
	color: black;
	font-weight: 600;
	transition: 0.3s;
}

.auth-links a:hover {
	background-color: #013866;
	color: white;
}

/* Responsive Styling */
@media ( max-width : 768px) {
	.menu-toggle {
		display: block;
	}
	.nav-links-container {
		display: none;
		width: 100%;
		flex-direction: column;
		background-color: #eceef1;
		margin-top: 10px;
		border-radius: 0 0 10px 10px;
	}
	.nav-links-container.active {
		display: flex;
		padding: 10px 0;
	}
	.nav-links ul {
		flex-direction: column;
		width: 100%;
		text-align: center;
	}
	.auth-links {
		flex-direction: column;
		width: 100%;
		align-items: center;
		padding-top: 10px;
	}
	.auth-links a {
		width: 90%;
		text-align: center;
	}
}

/* ===== finish Header ===== */
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #f0f8ff, #e0f7fa);
	color: #333;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.hero-card-card {
	background-color: #ffffff;
	margin: 40px auto;
	padding: 40px 30px;
	max-width: 600px;
	border-radius: 12px;
	box-shadow: 0px 6px 15px #d9dee2;
	text-align: center;
}

.hero-card-card h2 {
	font-size: 2rem;
	color: black;
	margin-bottom: 20px;
}

.hero-card-card button {
	background-color: #105d9d;
	border: none;
	padding: 12px 24px;
	font-size: 1rem;
	border-radius: 8px;
	cursor: pointer;
	transition: background 0.3s;
	color: white;
}

.hero-card-card button:hover {
	background-color: #237cc6;
}

.card-grid {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 20px;
	padding: 40px 20px;
}

.card {
	background-color: #fff;
	padding: 20px;
	border-radius: 12px;
	width: 250px;
	text-align: center;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card img {
	width: 50px;
	margin-bottom: 10px;
}

.contact-form-section {
	display: none;
	padding: 40px 20px;
	background-color: #ebf2fc;
}

.contact-container {
	background-color: white;
	max-width: 600px;
	margin: auto;
	padding: 100px;
	border-radius: 10px;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.contact-container h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #0077b6;
}

.contact-container input, .contact-container textarea {
	width: 100%;
	padding: 10px;
	margin: 10px 0px;
	border-radius: 6px;
	border: 1px solid #ccc;
}

.contact-container button {
	background-color: #0077b6;
	color: white;
	border: none;
	padding: 12px 20px;
	border-radius: 6px;
	font-size: 1rem;
	cursor: pointer;
	width: 100%;
}

.contact-container button:hover {
	background-color: #023e8a;
}
</style>
</head>
<body>

	<!-- ===== Header ===== -->
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




	<!-- Hero Section as a Card -->
	<section class="hero-card-card">
		<h2>We’d Love to Hear From You</h2>
		<button onclick="showContactForm()">Send Us a Message 📥</button>
	</section>

	<!-- Contact Cards -->
	<section class="card-grid">
		<div class="card">
			<img src="https://cdn-icons-png.flaticon.com/512/15/15924.png"
				alt="Phone">
			<h3>Phone</h3>
			<p>+94 77 123 4567</p>
		</div>
		<div class="card">
			<img src="https://cdn-icons-png.flaticon.com/512/561/561127.png"
				alt="Email">
			<h3>Email</h3>
			<p>support@unihub.lk</p>
		</div>
		<div class="card">
			<img src="https://cdn-icons-png.flaticon.com/512/684/684908.png"
				alt="Location">
			<h3>Location</h3>
			<p>New Kandy Road, Malabe</p>
		</div>
	</section>

	<!-- Contact Form (Hidden Initially) -->
	<section class="contact-form-section" id="contactForm">
		<div class="contact-container">
			<h2>Send Us a Message</h2>
			<form action="newContactUs" method="post">
				<input type="text" name="name" placeholder="Your Name" required>
				<input type="email" name="email" placeholder="Your Email" required>
				<input type="text" name="subject" placeholder="Subject" required>
				<textarea name="message" placeholder="Your Message" required></textarea>
				<button type="submit">Send Message</button>
			</form>
		</div>
	</section>



	<script>
		function showContactForm() {
			document.getElementById("contactForm").style.display = "block";
			document.getElementById("contactForm").scrollIntoView({
				behavior : "smooth"
			});
			function toggleMenu() {
				document.getElementById("navLinks").classList.toggle("active");
			}
		}
	</script>
	<%@ include file="footer.jsp"%>
</body>
</html>
