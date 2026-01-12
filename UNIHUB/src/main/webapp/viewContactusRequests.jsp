<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("adminLogin.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Contact Us Management - UniHub Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
<link rel="stylesheet" href="./CSS/adminDash.css" />
<style>
  /* Table and expand row styling */
  .details-row {
    background-color: #f9f9f9;
  }
  .details-cell {
    padding: 1rem 2rem;
    font-style: italic;
    color: #555;
  }
  .action-btn {
    margin-right: 0.5rem;
  }
  .action-btn:last-child {
    margin-right: 0;
  }
  .cursor-pointer {
    cursor: pointer;
  }
  .collapse-row {
    transition: all 0.3s ease;
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
        <li class="nav-item"><a href="uniAgentManagementDash" class="nav-link"><i class="fas fa-user-tie"></i> University Agents</a></li>
        <li class="nav-item"><a href="contactUsManagementDash" class="nav-link active"><i class="fas fa-headset"></i> Contact - Us Requests</a></li>
        <li class="nav-item"><a href="logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
      </ul>
    </div>
  </nav>

  <!-- Page Content -->
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
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
            <li><a class="dropdown-item" href="articleDash">Article Management</a></li>
            <li><a class="dropdown-item" href="userManagementDash">User Management</a></li>
            <li><a class="dropdown-item" href="uniAgentManagementDash">University Agent Management</a></li>
            <li><hr class="dropdown-divider" /></li>
            <li><a class="dropdown-item" href="logout">Logout</a></li>
          </ul>
        </div>
      </div>
    </nav>

    <h2 class="mb-4">Contact Us Requests</h2>

    <table class="table table-striped table-hover align-middle">
      <thead class="table-dark">
        <tr>
          <th>#</th>
          <th>Name</th>
          <th>Email</th>
          <th>Subject</th>
          <th>Status</th>
          <th>Created At</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="contact" items="${contactUsList}" varStatus="loop">
          <tr class="cursor-pointer" data-bs-toggle="collapse" data-bs-target="#detailsRow${loop.index}" aria-expanded="false" aria-controls="detailsRow${loop.index}">
            <td>${contact.id}</td>
            <td>${contact.name}</td>
            <td>${contact.email}</td>
            <td>${contact.subject}</td>
            <td>
              <c:choose>
                <c:when test="${contact.status == 'New'}">
                  <span class="badge bg-primary">${contact.status}</span>
                </c:when>
                <c:when test="${contact.status == 'In Progress'}">
                  <span class="badge bg-warning text-dark">${contact.status}</span>
                </c:when>
                <c:when test="${contact.status == 'Resolved'}">
                  <span class="badge bg-success">${contact.status}</span>
                </c:when>
                <c:otherwise>
                  <span class="badge bg-secondary">${contact.status}</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td>${contact.createdAt}</td>
            <td>
              <button class="btn btn-sm btn-info action-btn toggle-details" type="button" data-bs-toggle="collapse" data-bs-target="#detailsRow${loop.index}" aria-expanded="false" aria-controls="detailsRow${loop.index}">
                <i class="fas fa-eye"></i> View
              </button>
              <form action="deleteContact" method="post" style="display:inline-block;" onsubmit="return confirm('Are you sure you want to delete this request?');">
                <input type="hidden" name="id" value="${contact.id}" />
                <button type="submit" class="btn btn-sm btn-danger action-btn">
                  <i class="fas fa-trash-alt"></i> Delete
                </button>
              </form>
              <form action="markContactResolved" method="post" style="display:inline-block;">
                <input type="hidden" name="id" value="${contact.id}" />
                <button type="submit" class="btn btn-sm btn-success action-btn" <c:if test="${contact.status == 'Resolved'}">disabled</c:if>>
                  <i class="fas fa-check"></i> Mark Resolved
                </button>
              </form>
            </td>
          </tr>
          <tr class="collapse details-row" id="detailsRow${loop.index}">
            <td colspan="7" class="details-cell">
              <strong>Message:</strong><br />
              <pre style="white-space: pre-wrap; margin: 0;">${contact.message}</pre>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const toggleBtn = document.getElementById('sidebarCollapse');

    toggleBtn.addEventListener('click', () => {
      sidebar.classList.toggle('collapsed');
      content.classList.toggle('fullwidth');
    });
  </script>

</body>
</html>
