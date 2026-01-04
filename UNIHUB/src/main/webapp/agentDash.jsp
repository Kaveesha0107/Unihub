<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*"%>
<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equals("agent")) {
	response.sendRedirect("agentlogin.jsp");
}
String fname = (String) session.getAttribute("fname");
if (fname == null) {
	fname = "Agent";
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Agent Dashboard</title>

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet" />

<style>
body {
	min-height: 100vh;
	display: flex;
	background-color: #f5f7fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
/* Sidebar styles */
#sidebar {
	min-width: 250px;
	max-width: 250px;
	background: #343a40;
	color: #fff;
	transition: all 0.3s;
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	overflow-y: auto;
}

#sidebar .sidebar-header {
	padding: 1.5rem;
	background: #212529;
	font-size: 1.5rem;
	font-weight: 700;
	text-align: center;
	letter-spacing: 2px;
	user-select: none;
}

#sidebar ul.components {
	padding: 0;
	margin: 0;
	list-style: none;
}

#sidebar ul li {
	padding: 15px 20px;
	font-size: 1rem;
	cursor: pointer;
	transition: background 0.3s;
}

#sidebar ul li:hover, #sidebar ul li.active {
	background: #0d6efd;
}

#sidebar ul li i {
	margin-right: 10px;
	font-size: 1.2rem;
	vertical-align: middle;
}

/* Content styles */
#content {
	margin-left: 250px;
	padding: 2rem;
	width: 100%;
	min-height: 100vh;
}

/* Navbar */
.navbar-custom {
	background-color: #fff;
	box-shadow: 0 2px 4px rgb(0 0 0/ 0.1);
	padding: 0.5rem 1rem;
	margin-bottom: 2rem;
	border-radius: 0.5rem;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

.navbar-custom .user-info {
	display: flex;
	align-items: center;
	gap: 0.75rem;
	font-weight: 600;
	color: #333;
}

.navbar-custom .user-info i {
	font-size: 1.3rem;
	color: #0d6efd;
}

.navbar-custom .btn-logout {
	margin-left: 1rem;
}

/* Dashboard welcome note */
.welcome-note {
	font-size: 1.5rem;
	font-weight: 600;
	margin-bottom: 2rem;
	color: #212529;
}

/* Cards */
.dashboard-card {
	cursor: pointer;
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	border-radius: 0.75rem;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	background-color: #fff;
	padding: 2rem;
	text-align: center;
	color: #0d6efd;
	user-select: none;
	text-decoration: none;
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 1rem;
}

.dashboard-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
	color: #0b5ed7;
	text-decoration: none;
}

.dashboard-card i {
	font-size: 4rem;
}

.dashboard-card h4 {
	font-weight: 700;
	font-size: 1.5rem;
	margin: 0;
}

.dashboard-card p {
	font-size: 1rem;
	margin: 0;
	color: #555;
}
.welcome-note {
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}


/* Responsive */
@media ( max-width : 768px) {
	#sidebar {
		position: relative;
		height: auto;
		max-width: 100%;
	}
	#content {
		margin-left: 0;
		padding: 1rem;
	}
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<nav id="sidebar">
		<div class="sidebar-header">AGENT DASHBOARD</div>
		<ul class="components">
			<li class="active"><a href="agentDash.jsp"
				class="text-reset text-decoration-none"><i
					class="bi bi-speedometer2"></i> Dashboard</a></li>
			<li><a href="agentTicketList"
				class="text-reset text-decoration-none"><i
					class="bi bi-chat-dots"></i> Manage Tickets</a></li>
			<li><a href="agentProfile"
				class="text-reset text-decoration-none"><i
					class="bi bi-person-lines-fill"></i> My Profile</a></li>
			<li><i class="bi bi-box-arrow-right"></i> <a href="logout"
				style="color: inherit; text-decoration: none;">Logout</a></li>
		</ul>
	</nav>

	<!-- Page Content -->
	<div id="content">
		<div class="navbar-custom">
			<div class="user-info">
				<i class="bi bi-person-circle"></i> <span>Welcome, <%=fname%></span>
				<a href="logout" class="btn btn-outline-danger btn-sm btn-logout">Logout</a>
			</div>
		</div>

		<!-- Welcome Note -->
		<div
			class="welcome-note p-4 mb-5 rounded shadow-sm bg-white text-center">
			<h2 class="mb-3 fw-bold text-primary">
				Hello,
				<%=fname%>!
			</h2>
			<p class="lead text-secondary mb-0">What would you like to do
				today?</p>
		</div>

		<!-- Dashboard Cards -->
		<div class="row g-4">
			<div class="col-md-6">
				<a href="agentTicketList" class="dashboard-card"> <i
					class="bi bi-chat-dots"></i>
					<h4>Manage Tickets</h4>
					<p>View and respond to your assigned tickets.</p>
				</a>
			</div>
			<div class="col-md-6">
				<a href="agentProfile" class="dashboard-card"> <i
					class="bi bi-person-lines-fill"></i>
					<h4>Manage Profile</h4>
					<p>Update your personal information and settings.</p>
				</a>
			</div>
		</div>

	</div>

	<!-- Bootstrap 5 JS Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
