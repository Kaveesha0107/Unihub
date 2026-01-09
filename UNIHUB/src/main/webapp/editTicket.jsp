<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Edit Ticket - UniHub</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
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
  </style>
</head>
<body>

<!-- Header / Navbar -->
	<%@ include file="loggedUserHeader.jsp"%>

<!-- Main Content -->
<main class="container mt-5 mb-5">
  <h2 class="mb-4">Edit Ticket</h2>

  <!-- Show error message if any -->
  <c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
  </c:if>

  <c:if test="${not empty ticket}">
    <c:choose>
      <c:when test="${ticket.status == 'Open'}">
        <form action="editTicket" method="post" novalidate>
          <input type="hidden" name=userId value="${sessionScope.userID}">
          <input type="hidden" name="ticketId" value="${ticket.ticketId}" />

          <div class="mb-3">
            <label for="subject" class="form-label">Subject <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="subject" name="subject" value="${ticket.subject}" required />
            <div class="invalid-feedback">Subject is required.</div>
          </div>

          <div class="mb-3">
            <label for="message" class="form-label">Description <span class="text-danger">*</span></label>
            <textarea class="form-control" id="message" name="message" rows="5" required>${ticket.message}</textarea>
            <div class="invalid-feedback">Description is required.</div>
          </div>

          <div class="mb-3">
            <label for="category" class="form-label">Category <span class="text-danger">*</span></label>
            <select class="form-select" id="category" name="category" required>
              <option value="" disabled>Select category</option>
              <option value="Admissions" ${ticket.category == 'Admissions' ? 'selected' : ''}>Admissions</option>
              <option value="Exams" ${ticket.category == 'Exams' ? 'selected' : ''}>Exams</option>
              <option value="Scholarships" ${ticket.category == 'Scholarships' ? 'selected' : ''}>Scholarships</option>
              <option value="Course Registration" ${ticket.category == 'Course Registration' ? 'selected' : ''}>Course Registration</option>
              <option value="Other" ${ticket.category == 'Other' ? 'selected' : ''}>Other</option>
            </select>
            <div class="invalid-feedback">Please select a category.</div>
          </div>

          <div class="mb-3">
            <label for="department" class="form-label">Department <span class="text-danger">*</span></label>
            <select class="form-select" id="department" name="department" required>
              <option value="" disabled>Select department</option>
              <option value="IT" ${ticket.department == 'IT' ? 'selected' : ''}>IT</option>
              <option value="Engineering" ${ticket.department == 'Engineering' ? 'selected' : ''}>Engineering</option>
              <option value="Business" ${ticket.department == 'Business' ? 'selected' : ''}>Business</option>
              <option value="Technology" ${ticket.department == 'Technology' ? 'selected' : ''}>Technology</option>
              <option value="Art" ${ticket.department == 'Art' ? 'selected' : ''}>Art</option>
              <option value="Other" ${ticket.department == 'Other' ? 'selected' : ''}>Other</option>
            </select>
            <div class="invalid-feedback">Please select a department.</div>
          </div>

          <!-- University Dropdown -->
          <div class="mb-3">
            <label for="university" class="form-label">University <span class="text-danger">*</span></label>
            <select class="form-select" id="university" name="universityId" required>
              <option value="" disabled>Select university</option>
              <c:forEach var="uni" items="${unis}">
                <option value="${uni.universityId}" 
                  <c:if test="${uni.universityId == ticket.universityId}">selected</c:if>>
                  ${uni.name}
                </option>
              </c:forEach>
            </select>
            <div class="invalid-feedback">Please select a university.</div>
          </div>

          <div class="d-flex justify-content-between">
            <a href="userTicketList" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Update Ticket</button>
          </div>
        </form>
      </c:when>

      <c:otherwise>
        <div class="alert alert-warning">
          This ticket cannot be edited because its status is "<strong>${ticket.status}</strong>".
        </div>
        <a href="userTicketList" class="btn btn-secondary">Back to Tickets</a>
      </c:otherwise>
    </c:choose>
  </c:if>

</main>

<!-- Footer -->
	<%@ include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Bootstrap 5 client-side validation
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
