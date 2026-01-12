<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<title>View Response - UniHub</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet" />
<style>
body {
	min-height: 100vh;
	display: flex;
	background: #f0f2f5;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

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

#content {
	margin-left: 250px;
	padding: 2rem;
	width: 100%;
	min-height: 100vh;
}

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

.section-header {
	border-bottom: 3px solid #0d6efd;
	margin-bottom: 1.5rem;
	padding-bottom: 0.3rem;
	color: #0d6efd;
	font-weight: 700;
	letter-spacing: 1px;
	font-size: 1.8rem;
	text-transform: uppercase;
	text-shadow: 1px 1px 2px rgba(13, 110, 253, 0.3);
}

.card {
	box-shadow: 0 8px 20px rgb(0 0 0/ 0.12);
	border-radius: 0.75rem;
	transition: transform 0.25s ease-in-out, box-shadow 0.25s ease-in-out;
}

.card:hover {
	transform: translateY(-8px);
	box-shadow: 0 12px 30px rgb(0 0 0/ 0.18);
}

.badge-category {
	background: #0dcaf0;
	color: #0a9396;
	font-weight: 600;
	font-size: 0.9rem;
	text-transform: uppercase;
	padding: 0.4em 0.8em;
	border-radius: 1rem;
	box-shadow: 0 2px 6px rgba(13, 110, 253, 0.15);
	margin-right: 0.5rem;
}

.badge-status {
	background: #ffc107;
	color: #664d03;
	font-weight: 700;
	font-size: 0.9rem;
	text-transform: uppercase;
	padding: 0.4em 0.8em;
	border-radius: 1rem;
	box-shadow: 0 2px 6px rgba(255, 193, 7, 0.3);
}

.badge-department {
	background: #198754;
	color: #d1e7dd;
	font-weight: 600;
	font-size: 0.9rem;
	text-transform: uppercase;
	padding: 0.4em 0.8em;
	border-radius: 1rem;
	box-shadow: 0 2px 6px rgba(25, 135, 84, 0.3);
	margin-left: 0.5rem;
}

.attachment-list li {
	margin-bottom: 0.6rem;
}

.attachment-list i {
	color: #0d6efd;
	margin-right: 0.6rem;
	font-size: 1.2rem;
}

.btn-respond {
	background: #198754;
	border: none;
	font-weight: 600;
	font-size: 1.15rem;
	padding: 0.75rem 1.5rem;
	border-radius: 2rem;
	box-shadow: 0 6px 12px rgba(25, 135, 84, 0.4);
	transition: background-color 0.3s ease;
}

.btn-respond:hover {
	background: #146c43;
}

.btn-edit {
	background: #0d6efd;
	border: none;
	font-weight: 600;
	font-size: 1.15rem;
	padding: 0.75rem 1.5rem;
	border-radius: 2rem;
	box-shadow: 0 6px 12px rgba(13, 110, 253, 0.4);
	transition: background-color 0.3s ease;
}

.btn-edit:hover {
	background: #0b5ed7;
}

.btn-delete {
	background: #dc3545;
	border: none;
	font-weight: 600;
	font-size: 1.15rem;
	padding: 0.75rem 1.5rem;
	border-radius: 2rem;
	box-shadow: 0 6px 12px rgba(220, 53, 69, 0.4);
	transition: background-color 0.3s ease;
	color: white;
}

.btn-delete:hover {
	background: #b02a37;
	color: white;
}

footer {
	margin-top: 5rem;
	padding: 1rem 0;
	text-align: center;
	color: #6c757d;
	font-size: 0.9rem;
	font-style: italic;
}

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
			<li><a href="agentDash.jsp"
				class="text-reset text-decoration-none"><i
					class="bi bi-speedometer2"></i> Dashboard</a></li>
			<li><a href="agentTicketList"
				class="text-reset text-decoration-none"><i
					class="bi bi-chat-dots"></i> Manage Tickets</a></li>
			<li><a href="agentProfile"
				class="text-reset text-decoration-none"><i
					class="bi bi-person-lines-fill"></i> My Profile</a></li>
			<li><a href="logout" class="text-reset text-decoration-none"
				style="display: flex; align-items: center;"> <i
					class="bi bi-box-arrow-right me-2"></i> Logout
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

		<div class="container my-5" style="max-width: 900px;">
			<!-- Ticket Details -->
			<div class="mb-5">
				<h2 class="section-header">Ticket Details</h2>
				<div class="card p-4 bg-white">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4>Ticket #${ticket.ticketId} - ${ticket.subject}</h4>
						<span class="badge badge-category">${ticket.category}</span>
					</div>
					<p>
						<strong>Description:</strong>
					</p>
					<p class="lead">${ticket.message}</p>
					<div class="d-flex align-items-center mt-4">
						<span class="badge badge-status">${ticket.status}</span> <span
							class="badge badge-department">${ticket.department}</span>
					</div>
				</div>
			</div>

			<!-- Response Details or Respond Button -->
			<c:choose>
				<c:when test="${response == null}">
					<div class="text-center">
						<p class="fs-5 text-muted">No response has been made for this
							ticket yet.</p>
						<a href="respondTicket?ticketId=${ticket.ticketId}"
							class="btn btn-respond btn-lg shadow-sm"> <i
							class="bi bi-chat-dots-fill me-2"></i> Respond Now
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="mb-4">
						<h2 class="section-header">Response Details</h2>
						<div class="card p-4 bg-white">
							<h4 class="fw-bold">${response.title}</h4>
							<p>${response.description}</p>
							<hr />
							<h6 class="fw-semibold">Next Steps for User:</h6>
							<p>${response.nextSteps}</p>

							<c:if test="${not empty response.attachmentPaths}">
								<div class="mt-3">
									<h6>Attachments</h6>
									<ul class="list-unstyled attachment-list">
										<c:forEach var="file"
											items="${fn:split(response.attachmentPaths, ';')}">
											<li><a href="${pageContext.request.contextPath}/${file}"
												target="_blank" rel="noopener noreferrer"
												class="text-decoration-none"> <i class="bi bi-paperclip"></i>
													${file.substring(file.lastIndexOf('/') + 1)}
											</a></li>
										</c:forEach>
									</ul>
								</div>
							</c:if>
							<c:if test="${empty response.attachmentPaths}">
								<p class="text-muted fst-italic mt-3">No attachments
									uploaded.</p>
							</c:if>
						</div>
					</div>

					<c:if test="${ticket.status == 'In Progress'}">
						<div class="text-center mt-3 d-flex justify-content-center gap-3">
							<a href="editResponse?ticketId=${ticket.ticketId}"
								class="btn btn-edit btn-lg shadow-sm"> <i
								class="bi bi-pencil-square me-2"></i> Edit Response
							</a>

							<form action="deleteResponse" method="post"
								onsubmit="return confirm('Are you sure you want to delete this response?');"
								style="display: inline;">
								<input type="hidden" name="responseId"
									value="${response.responseId}" /> <input type="hidden"
									name="ticketId" value="${ticket.ticketId}" />
								<button type="submit" class="btn btn-delete btn-lg shadow-sm">
									<i class="bi bi-trash me-2"></i> Delete Response
								</button>
							</form>
						</div>
					</c:if>
				</c:otherwise>
			</c:choose>

			<div class="text-center mt-5">
				<a href="agentTicketList" class="btn btn-outline-secondary"> <i
					class="bi bi-arrow-left-circle me-2"></i> Back to Tickets
				</a>
			</div>
		</div>

		<footer> &copy; 2025 UniHub Support System </footer>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
