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
<title>UniHub | Edit Account</title>
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
	cursor: pointer;
}
/* Black/white/gray icon styling */
.profile-icon {
	background-color: #f8f9fa;
	color: #6c757d; /* Bootstrap's gray-600 */
	border-color: #6c757d;
}

.form-label {
	font-weight: 600;
}

.btn-group-custom>* {
	min-width: 140px;
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
<script>
	// Preview uploaded profile image and replace icon if any
	function previewImage(event) {
		const input = event.target;
		if (input.files && input.files[0]) {
			const reader = new FileReader();
			reader.onload = function(e) {
				const preview = document.getElementById('profileImagePreview');
				if (preview.tagName.toLowerCase() === 'img') {
					preview.src = e.target.result;
				} else {
					// Replace icon div with img element
					const img = document.createElement('img');
					img.id = 'profileImagePreview';
					img.className = 'profile-image';
					img.alt = 'Profile Image';
					img.src = e.target.result;
					preview.parentNode.replaceChild(img, preview);
				}
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	// Toggle password change section visibility and button icon
	function togglePasswordSection() {
		const section = document.getElementById('passwordSection');
		const btnIcon = document.getElementById('togglePasswordIcon');
		if (section.style.display === 'none' || section.style.display === '') {
			section.style.display = 'block';
			btnIcon.classList.remove('bi-caret-down-fill');
			btnIcon.classList.add('bi-caret-up-fill');
		} else {
			section.style.display = 'none';
			btnIcon.classList.remove('bi-caret-up-fill');
			btnIcon.classList.add('bi-caret-down-fill');
			// Clear password fields on hide
			document.getElementById('newPassword').value = '';
			document.getElementById('confirmPassword').value = '';
		}
	}

	// Validate password match on submit if password section visible
	function validateForm() {
		const section = document.getElementById('passwordSection');
		if (section.style.display === 'block') {
			const newPassword = document.getElementById('newPassword').value;
			const confirmPassword = document.getElementById('confirmPassword').value;
			if (newPassword !== confirmPassword) {
				alert('New Password and Confirm Password do not match!');
				return false;
			}
		}
		return true;
	}
</script>
</head>
<body>

	<!-- Navbar -->
	<%@ include file="loggedUserHeader.jsp"%>

	<!-- Main Content -->
	<main class="container py-5">
		<h2 class="mb-4 fw-bold text-center text-dark">Edit Your Profile</h2>

		<div class="card card-hover shadow-sm mx-auto p-4"
			style="max-width: 700px;">
			<form action="editAccount" method="post"
				enctype="multipart/form-data" novalidate
				onsubmit="return validateForm()">
				<!-- Hidden userId -->
				<input type="hidden" name="userId" value="${user.userId}" />

				<div class="d-flex flex-column align-items-center mb-4">
					<label for="profileImage" class="mb-2" style="cursor: pointer;"
						title="Click to change profile image"> <c:choose>
							<c:when test="${not empty user.base64Image}">
								<img id="profileImagePreview"
									src="data:image/jpeg;base64,${user.base64Image}"
									alt="Profile Image" class="profile-image" />
							</c:when>
							<c:otherwise>
								<div id="profileImagePreview" class="profile-icon">
									<i class="bi bi-person-circle"></i>
								</div>
							</c:otherwise>
						</c:choose>
					</label> <input type="file" id="profileImage" name="profileImage"
						accept="image/*" class="d-none" onchange="previewImage(event)" />
					<div class="text-center mt-2 text-primary fw-semibold">Click
						image to change profile picture</div>
				</div>

				<div class="mb-3">
					<label for="firstname" class="form-label">First Name <span
						class="text-danger">*</span></label> <input type="text"
						class="form-control" id="firstname" name="firstname" required
						maxlength="50" value="${user.firstname}" />
				</div>

				<div class="mb-3">
					<label for="lastname" class="form-label">Last Name <span
						class="text-danger">*</span></label> <input type="text"
						class="form-control" id="lastname" name="lastname" required
						maxlength="50" value="${user.lastname}" />
				</div>

				<div class="mb-3">
					<label for="email" class="form-label">Email <span
						class="text-danger">*</span></label> <input type="email"
						class="form-control" id="email" name="email" required
						maxlength="100" value="${user.email}" />
				</div>

				<div class="mb-3">
					<label for="phone" class="form-label">Phone</label> <input
						type="tel" class="form-control" id="phone" name="phone"
						maxlength="20" value="${user.phone}" />
				</div>

				<div class="mb-3">
					<label for="bio" class="form-label">Bio</label>
					<textarea class="form-control" id="bio" name="bio" rows="4"
						maxlength="500">${user.bio}</textarea>
				</div>

				<hr />

				<button type="button"
					class="btn btn-outline-primary mb-3 d-flex align-items-center"
					onclick="togglePasswordSection()" aria-expanded="false"
					aria-controls="passwordSection">
					<i id="togglePasswordIcon" class="bi bi-caret-down-fill me-2"></i>
					Change Password
				</button>

				<div id="passwordSection" style="display: none;">
					<div class="mb-3">
						<label for="newPassword" class="form-label">New Password</label> <input
							type="password" class="form-control" id="newPassword"
							name="newPassword" minlength="6" maxlength="100"
							placeholder="Leave blank to keep current password" />
					</div>

					<div class="mb-3">
						<label for="confirmPassword" class="form-label">Confirm
							New Password</label> <input type="password" class="form-control"
							id="confirmPassword" name="confirmPassword" minlength="6"
							maxlength="100" placeholder="Confirm new password" />
					</div>
				</div>

				<div
					class="d-flex justify-content-center gap-3 btn-group-custom flex-wrap mt-4">
					<button type="submit" class="btn btn-success btn-lg">
						<i class="bi bi-check-circle me-2"></i> Save Changes
					</button>
					<a href="accountSettings" class="btn btn-secondary btn-lg"> <i
						class="bi bi-x-circle me-2"></i> Cancel
					</a>
				</div>
			</form>
		</div>
	</main>

	<!-- Footer -->
	<%@ include file="footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
