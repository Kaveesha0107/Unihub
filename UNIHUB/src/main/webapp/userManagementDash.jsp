<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>User Management Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- FontAwesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="./CSS/adminDash.css" />
  <style>
    /* Table styling consistent with admin dash */
    .table thead th {
      background-color: #0d6efd;
      color: white;
      font-weight: 600;
    }
    .table tbody tr:hover {
      background-color: #f1f5fb;
    }
    .btn-delete {
      font-size: 0.9rem;
      padding: 0.25rem 0.6rem;
    }
    /* Truncate bio for neatness */
    .bio-snippet {
      max-width: 250px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
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
      <li class="nav-item"><a href="userManagementDash" class="nav-link active"><i class="fas fa-users"></i> Users</a></li>
      <li class="nav-item"><a href="allReviews" class="nav-link"><i class="fas fa-comments"></i> Reviews</a></li>
      <li class="nav-item"><a href="uniAgentManagementDash" class="nav-link"><i class="fas fa-user-tie"></i> University Agents</a></li>
      <li class="nav-item"><a href="contactUsManagementDash" class="nav-link"><i class="fas fa-headset"></i> Contact - Us Requests</a></li>
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

  <!-- User Count Card -->
  <div class="container-fluid mt-4">
    <div class="row justify-content-center">
      <div class="col-md-4 col-lg-3">
        <a href="userManagementDash" class="text-decoration-none">
          <div class="card p-4 text-center shadow-sm">
            <i class="fas fa-users stat-icon"></i>
            <div class="stat-number">
              <%= request.getAttribute("userCount") != null ? request.getAttribute("userCount") : "0" %>
            </div>
            <div class="stat-label fs-5 mt-2">Users</div>
          </div>
        </a>
      </div>
    </div>
  </div>

  <!-- Users Table -->
  <div class="container-fluid mt-4">
    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle">
        <thead>
          <tr>
            <th>User ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Bio</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="user" items="${userList}">
            <tr>
              <td><c:out value="${user.userId}" /></td>
              <td><c:out value="${user.firstname}" /></td>
              <td><c:out value="${user.lastname}" /></td>
              <td><c:out value="${user.phone}" /></td>
              <td><c:out value="${user.email}" /></td>
              <td><span class="bio-snippet" title="${user.bio}"><c:out value="${user.bio}" /></span></td>
              <td>
                <form action="deleteUserByAdmin" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                  <input type="hidden" name="userId" value="${user.userId}" />
                  <button type="submit" class="btn btn-sm btn-danger">
                    <i class="fas fa-trash-alt"></i> Delete
                  </button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

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
