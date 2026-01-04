<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("agent")) {
        response.sendRedirect("agentlogin.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Agent Ticket Management - UniHub</title>

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet" />

<!-- DataTables CSS -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />

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
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	overflow-y: auto;
	transition: all 0.3s;
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

#sidebar ul li a {
	color: #adb5bd;
	text-decoration: none;
	display: block;
}

#sidebar ul li.active>a, #sidebar ul li a:hover {
	color: white;
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

/* Badge colors */
.badge-status-open {
	background-color: #198754; /* green */
}

.badge-status-inprogress {
	background-color: #0dcaf0; /* cyan */
	color: #000;
}

.badge-status-resolved {
	background-color: #0d6efd; /* blue */
}

.badge-status-closed {
	background-color: #6c757d; /* gray */
}

/* Custom filter container */
#customFilters {
	margin-bottom: 1rem;
	display: flex;
	gap: 1rem;
	flex-wrap: wrap;
	align-items: center;
}

#customFilters label {
	font-weight: 600;
	margin-right: 0.5rem;
}

#customFilters select {
	min-width: 180px;
}

/* DataTables default search box & info moved below */
div.dataTables_wrapper div.dataTables_filter, div.dataTables_wrapper div.dataTables_info
	{
	margin-top: 1rem;
}

div.dataTables_wrapper div.dataTables_filter {
	float: none !important;
	text-align: left !important;
}

div.dataTables_wrapper div.dataTables_info {
	float: none !important;
	text-align: left !important;
	margin-top: 0.5rem;
	font-size: 0.9rem;
	color: #666;
}

div.dataTables_wrapper div.dataTables_paginate {
	float: right !important;
	margin-top: 1rem;
}

