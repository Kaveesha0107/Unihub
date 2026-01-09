<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniHub - Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="./CSS/login.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<!-- Background and Overlay -->
	<div class="background"></div>
	<div class="overlay"></div>

	<!-- Login Section -->
	<div class="login-container">
		<div class="welcome-text">Welcome to UniHub</div>
		<div class="login-box">
			<h2>Log In</h2>
			<form action="login" method="post">
				<label class="form-label" for="email">📧 Email</label> <input
					type="email" class="form-control" name="email" id="email"
					placeholder="Enter your email" required> <label
					class="form-label" for="password">🔐 Password</label> <input
					type="password" class="form-control" name="password" id="password"
					placeholder="Enter your password" required>

				<div class="text-center mt-3">
					<button type="submit" class="btn-login">Sign In</button>
				</div>

				<div class="footer-text mt-4">
					New to UniHub? <a href="signup.jsp">Create your account</a><br>
					<span class="text-muted">Are you an agent? <a
						href="agentlogin.jsp">Log in here</a></span>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
