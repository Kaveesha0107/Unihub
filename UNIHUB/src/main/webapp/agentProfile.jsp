<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Base64" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("agent")) {
        response.sendRedirect("home.jsp"); // or redirect to login
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Agent Profile</title>

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
      transition: all 0.3s;
      height: 100vh;
      position: fixed;
      top: 0;
      left: 0;
      overflow-y: auto;
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

    /* Profile Card */
    .profile-card {
      max-width: 700px;
      margin: 0 auto;
      background: #fff;
      border-radius: 0.75rem;
      box-shadow: 0 6px 12px rgb(0 0 0 / 0.1);
      padding: 2rem;
      text-align: center;
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
      margin: 0 auto 1rem auto;
    }
    /* Black/white/gray icon styling */
    .profile-icon {
      background-color: #f8f9fa;
      color: #6c757d; /* Bootstrap's gray-600 */
      border-color: #6c757d;
    }
    .profile-name {
      font-weight: 700;
      font-size: 1.75rem;
      margin-bottom: 0.25rem;
      color: #0d6efd;
    }
    .profile-email {
      font-style: italic;
      color: #6c757d;
      margin-bottom: 1.5rem;
      user-select: text;
    }
    .profile-info-row {
      display: flex;
      justify-content: space-between;
      padding: 0.5rem 0;
      border-bottom: 1px solid #e9ecef;
      font-size: 1.1rem;
    }
    .profile-info-label {
      font-weight: 600;
      color: #495057;
    }
    .profile-info-value {
      color: #212529;
      user-select: text;
    }
    .edit-btn-container {
      margin-top: 2rem;
    }

    /* Responsive */
    @media (max-width: 768px) {
      #sidebar {
        position: relative;
        height: auto;
        max-width: 100%;
      }
      #content {
        margin-left: 0;
        padding: 1rem;
      }
      .profile-info-row {
        flex-direction: column;
        align-items: flex-start;
      }
      .profile-info-value {
        margin-top: 0.25rem;
      }
    }
  </style>
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
      <li class="active"><a href="agentProfile" class="text-reset text-decoration-none"><i class="bi bi-person-lines-fill"></i> My Profile</a></li>
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

    <!-- Profile Card -->
    <div class="profile-card">
      <c:choose>
        <c:when test="${not empty agent.base64Image}">
          <img src="data:image/jpeg;base64,${agent.base64Image}" alt="Profile Photo" class="profile-image" />
        </c:when>
        <c:otherwise>
          <div class="profile-icon">
            <i class="bi bi-person-circle"></i>
          </div>
        </c:otherwise>
      </c:choose>

      <div class="profile-name">${agent.firstName} ${agent.lastName}</div>
      <div class="profile-email">${agent.email}</div>

      <div class="profile-info-row">
        <div class="profile-info-label">Phone:</div>
        <div class="profile-info-value">${agent.phone}</div>
      </div>

      <div class="profile-info-row">
        <div class="profile-info-label">University:</div>
        <div class="profile-info-value">
          <c:choose>
            <c:when test="${not empty university}">
              ${university.name}
            </c:when>
            <c:otherwise>
              N/A
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <div class="edit-btn-container">
        <a href="editAgentProfile?agentId=${agent.agentId}" class="btn btn-primary btn-lg">
          <i class="bi bi-pencil-square me-2"></i> Edit Profile
        </a>
      </div>
    </div>
  </div>

  <!-- Bootstrap 5 JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