.table-hover tbody tr:hover {
	background-color: #e9f0ff;
	cursor: pointer;
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
	#customFilters {
		flex-direction: column;
	}
	#customFilters select {
		min-width: 100%;
	}
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<nav id="sidebar">
		<div class="sidebar-header">AGENT DASHBOARD</div>
		<ul class="components">
			<li><a href="agentDash.jsp"
				class="text-reset text-decoration-none"><i
					class="bi bi-speedometer2"></i> Dashboard</a></li>
			<li class="active"><a href="agentTicketList"
				class="text-reset text-decoration-none"><i
					class="bi bi-chat-dots"></i> Manage Tickets</a></li>
			<li><a href="agentProfile"
				class="text-reset text-decoration-none"><i
					class="bi bi-person-lines-fill"></i> My Profile</a></li>
			<li><a href="logout" class="text-reset text-decoration-none"
				style="display: flex; align-items: center;"> <i
					class="bi bi-box-arrow-right me-2"></i>  Logout
			</a></li>

		</ul>
	</nav>

	<!-- Page Content -->
	<div id="content">
		<div class="navbar-custom">
			<div class="user-info">
				<i class="bi bi-person-circle"></i> <span>Welcome, <%=session.getAttribute("fname")%></span>
				<a href="logout" class="btn btn-outline-danger btn-sm btn-logout">Logout</a>
			</div>
		</div>

		<main>
			<h2>Manage Tickets</h2>

			<!-- Custom Filters -->
			<div id="customFilters">
				<div>
					<label for="statusFilter" class="form-label mb-0 me-2 fw-semibold">Filter
						by Status:</label> <select id="statusFilter"
						class="form-select form-select-sm">
						<option value="">All Statuses</option>
						<option value="Open">Open</option>
						<option value="In Progress">In Progress</option>
						<option value="Resolved">Resolved</option>
						<option value="Closed">Closed</option>
					</select>
				</div>
				<div>
					<label for="categoryFilter"
						class="form-label mb-0 me-2 fw-semibold">Filter by
						Category:</label> <select id="categoryFilter"
						class="form-select form-select-sm">
						<option value="">All Categories</option>
						<option value="Admissions">Admissions</option>
						<option value="Exams">Exams</option>
						<option value="Scholarships">Scholarships</option>
						<option value="Course Registration">Course Registration</option>
						<option value="Other">Other</option>
					</select>
				</div>
			</div>

			<!-- Tickets Table -->
			<div class="table-responsive ">
				<table id="ticketsTable" class="table table-hover align-middle mt-5">
					<thead class="table-dark mt-5">
						<tr>
							<th>Ticket ID</th>
							<th>Subject</th>
							<th>Status</th>
							<th>Category</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ticket" items="${ticketList}">
							<tr>
								<td>${ticket.ticketId}</td>
								<td>${ticket.subject}</td>
								<td><span
									class="badge 
                    <c:choose>
                      <c:when test="${ticket.status == 'Open'}">badge-status-open</c:when>
                      <c:when test="${ticket.status == 'In Progress'}">badge-status-inprogress</c:when>
                      <c:when test="${ticket.status == 'Resolved'}">badge-status-resolved</c:when>
                      <c:when test="${ticket.status == 'Closed'}">badge-status-closed</c:when>
                      <c:otherwise>bg-info</c:otherwise>
                    </c:choose>">
										${ticket.status} </span></td>
								<td>${ticket.category}</td>
								<td>
									<!-- View button --> <a
									href="viewResponse?ticketId=${ticket.ticketId}"
									class="btn btn-sm btn-info me-1 mt-2" title="View Ticket"> <i
										class="bi bi-eye"></i> View
								</a> <c:choose>
										<c:when test="${ticket.status == 'Open'}">
											<a href="respondTicket?ticketId=${ticket.ticketId}"
												class="btn btn-sm btn-success mt-2" title="Respond to Ticket">
												<i class="bi bi-chat-dots"></i> Respond
											</a>
										</c:when>

										<c:when test="${ticket.status == 'In Progress'}">
											<a href="editResponse?ticketId=${ticket.ticketId}"
												class="btn btn-sm btn-primary me-1 mt-2" title="Edit Ticket">
												<i class="bi bi-pencil-square"></i> Edit
											</a>

											<form action="markResolved" method="post"
												class="d-inline me-1">
												<input type="hidden" name="ticketId"
													value="${ticket.ticketId}" />
												<button type="submit" class="btn btn-sm btn-warning mt-2"
													title="Mark as Resolved"
													onclick="return confirm('Mark this ticket as resolved?');">
													<i class="bi bi-check-circle"></i> Mark as Resolved
												</button>
											</form>

											<a href="deleteResponse?ticketId=${ticket.ticketId}"
												class="btn btn-sm btn-danger mt-2"
												onclick="return confirm('Are you sure you want to delete this ticket response?');"
												title="Delete Response"> <i class="bi bi-trash"></i>
												Delete Response
											</a>
										</c:when>

										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</main>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

	<script>
		$(document).ready(
				function() {
					var table = $('#ticketsTable').DataTable({
						"columnDefs" : [ {
							"orderable" : false,
							"targets" : -1
						} // Disable sorting on Actions column
						],
						"order" : [ [ 2, "asc" ] ], // Default sort by Status column
						"paging" : true,
						"pageLength" : 10,
						"dom" : 'lrtip' // Hide default search box, using custom filters
					});

					// Custom filtering function to filter by Status and Category
					$.fn.dataTable.ext.search.push(function(settings, data,
							dataIndex) {
						var statusFilter = $('#statusFilter').val();
						var categoryFilter = $('#categoryFilter').val();

						// Extract plain text from Status column (which contains badge HTML)
						var statusHtml = data[2];
						var statusText = $('<div>').html(statusHtml).text()
								.trim();

						var categoryText = data[3].trim();

						var statusMatch = statusFilter === ""
								|| statusText === statusFilter;
						var categoryMatch = categoryFilter === ""
								|| categoryText === categoryFilter;

						return statusMatch && categoryMatch;
					});

					// Event listeners for filter dropdowns
					$('#statusFilter, #categoryFilter').on('change',
							function() {
								table.draw();
							});
				});
	</script>

</body>
</html>
