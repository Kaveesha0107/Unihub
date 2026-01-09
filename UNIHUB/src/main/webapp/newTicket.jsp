<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equals("user")) {
	response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Submit Ticket</title>

<!-- Bootstrap 5 CSS CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<style>
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin:0;
	padding:0;
}

.ticket-form {
	background: white;
	padding: 2rem;
	border-radius: 0.5rem;
	max-width: 700px;
	margin: auto;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

h2 {
	color: #0d6efd;
	margin-bottom: 1.5rem;
	text-align: center;
}
</style>
</head>
<body>

	<c:choose>
		<c:when
			test="${not empty sessionScope.role and sessionScope.role == 'user'}">
			<jsp:include page="loggedUserHeader.jsp" />
		</c:when>
		<c:otherwise>
			<jsp:include page="header.jsp" />
		</c:otherwise>
	</c:choose>

	<div class="ticket-form mt-5 mb-5">
		<h2>Submit a Support Ticket</h2>
		<form action="newTicket" method="post" novalidate>

			<!-- Hidden user ID from session -->
			<input type="hidden" id="hiddenUserId" name="userId" value="${sessionScope.userID}" />

			<!-- Subject -->
			<div class="mb-3">
  				<label for="subject" class="form-label">Subject <span class="text-danger">*</span></label>
  				<input type="text" class="form-control" id="subject" name="subject" placeholder="Enter ticket subject" required />
  				<div class="invalid-feedback">Subject must be between 5 and 250 characters.</div>
			</div>

			<!-- Description -->
			<div class="mb-3">
				<label for="description" class="form-label">Description <span
					class="text-danger">*</span></label>
				<textarea class="form-control" id="description" name="description"
					rows="5" placeholder="Describe your issue in detail" required></textarea>
				<div class="invalid-feedback">Description is required.</div>
			</div>

			<!-- Category -->
			<div class="mb-3">
				<label for="category" class="form-label">Category <span
					class="text-danger">*</span></label> <select class="form-select"
					id="category" name="category" required>
					<option value="" selected disabled>Select category</option>
					<option value="Admissions">Admissions</option>
					<option value="Exams">Exams</option>
					<option value="Scholarships">Scholarships</option>
					<option value="Course Registration">Course Registration</option>
					<option value="Other">Other</option>
				</select>
				<div class="invalid-feedback">Please select a category.</div>
			</div>

			<!-- Department -->
			<div class="mb-3">
				<label for="department" class="form-label">Department <span
					class="text-danger">*</span></label> <select class="form-select"
					id="department" name="department" required>
					<option value="" selected disabled>Select department</option>
					<option value="IT">IT</option>
					<option value="Engineering">Engineering</option>
					<option value="Business">Business</option>
					<option value="Technology">Technology</option>
					<option value="Art">Art</option>
					<option value="Other">Other</option>
				</select>
				<div class="invalid-feedback">Please select a department.</div>
			</div>

			<!-- University -->
			<div class="mb-4">
				<label for="university" class="form-label">University <span
					class="text-danger">*</span></label> <select class="form-select"
					id="university" name="university" required>
					<option value="" selected disabled>Select university</option>
					<c:forEach var="uni" items="${unis}">
						<option value="${uni.universityId}">${uni.name}</option>
					</c:forEach>
				</select>
				<div class="invalid-feedback">Please select a university.</div>
			</div>

			<div class="d-grid">
				<button type="submit" class="btn btn-primary btn-lg">Submit
					Ticket</button>
			</div>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
	  (() => {
	    'use strict';

	    const form = document.querySelector("form");

	    form.addEventListener('submit', event => {
	      // Reset previous validation states
	      const subjectInput = document.getElementById("subject");
	      subjectInput.classList.remove("is-invalid");

	      // Bootstrap native validation
	      if (!form.checkValidity()) {
	        event.preventDefault();
	        event.stopPropagation();
	      }

	      // Custom validation: userId hidden field
	      const hiddenUserId = document.getElementById("hiddenUserId");
	      const userIdValue = hiddenUserId ? hiddenUserId.value.trim() : null;
	      if (!userIdValue || userIdValue === "0") {
	        event.preventDefault();
	        event.stopPropagation();
	        alert("Invalid user ID passed. Please log out and log in again.");
	      }

	      // Custom validation: subject length between 5 and 250
	      const subjectValue = subjectInput.value.trim();

	      if (subjectValue.length < 5 || subjectValue.length > 250) {
	        event.preventDefault();
	        event.stopPropagation();
	        subjectInput.classList.add("is-invalid");
	      }

	      // Add Bootstrap validation styles
	      form.classList.add('was-validated');
	    });

	    // Optional live validation feedback for subject input
	    document.getElementById("subject").addEventListener("input", function() {
	      if (this.value.trim().length >= 5 && this.value.trim().length <= 250) {
	        this.classList.remove("is-invalid");
	      }
	    });
	  })();
	</script>

  	<%@ include file="footer.jsp"%>
</body>
</html>
