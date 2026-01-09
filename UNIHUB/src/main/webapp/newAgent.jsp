<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Add University Agent - UniHub Admin</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
<!-- Your admin dashboard CSS -->
<link rel="stylesheet" href="./CSS/adminDash.css" />

<style>
  body {
    background-color: #f8f9fa;
  }
  .form-section {
    background: white;
    padding: 2rem;
    border-radius: 0.5rem;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 2rem;
  }
  h2.section-title {
    border-bottom: 2px solid #0d6efd;
    padding-bottom: 0.5rem;
    margin-bottom: 1.5rem;
    color: #0d6efd;
  }
</style>
</head>
<body>

  <!-- Sidebar -->
  <nav id="sidebar" class="bg-dark">
    <div class="p-4">
      <h3 class="text-white mb-4">UniHub Admin</h3>
      <ul class="nav flex-column">
        <li class="nav-item"><a href="adminDash" class="nav-link"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
        <li class="nav-item"><a href="articleDash" class="nav-link"><i class="fas fa-newspaper"></i> Articles</a></li>
        <li class="nav-item"><a href="userManagementDash" class="nav-link"><i class="fas fa-users"></i> Users</a></li>
        <li class="nav-item"><a href="allReviews" class="nav-link"><i class="fas fa-comments"></i> Reviews</a></li>
        <li class="nav-item"><a href="uniAgentManage.jsp" class="nav-link active"><i class="fas fa-user-tie"></i> University Agents</a></li>
        <li class="nav-item"><a href="#" class="nav-link"><i class="fas fa-headset"></i> Contact - Us Requests</a></li>
        <li class="nav-item"><a href="logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
      </ul>
    </div>
  </nav>

  <!-- Main Content -->
  <div id="content" class="p-4">

    <!-- Navbar -->
    <nav class="navbar d-flex justify-content-between align-items-center mb-4">
      <button id="sidebarCollapse" title="Toggle Sidebar" class="btn btn-outline-secondary">
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
            <li><a class="dropdown-item" href="uniAgentManagementDash">University Agent Management</a></li>
            <li><hr class="dropdown-divider" /></li>
            <li><a class="dropdown-item" href="logout">Logout</a></li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Add Agent Form -->
    <div class="container-fluid">
      <h1 class="mb-4">Add University Agent</h1>

      <form action="addAgent" method="post" class="needs-validation" novalidate>
        <!-- University Details Section -->
        <section class="form-section">
          <h2 class="section-title">University Details</h2>
          <div class="row g-3">
            <div class="col-md-6">
              <label for="universityName" class="form-label">University Name <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="universityName" name="universityName" placeholder="Enter university name" required />
              <div class="invalid-feedback">University name is required.</div>
            </div>
            <div class="col-md-6">
              <label for="universityAddress" class="form-label">University Address</label>
              <input type="text" class="form-control" id="universityAddress" name="universityAddress" placeholder="Enter address (optional)" />
            </div>
          </div>
        </section>

        <!-- Agent Details Section -->
        <section class="form-section">
          <h2 class="section-title">Agent Details</h2>
          <div class="row g-3">
            <div class="col-md-6">
              <label for="agentFname" class="form-label">Agent First Name <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="agentFname" name="fname" placeholder="Enter first name" required />
              <div class="invalid-feedback">Agent first name is required.</div>
            </div>
            <div class="col-md-6">
              <label for="agentLname" class="form-label">Agent Last Name <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="agentLname" name="lname" placeholder="Enter last name" required />
              <div class="invalid-feedback">Agent last name is required.</div>
            </div>
            <div class="col-md-6">
              <label for="agentEmail" class="form-label">Agent Email <span class="text-danger">*</span></label>
              <input type="email" class="form-control" id="agentEmail" name="agentEmail" placeholder="agent@example.com" required />
              <div class="invalid-feedback">Please enter a valid email address.</div>
            </div>
            <div class="col-md-6">
              <label for="agentPhone" class="form-label">Agent Phone Number <span class="text-danger">*</span></label>
              <input type="tel" class="form-control" id="agentPhone" name="agentPhone" placeholder="+1 234 567 8900" pattern="^\+?[0-9\s\-]{7,15}$" required />
              <div class="invalid-feedback">Please enter a valid phone number.</div>
            </div>
            <div class="col-md-6">
              <label for="agentPassword" class="form-label">Enter Password <span class="text-danger">*</span></label>
              <input type="password" class="form-control" id="agentPassword" name="password" required />
              <div class="invalid-feedback">Password is required.</div>
            </div>
            <div class="col-md-6">
              <label for="agentConfPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
              <input type="password" class="form-control" id="agentConfPassword" name="confpassword" required />
              <div class="invalid-feedback">Please confirm your password.</div>
            </div>
          </div>
        </section>

        <div class="d-flex justify-content-center">
          <button type="submit" class="btn btn-primary btn-lg px-5">Add Agent</button>
        </div>
      </form>
    </div>

  </div>

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    // Sidebar toggle
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const toggleBtn = document.getElementById('sidebarCollapse');

    toggleBtn.addEventListener('click', () => {
      sidebar.classList.toggle('collapsed');
      content.classList.toggle('fullwidth');
    });

    // Bootstrap 5 form validation
    (() => {
      'use strict';
      const forms = document.querySelectorAll('.needs-validation');
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
