<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Agent Sign In - UniHub</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

<style>
body {
	background-color: #f5f7fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin: 0;
	min-height: 100vh;
}
.login-card {
	background: #fff;
	padding: 2.5rem 3rem;
	border-radius: 0.75rem;
	box-shadow: 0 6px 15px rgb(0 0 0/ 0.1);
	width: 100%;
	max-width: 420px;
	animation: fadeInUp 0.6s ease forwards;
}
.login-card h2 {
	color: #2575fc;
	font-weight: 700;
	margin-bottom: 2rem;
	text-align: center;
	letter-spacing: 1.5px;
}
.form-label {
	font-weight: 600;
}
.form-control:focus {
	border-color: #2575fc;
	box-shadow: 0 0 8px rgba(37, 117, 252, 0.4);
}
.btn-login {
	background-color: #2575fc;
	border: none;
	font-weight: 700;
	font-size: 1.1rem;
	padding: 0.75rem;
	border-radius: 0.5rem;
	width: 100%;
	color: white;
	transition: background-color 0.3s ease;
}
.btn-login:hover {
	background-color: #1a4ed8;
}
.links-container {
	margin-top: 1.75rem;
	text-align: center;
	font-size: 0.95rem;
	color: #555;
	display: flex;
	flex-direction: column;
	gap: 0.5rem;
}
.links-container a {
	color: #2575fc;
	text-decoration: none;
	font-weight: 600;
	transition: color 0.3s ease;
}
.links-container a:hover {
	color: #1a4ed8;
	text-decoration: underline;
}
@keyframes fadeInUp {
	from { opacity:0; transform: translateY(20px);}
	to { opacity: 1; transform: translateY(0);}
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	
    <!-- Center the login card using Bootstrap flex utilities -->
    <div class="d-flex align-items-center justify-content-center min-vh-100" style="min-height: calc(100vh - 120px);">
		<div class="login-card shadow-sm">
			<h2>
				<i class="bi bi-person-badge-fill me-2"></i>Agent Sign In
			</h2>
			<form action="agentLogin" method="post" novalidate>
				<div class="mb-3">
					<label for="email" class="form-label">Email address</label>
					<input type="email" class="form-control" id="email" name="email"
						placeholder="agent@example.com" required autocomplete="username" />
					<div class="invalid-feedback">Please enter a valid email.</div>
				</div>
				<div class="mb-4">
					<label for="password" class="form-label">Password</label>
					<input type="password" class="form-control" id="password" name="password"
						placeholder="Enter your password" required autocomplete="current-password" />
					<div class="invalid-feedback">Password is required.</div>
				</div>
				<button type="submit" class="btn-login">Sign In</button>
			</form>
			<div class="links-container">
				<a href="login.jsp">Not an agent? User Login</a>
				<a href="adminLogin.jsp">Admin Login</a>
			</div>
		</div>
	</div>
	
	<%@ include file="footer.jsp"%>
	
	<!-- Bootstrap JS Bundle -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
    // Bootstrap validation
    (() => {
      'use strict';
      const forms = document.querySelectorAll('form');
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
          if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add('was-validated');
        }, false);
      });
    })();
	</script>
</body>
</html>
