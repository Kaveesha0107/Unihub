<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equals("admin")) {
	response.sendRedirect("adminLogin.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Admin Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="./CSS/adminDash.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

	<!-- Sidebar -->
	<nav id="sidebar" class="bg-dark">
		<div class="p-4">
			<h3 class="text-white mb-4">UniHub Admin</h3>
			<ul class="nav flex-column">
				<li class="nav-item"><a href="adminDash"
					class="nav-link active"><i class="fas fa-tachometer-alt"></i>
						Dashboard</a></li>
				<li class="nav-item"><a href="articleDash" class="nav-link"><i
						class="fas fa-newspaper"></i> Articles</a></li>
				<li class="nav-item"><a href="userManagementDash"
					class="nav-link"><i class="fas fa-users"></i> Users</a></li>
				<li class="nav-item"><a href="allReviews" class="nav-link"><i
						class="fas fa-comments"></i> Reviews</a></li>
				<li class="nav-item"><a href="uniAgentManagementDash" class="nav-link"><i
						class="fas fa-user-tie"></i> University Agents</a></li>
				<li class="nav-item"><a href="contactUsManagementDash" class="nav-link"><i
						class="fas fa-headset"></i> Contact - Us Requests</a></li>
				<li class="nav-item"><a href="logout" class="nav-link"><i
						class="fas fa-sign-out-alt"></i> Logout</a></li>
			</ul>
		</div>
	</nav>


	<!-- Page Content -->
	<div id="content">
		<!-- Top Navbar -->
		<nav class="navbar d-flex justify-content-between align-items-center">
			<button id="sidebarCollapse" title="Toggle Sidebar">
				<i class="fas fa-bars"></i>
			</button>
			<div class="d-flex align-items-center">
				<div class="dropdown">
					<a href="#"
						class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle"
						id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
						<img src="https://i.pravatar.cc/40" alt="User"
						class="rounded-circle me-2" width="40" height="40" /> <strong>Admin</strong>
					</a>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="userDropdown">
						<li><a class="dropdown-item" href="articleDash">Article Management</a></li>
						<li><a class="dropdown-item" href="userManagementDash">User Management</a></li>
						<li><a class="dropdown-item" href="uniAgentManagementDash">University Agent
								Management</a></li>
						<li><hr class="dropdown-divider" /></li>
						<li><a class="dropdown-item" href="logout">Logout</a></li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- Dashboard Content -->
		<div class="container-fluid mt-4">
			<div class="row g-4">
				<div class="col-md-6 col-lg-3">
					<a href="articleDash" class="text-decoration-none">
						<div class="card p-4 text-center">
							<i class="fas fa-newspaper stat-icon"></i>
							<div class="stat-number">
								<%=request.getAttribute("articleCount") != null ? request.getAttribute("articleCount") : "0"%>
							</div>
							<div class="stat-label">Articles</div>
						</div>
					</a>
				</div>
				<div class="col-md-6 col-lg-3">
					<a href="userManagementDash" class="text-decoration-none">
						<div class="card p-4 text-center">
							<i class="fas fa-users stat-icon"></i>
							<div class="stat-number">
								<%=request.getAttribute("userCount") != null ? request.getAttribute("userCount") : "0"%>
							</div>
							<div class="stat-label">Users</div>
						</div>
					</a>
				</div>
				<div class="col-md-6 col-lg-3">
					<a href="allReviews" class="text-decoration-none">
						<div class="card p-4 text-center">
							<i class="fas fa-comments stat-icon"></i>
							<div class="stat-number">
								<%=request.getAttribute("reviewCount") != null ? request.getAttribute("reviewCount") : "0"%>
							</div>
							<div class="stat-label">Reviews</div>
						</div>
					</a>
				</div>
				<div class="col-md-6 col-lg-3">
					<a href="uniAgentManagementDash" class="text-decoration-none">
						<div class="card p-4 text-center">
							<i class="fas fa-university stat-icon"></i>
							<div class="stat-number">
								<%=request.getAttribute("uniCount") != null ? request.getAttribute("uniCount") : "0"%>
							</div>
							<div class="stat-label">Registered Universities</div>
						</div>
					</a>
				</div>
			</div>
		</div>




		<!-- Example Table -->
		<div class="mt-5 text-center">
			<h4 class="mb-3">Support Ticket Status Overview</h4>
			<div style="max-width: 600px; margin: 0 auto;">
				<canvas id="ticketStatusChart" style="width: 100%; height: 300px;"></canvas>
			</div>
		</div>


	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const toggleBtn = document.getElementById('sidebarCollapse');

    toggleBtn.addEventListener('click', () => {
      sidebar.classList.toggle('collapsed');
      content.classList.toggle('fullwidth');
    });
  </script>
	<script>
  const openCount = <%=request.getAttribute("openTicketCount")%>;
  const inProgressCount = <%=request.getAttribute("inProgressTicketCount")%>;
  const resolvedCount = <%=request.getAttribute("resolvedTicketCount")%>;

  const ctx = document.getElementById('ticketStatusChart').getContext('2d');
  const ticketStatusChart = new Chart(ctx, {
    type: 'pie',
    data: {
      labels: ['Open', 'In Progress', 'Resolved'],
      datasets: [{
        label: 'Tickets',
        data: [openCount, inProgressCount, resolvedCount],
        backgroundColor: [
          'rgba(54, 162, 235, 0.8)',   // Open - Blue
          'rgba(255, 206, 86, 0.8)',   // In Progress - Yellow
          'rgba(75, 192, 192, 0.8)'    // Resolved - Green
        ],
        borderColor: [
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: {
          position: 'bottom',
        }
      }
    }
  });
</script>

</body>
</html>
