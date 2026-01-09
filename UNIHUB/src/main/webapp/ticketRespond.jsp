<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
<title>Respond to Ticket - UniHub</title>

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

/* Badge styling */
.badge-status {
	font-size: 0.9em;
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

		<div class="container-fluid">
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-danger">${errorMessage}</div>
			</c:if>

			<c:choose>
				<c:when test="${not empty ticket}">
					<!-- Back Button -->
					<a href="agentTicketList" class="btn btn-secondary mb-4"> <i
						class="bi bi-arrow-left"></i> Back to Tickets
					</a>

					<!-- Ticket Details -->
					<div class="card mb-4 shadow">
						<div class="card-header bg-primary text-white">
							<h4 class="mb-0">Ticket #${ticket.ticketId}</h4>
						</div>
						<div class="card-body">
							<dl class="row">
								<dt class="col-sm-3">Subject:</dt>
								<dd class="col-sm-9">${ticket.subject}</dd>

								<dt class="col-sm-3">Description:</dt>
								<dd class="col-sm-9">${ticket.message}</dd>

								<dt class="col-sm-3">Category:</dt>
								<dd class="col-sm-9">${ticket.category}</dd>

								<dt class="col-sm-3">Department:</dt>
								<dd class="col-sm-9">${ticket.department}</dd>

								<dt class="col-sm-3">Status:</dt>
								<dd class="col-sm-9">
									<span
										class="badge 
                    <c:choose>
                      <c:when test="${ticket.status == 'Open'}">bg-success</c:when>
                      <c:when test="${ticket.status == 'Resolved'}">bg-primary</c:when>
                      <c:otherwise>bg-secondary</c:otherwise>
                    </c:choose> badge-status">
										${ticket.status} </span>
								</dd>
							</dl>
						</div>
					</div>

					<!-- Response Form -->
					<div class="card shadow">
						<div class="card-header bg-success text-white">
							<h4 class="mb-0">Add Response</h4>
						</div>
						<div class="card-body">
							<form action="respondTicket" method="post"
								enctype="multipart/form-data">
								<input type="hidden" name="ticketId" value="${ticket.ticketId}"
									id="hiddenTicketId">

								<div class="mb-3">
  									<label for="responseTitle" class="form-label">Response Title <span class="text-danger">*</span></label>
  									<input type="text" class="form-control" id="responseTitle" name="responseTitle" maxlength="250" required>
								</div>

								<div class="mb-3">
									<label for="responseDescription" class="form-label">Response
										Details <span class="text-danger">*</span>
									</label>
									<textarea class="form-control" id="responseDescription"
										name="responseDescription" rows="5" required></textarea>
								</div>

								<div class="mb-3">
									<label for="nextSteps" class="form-label">Next Steps
										for User</label>
									<textarea class="form-control" id="nextSteps" name="nextSteps"
										rows="3" placeholder="Instructions or actions for the user"></textarea>
								</div>

								<div class="mb-4">
									<label for="attachments" class="form-label">Attachments
										(PDF, Images, Docs, Videos)</label> <input class="form-control"
										type="file" id="attachments" name="attachments" multiple
										accept=".pdf,.doc,.docx,.jpg,.jpeg,.png,.gif,.mp4,.mov,.avi">
									<div class="form-text">Max file size: 25MB per file</div>
									<div id="fileSizeError" class="alert alert-danger mt-2 d-none"
										role="alert"></div>
								</div>

								<div class="d-flex justify-content-end gap-2">
									<button type="reset" class="btn btn-secondary">Clear</button>
									<button type="submit" class="btn btn-success">
										<i class="bi bi-send-check"></i> Submit Response
									</button>
								</div>
							</form>
						</div>
					</div>
				</c:when>

				<c:otherwise>
					<div class="alert alert-danger">Ticket not found or you don't
						have permission to view it.</div>
					<a href="agentTickets" class="btn btn-secondary"> <i
						class="bi bi-arrow-left"></i> Back to Tickets
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- Bootstrap 5 JS Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const form = document.querySelector("form[action='respondTicket']");
	    const hiddenTId = document.getElementById("hiddenTicketId");

	    // Create a container for error messages just above the form
	    const container = document.createElement("div");
	    container.id = "formErrorContainer";
	    form.parentNode.insertBefore(container, form);

	    form.addEventListener("submit", function (event) {
	    const ticketId = hiddenTId.value.trim();

	    // Remove any existing error alert
	    container.innerHTML = "";

        if (!ticketId || ticketId === "0") {
	            event.preventDefault();

	            // Create Bootstrap alert div
	            const alertDiv = document.createElement("div");
	            alertDiv.className = "alert alert-danger";
	            alertDiv.role = "alert";
	            alertDiv.textContent = "Invalid ticket ID passed.";

	            container.appendChild(alertDiv);

	            // Optionally, focus on the hidden input or form
	            hiddenTId.focus();
	        }
	    });
	});
	
	
	 const attachmentsInput = document.getElementById('attachments');
	  const errorDiv = document.getElementById('fileSizeError');
	  const maxFileSize = 25 * 1024 * 1024; // 25MB in bytes

	  attachmentsInput.addEventListener('change', function() {
	    errorDiv.classList.add('d-none');
	    errorDiv.textContent = '';

	    const files = attachmentsInput.files;
	    for (let i = 0; i < files.length; i++) {
	      if (files[i].size > maxFileSize) {
	        errorDiv.textContent = `File "${files[i].name}" exceeds the maximum size of 25MB. Please select smaller files.`;
	        errorDiv.classList.remove('d-none');
	        attachmentsInput.value = ''; // Clear the input
	        break;
	      }
	    }
	  });
	</script>



</body>
</html>
