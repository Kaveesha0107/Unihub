<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Reviews Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- FontAwesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  <!-- Your adminDash.css -->
  <link rel="stylesheet" href="./CSS/adminDash.css" />
  <style>
    /* Additional styling for stars and detail rows */
    .star-light {
      color: #ddd;
    }
    .star-filled {
      color: #ffc107;
    }
    .detail-row {
      background-color: #f8f9fa;
    }
    .detail-cell {
      padding: 1rem 2rem;
      font-size: 0.95rem;
      color: #333;
      white-space: pre-wrap;
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
        <li class="nav-item"><a href="allReviews" class="nav-link active"><i class="fas fa-comments"></i> Reviews</a></li>
        <li class="nav-item"><a href="uniAgentManagementDash" class="nav-link"><i class="fas fa-user-tie"></i> University Agents</a></li>
        <li class="nav-item"><a href="contactUsManagementDash" class="nav-link"><i class="fas fa-headset"></i> Contact - Us Requests</a></li>
        <li class="nav-item"><a href="logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
      </ul>
    </div>
  </nav>

  <!-- Page Content -->
  <div id="content">
    <!-- Top Navbar -->
    <nav class="navbar d-flex justify-content-between align-items-center">
      <button id="sidebarCollapse" title="Toggle Sidebar">
        <i class="fas fa-bars"></i>
      </button>
      <div class="d-flex align-items-center">
        
        <div class="dropdown">
          <a href="#" class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle"
             id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://i.pravatar.cc/40" alt="User" class="rounded-circle me-2" width="40" height="40" />
            <strong>Admin</strong>
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

    <!-- Review Count Card -->
    <div class="container-fluid mt-4">
      <div class="row g-4 justify-content-center">
        <div class="col-md-4 col-lg-3">
          <a href="allReviews" class="text-decoration-none">
            <div class="card p-4 text-center">
              <i class="fas fa-comments stat-icon"></i>
              <div class="stat-number">
                <%= request.getAttribute("reviewCount") != null ? request.getAttribute("reviewCount") : "0" %>
              </div>
              <div class="stat-label">Reviews</div>
            </div>
          </a>
        </div>
      </div>
    </div>

    <!-- Reviews Table -->
    <div class="container-fluid mt-4">
      <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
          <thead class="table-dark">
            <tr>
              <th scope="col">Review ID</th>
              <th scope="col">Title</th>
              <th scope="col">Review Type</th>
              <th scope="col">Rating</th>
              <th scope="col">Reviewed At</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="review" items="${reviewList}">
              <tr>
                <td><c:out value="${review.reviewId}" /></td>
                <td><c:out value="${review.title}" /></td>
                <td><c:out value="${review.reviewType}" /></td>
                <td>
                  <c:set var="rating" value="${review.rating}" />
                  <c:forEach var="i" begin="1" end="5">
                    <i class="fas fa-star <c:choose>
                      <c:when test='${i <= rating}'>star-filled</c:when>
                      <c:otherwise>star-light</c:otherwise>
                    </c:choose>"></i>
                  </c:forEach>
                </td>
                <td><fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td>
                  <button class="btn btn-sm btn-primary toggle-details-btn" type="button" aria-expanded="false" aria-controls="details-${review.reviewId}" data-bs-toggle="collapse" data-bs-target="#details-${review.reviewId}">
                    View
                  </button>
                </td>
              </tr>
              <tr class="collapse detail-row" id="details-${review.reviewId}">
                <td colspan="6" class="detail-cell">
                  <strong>Review ID:</strong> <c:out value="${review.reviewId}" /><br/>
                  <strong>User ID:</strong> <c:out value="${review.userId}" /><br/>
                  <strong>Review Type:</strong> <c:out value="${review.reviewType}" /><br/>
                  <strong>Website Aspect:</strong> <c:out value="${review.websiteAspect != null ? review.websiteAspect : 'N/A'}" /><br/>
                  <strong>University Agent ID:</strong> <c:out value="${review.uniId != null ? review.uniId : 'N/A'}" /><br/>
                  <strong>Title:</strong> <c:out value="${review.title}" /><br/>
                  <strong>Content : </strong><c:out value="${review.content}" /><br/>
                  <strong>Rating:</strong>
                  <c:forEach var="i" begin="1" end="5">
                    <i class="fas fa-star <c:choose>
                      <c:when test='${i <= rating}'>star-filled</c:when>
                      <c:otherwise>star-light</c:otherwise>
                    </c:choose>"></i>
                  </c:forEach><br/>
                  <strong>Reviewed At:</strong> <fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
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

  <!-- Sidebar toggle script -->
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
