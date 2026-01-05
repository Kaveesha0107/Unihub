<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("agent")) {
        response.sendRedirect("home.jsp"); // redirect if not agent
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Edit Agent Profile</title>

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

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
      box-shadow: 0 2px 4px rgb(0 0 0 / 0.1);
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


    /* Profile Image */
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
      margin: 0 auto 1rem auto;
    }
    .profile-icon {
      background-color: #f8f9fa;
      color: #6c757d;
      border-color: #6c757d;
    }

    /* Form Labels */
    .form-label {
      font-weight: 600;
    }

    /* Button group */
    .btn-group-custom > * {
      min-width: 140px;
    }
    @media (max-width: 576px) {
      .btn-group-custom {
        flex-direction: column;
        gap: 0.75rem;
      }
      .btn-group-custom > * {
        min-width: 100%;
      }
    }
  </style>

  <script>
    // Preview uploaded profile image and replace icon if needed
    function previewImage(event) {
      const input = event.target;
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
          const preview = document.getElementById('profileImagePreview');
          if(preview.tagName.toLowerCase() === 'img') {
            preview.src = e.target.result;
          } else {
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

    // Toggle password change section visibility and icon
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

  <!-- Sidebar -->
  <nav id="sidebar">
    <div class="sidebar-header">
      AGENT DASHBOARD
    </div>
    <ul class="components">
      <li><a href="agentDash.jsp" class="text-reset text-decoration-none"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
      <li><a href="agentTicketList" class="text-reset text-decoration-none"><i class="bi bi-chat-dots"></i> Manage Tickets</a></li>
      <li><a href="agentProfile" class="text-reset text-decoration-none"><i class="bi bi-person-lines-fill"></i> My Profile</a></li>
      <li class="active"><a href="editAgentProfile" class="text-reset text-decoration-none"><i class="bi bi-pencil-square"></i> Edit Profile</a></li>
      <li><i class="bi bi-box-arrow-right"></i> <a href="logout" style="color: inherit; text-decoration:none;">Logout</a></li>
    </ul>
  </nav>

  <!-- Page Content -->
  <div id="content">
    <div class="navbar-custom">
      <div class="user-info">
        <i class="bi bi-person-circle"></i>
        <span>Welcome, <%= session.getAttribute("fname") %></span>
        <a href="logout" class="btn btn-outline-danger btn-sm btn-logout">Logout</a>
      </div>
    </div>

    <div class="card card-hover shadow-sm mx-auto p-4" style="max-width: 700px;">
      <form action="editAgentProfile" method="post" enctype="multipart/form-data" novalidate onsubmit="return validateForm()">
        <input type="hidden" name="agentId" value="${agent.agentId}" />

        <div class="d-flex flex-column align-items-center mb-4">
          <label for="profilePhoto" class="mb-2" style="cursor: pointer;" title="Click to change profile image">
            <c:choose>
              <c:when test="${not empty agent.base64Image}">
                <img id="profileImagePreview" src="data:image/jpeg;base64,${agent.base64Image}" alt="Profile Photo" class="profile-image" />
              </c:when>
              <c:otherwise>
                <div id="profileImagePreview" class="profile-icon">
                  <i class="bi bi-person-circle"></i>
                </div>
              </c:otherwise>
            </c:choose>
          </label>
          <input type="file" id="profilePhoto" name="profilePhoto" accept="image/*" class="d-none" onchange="previewImage(event)" />
          <div class="text-center mt-2 text-primary fw-semibold">Click image to change profile picture</div>
        </div>

        <div class="mb-3">
          <label for="firstName" class="form-label">First Name <span class="text-danger">*</span></label>
          <input type="text" class="form-control" id="firstName" name="firstName" required maxlength="50" value="${agent.firstName}" />
        </div>

        <div class="mb-3">
          <label for="lastName" class="form-label">Last Name <span class="text-danger">*</span></label>
          <input type="text" class="form-control" id="lastName" name="lastName" required maxlength="50" value="${agent.lastName}" />
        </div>

        <div class="mb-3">
          <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
          <input type="email" class="form-control" id="email" name="email" required maxlength="100" value="${agent.email}" />
        </div>

        <div class="mb-3">
          <label for="phone" class="form-label">Phone</label>
          <input type="tel" class="form-control" id="phone" name="phone" maxlength="20" value="${agent.phone}" />
        </div>

        <hr />

        <button type="button" class="btn btn-outline-primary mb-3 d-flex align-items-center" onclick="togglePasswordSection()" aria-expanded="false" aria-controls="passwordSection">
          <i id="togglePasswordIcon" class="bi bi-caret-down-fill me-2"></i> Change Password
        </button>

        <div id="passwordSection" style="display:none;">
          <div class="mb-3">
            <label for="newPassword" class="form-label">New Password</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" minlength="6" maxlength="100" placeholder="Leave blank to keep current password" />
          </div>

          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm New Password</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" minlength="6" maxlength="100" placeholder="Confirm new password" />
          </div>
        </div>

        <div class="d-flex justify-content-center gap-3 btn-group-custom flex-wrap mt-4">
          <button type="submit" class="btn btn-success btn-lg">
            <i class="bi bi-check-circle me-2"></i> Save Changes
          </button>
          <a href="agentProfile" class="btn btn-secondary btn-lg">
            <i class="bi bi-x-circle me-2"></i> Cancel
          </a>
        </div>
      </form>
    </div>
  </div>

  <!-- Bootstrap 5 JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
