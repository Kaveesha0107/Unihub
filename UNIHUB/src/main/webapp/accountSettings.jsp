<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equals("user")) {
	response.sendRedirect("home.jsp"); // redirect if not logged in as user
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>UniHub | Account Settings</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet" />
<style>
body {
	background: linear-gradient(to right, #eef2f3, #8e9eab);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
}

.card-hover:hover {
	transform: scale(1.02);
	transition: 0.3s ease;
}

.profile-label {
	font-weight: 600;
	color: #495057;
}

.profile-value {
	color: #212529;
	word-wrap: break-word;
}

.profile-image, .profile-icon {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	border: 3px solid #0d6efd;
	object-fit: cover;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 6rem;
	user-select: none;
}
/* Black/white/gray icon styling */
.profile-icon {
	background-color: #f8f9fa;
	color: #6c757d; /* Bootstrap's gray-600 */
	border-color: #6c757d;
}

.bio-text {
	font-style: italic;
	color: #6c757d;
	max-width: 400px;
	text-align: center;
	margin-top: 0.3rem;
	user-select: text;
	white-space: pre-wrap; /* preserve line breaks */
}

.btn-group-custom>* {
	min-width: 180px;
}

@media ( max-width : 576px) {
	.btn-group-custom {
		flex-direction: column;
		gap: 0.75rem;
	}
	.btn-group-custom>* {
		min-width: 100%;
	}
}
</style>
</head>
<body>

	<!-- Navbar -->
	<%@ include file="loggedUserHeader.jsp"%>

	<!-- Main Content -->
	<main class="container py-5">
		<div class="text-center mb-5">
			<h2 class="fw-bold text-dark">Your Profile</h2>
			<p class="text-muted">Manage your account details below.</p>
		</div>

		<div class="card card-hover shadow-sm mx-auto p-4"
			style="max-width: 700px;">
			<div class="d-flex flex-column align-items-center mb-4">
				<c:choose>
					<c:when test="${not empty user.base64Image}">
						<img src="data:image/jpeg;base64,${user.base64Image}"
							alt="Profile Image" class="profile-image mb-3" />
					</c:when>
					<c:otherwise>
						<div class="profile-icon mb-3">
							<i class="bi bi-person-circle"></i>
						</div>
					</c:otherwise>
				</c:choose>
				<h4 class="fw-semibold mb-1">${user.firstname}${user.lastname}</h4>
				<c:if test="${not empty user.bio}">
					<p class="bio-text">${user.bio}</p>
				</c:if>
			</div>

			<div class="row mb-3">
				<div class="col-4 profile-label">First Name:</div>
				<div class="col-8 profile-value">${user.firstname}</div>
			</div>
			<div class="row mb-3">
				<div class="col-4 profile-label">Last Name:</div>
				<div class="col-8 profile-value">${user.lastname}</div>
			</div>
			<div class="row mb-3">
				<div class="col-4 profile-label">Email:</div>
				<div class="col-8 profile-value">${user.email}</div>
			</div>
			<div class="row mb-3">
				<div class="col-4 profile-label">Phone:</div>
				<div class="col-8 profile-value">${user.phone}</div>
			</div>

			<div
				class="d-flex justify-content-center gap-3 btn-group-custom mt-4 flex-wrap">
				<!-- Edit button passes userId as parameter -->
				<a href="editAccount?userId=${user.userId}"
					class="btn btn-primary btn-lg"> <i
					class="bi bi-pencil-square me-2"></i> Edit My Account Details
				</a>

				<!-- Delete button posts userId to delete servlet with confirmation -->
				<form action="deleteAccount" method="post"
					onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone!');"
					class="m-0">
					<input type="hidden" name="userId" value="${user.userId}" />
					<button type="submit" class="btn btn-danger btn-lg">
						<i class="bi bi-trash me-2"></i> Delete My Account
					</button>
				</form>
			</div>
		</div>
	</main>

	<!-- Footer -->
	<%@ include file="footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
