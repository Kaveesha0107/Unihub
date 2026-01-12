<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>UniHub | User Dashboard - Your Tickets</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet" />
<style>
body {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.card-hover:hover {
	transform: scale(1.02);
	transition: 0.3s ease;
}

main {
	flex: 1;
}
</style>
</head>
<body>
	<%@ include file="loggedUserHeader.jsp"%>
	<!-- Main Content -->
	<main class="container mt-5 mb-5">
		<div class="text-center mb-4">
			<h2 class="fw-bold text-dark">
				Welcome to Ticket List
				<%=session.getAttribute("username")%></h2>
			<p class="text-muted">Manage your tickets & responses.</p>
		</div>

		<c:if test="${empty ticketList}">
			<div class="alert alert-info">You have no tickets yet.</div>
		</c:if>

		<c:if test="${not empty ticketList}">
			<table class="table table-hover align-middle">
				<thead class="table-dark">
					<tr>
						<th>Ticket ID</th>
						<th>Subject</th>
						<th>Status</th>
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
                                    <c:when test="${ticket.status == 'Open'}">bg-success</c:when>
                                    <c:when test="${ticket.status == 'Resolved'}">bg-primary</c:when>
                                    <c:when test="${ticket.status == 'Closed'}">bg-secondary</c:when>
                                    <c:otherwise>bg-info</c:otherwise>
                                </c:choose>">
									${ticket.status} </span></td>
							<td>
								<!-- View button --> <a
								href="viewTicket?ticketId=${ticket.ticketId}"
								class="btn btn-sm btn-info me-1" title="View Ticket"> <i
									class="bi bi-eye"></i> View
							</a> <!-- Edit button --> <a
								href="editTicket?ticketId=${ticket.ticketId}"
								class="btn btn-sm btn-warning me-1" title="Edit Ticket"> <i
									class="bi bi-pencil-square"></i> Edit
							</a> <!-- Delete button -->
								<form action="deleteTicket" method="post" class="d-inline"
									onsubmit="return confirm('Are you sure you want to delete this ticket?');">
									<input type="hidden" name="ticketId" value="${ticket.ticketId}" />
									<button type="submit" class="btn btn-sm btn-danger"
										title="Delete Ticket">
										<i class="bi bi-trash"></i> Delete
									</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</main>

	<!-- Footer -->
	<%@ include file="footer.jsp"%>

	<!-- Bootstrap JS Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
