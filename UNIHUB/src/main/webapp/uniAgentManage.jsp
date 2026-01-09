<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>University Agent Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- FontAwesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="./CSS/adminDash.css" />
  <style>
    /* Tables styling */
    .table thead th {
      background-color: #0d6efd;
      color: white;
      font-weight: 600;
    }
    .table tbody tr:hover {
      background-color: #f1f5fb;
    }
    /* Responsive */
    @media (max-width: 768px) {
      #sidebar {
        margin-left: -250px;
        position: fixed;
      }
      #sidebar.collapsed {
        margin-left: 0;
      }
      #content {
        margin-left: 0;
      }
      #content.fullwidth {
        margin-left: 0;
      }
    }
    /* Sidebar toggle button */
    #sidebarCollapse {
      background: transparent;
      border: none;
      color: #212529;
      font-size: 1.5rem;
      cursor: pointer;
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
  <div id="content">
    <!-- Navbar -->
    <nav class="navbar d-flex justify-content-between align-items-center">
      <button id="sidebarCollapse" title="Toggle Sidebar">
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
            <li><a class="dropdown-item" href="uniAgentManagementDash">University Agent
                Management</a></li>
            <li><hr class="dropdown-divider" /></li>
            <li><a class="dropdown-item" href="logout">Logout</a></li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Universities List -->
    <div class="container-fluid mt-4">
      <h3 class="mb-3">Universities</h3>
      <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
          <thead>
            <tr>
              <th>University ID</th>
              <th>Name</th>
              <th>Location</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="uni" items="${uniList}">
              <tr>
                <td><c:out value="${uni.universityId}" /></td>
                <td><c:out value="${uni.name}" /></td>
                <td><c:out value="${uni.location}" /></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

    <!-- University Agents List -->
    <div class="container-fluid mt-5">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">University Agents</h3>
        <a href="newAgent.jsp" class="btn btn-primary">
          <i class="fas fa-plus"></i> Add New Agent
        </a>
      </div>
      <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
          <thead>
            <tr>
              <th>Agent ID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>University</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="agent" items="${agentList}">
              <tr>
                <td><c:out value="${agent.agentId}" /></td>
                <td><c:out value="${agent.firstName}" /></td>
                <td><c:out value="${agent.lastName}" /></td>
                <td><c:out value="${agent.email}" /></td>
                <td><c:out value="${agent.phone}" /></td>
                <td>
                  <c:forEach var="uni" items="${uniList}">
                    <c:if test="${uni.universityId == agent.universityId}">
                      <c:out value="${uni.name}" />
                    </c:if>
                  </c:forEach>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

  </div>

  <!-- Bootstrap JS Bundle -->
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
