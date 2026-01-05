<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Article Management</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="./CSS/adminDash.css" />
<style>
#imagePreview {
	max-width: 100%;
	max-height: 200px;
	object-fit: contain;
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<nav id="sidebar" class="bg-dark">
		<div class="p-4">
			<h3 class="text-white mb-4">UniHub Admin</h3>
			<ul class="nav flex-column">
				<li class="nav-item"><a href="adminDash" class="nav-link"><i
						class="fas fa-tachometer-alt"></i> Dashboard</a></li>
				<li class="nav-item"><a href="articleDash" class="nav-link active"><i class="fas fa-newspaper"></i>
						Articles</a></li>
				<li class="nav-item"><a href="userManagementDash"
					class="nav-link"><i class="fas fa-users"></i> Users</a></li>
				<li class="nav-item"><a href="allReviews" class="nav-link"><i
						class="fas fa-comments"></i> Reviews</a></li>
				<li class="nav-item"><a href="uniAgentManagementDash" class="nav-link"><i
						class="fas fa-user-tie"></i> University Agents</a></li>
				<li class="nav-item"><a href="contactUsManagementDash" class="nav-link"><i
						class="fas fa-headset"></i> Contact - Us Requests</a></li>
				<li class="nav-item"><a href="logout" class="nav-link"><i
						class="fas fa-sign-out-alt"></i> Logout</a></li>
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

		<!-- Article Count Card -->
		<div class="container-fluid mt-4">
			<div class="row justify-content-center">
				<div class="col-md-4 col-lg-3">
					<a href="articledash" class="text-decoration-none">
						<div class="card p-4 text-center shadow-sm">
							<i class="fas fa-newspaper stat-icon"></i>
							<div class="stat-number">${articleCount}</div>
							<div class="stat-label fs-5 mt-2">Articles</div>
						</div>
					</a>
				</div>
			</div>
		</div>

		<!-- Add New Article Button -->
		<div class="container-fluid mt-4 mb-3">
			<div class="row">
				<div class="col text-end">
					<a href="newArticle.jsp" class="btn btn-success btn-lg">
						<i class="fas fa-plus"></i> Add New Article
					</a>
				</div>
			</div>
		</div>

		<!-- Article Management Table -->
		<div class="container-fluid mt-4">
			<div class="row g-4">
				<div class="modal fade" id="editArticleModal" tabindex="-1"
					aria-labelledby="editArticleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="editArticleModalLabel">Edit
									Article</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body" id="editArticleModalBody">
								<!-- Edit form content will be loaded here -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row g-4">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Article ID</th>
							<th>Title</th>
							<th>Edit</th>
							<th>Delete</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${articles}">
							<tr>
								<td>${article.id}</td>
								<td>${article.title}</td>
								<td>
									<button class="btn btn-primary btn-sm edit-article-btn"
										data-id="${article.id}">Edit</button>
								</td>
								<td>
									<form action="deleteArticle" method="post"
										onsubmit="return confirm('Are you sure?');">
										<input type="hidden" name="id" value="${article.id}" />
										<button type="submit" class="btn btn-sm btn-danger">Delete</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
const sidebar = document.getElementById('sidebar');
const content = document.getElementById('content');
const toggleBtn = document.getElementById('sidebarCollapse');
toggleBtn.addEventListener('click', () => {
	sidebar.classList.toggle('collapsed');
	content.classList.toggle('fullwidth');
});
$(document).ready(function () {
    $('.edit-article-btn').click(function () {
      var articleId = $(this).data('id');

      $('#editArticleModalBody').html('Loading...');
      $('#editArticleModal').modal('show');

      $.ajax({
        url: '${pageContext.request.contextPath}/editArticle',
        type: 'GET',
        data: { id: articleId },
        dataType: 'json',
        success: function(article) {

          var formHtml = `
            <form id="editArticleForm" enctype="multipart/form-data">
              <input type="hidden" name="id" />
              <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" class="form-control" id="title" name="title" />
              </div>
              <div class="mb-4">
                <label class="form-label fw-bold">Featured Image</label>
                <div class="file-upload border rounded p-3 text-center">
                  <div class="d-flex justify-content-center">
                    <i class="bi bi-cloud-arrow-up fs-1 text-muted"></i>
                  </div>
                  <p class="text-muted">Drag & drop your image here or click to browse</p>
                  <input type="file" class="file-upload-input" id="articleImage" accept="image/*" name="image">
                </div>
                <img id="imagePreview" class="img-fluid rounded preview-img" alt="Preview" />
              </div>
              <div class="mb-3">
                <label for="content" class="form-label">Content</label>
                <textarea class="form-control" name="content" rows="5" style="width: 100%; box-sizing: border-box;"></textarea>
              </div>
              <div class="mb-3">
                <label for="summary" class="form-label">Summary</label>
                <textarea class="form-control" id="summary" name="summary" rows="2"></textarea>
              </div>
              <button type="submit" class="btn btn-primary">Save changes</button>
            </form>
          `;

          $('#editArticleModalBody').html(formHtml);

          $('#editArticleForm input[name="id"]').val(article.id);
          $('#editArticleForm input[name="title"]').val(article.title);
          $('#editArticleForm textarea[name="summary"]').val(article.summery);
          $('#editArticleForm textarea[name="content"]').val(article.content);

          if (article.base64Image) {
            $('#imagePreview').attr('src', 'data:image/jpeg;base64,' + article.base64Image);
          }

          $('#articleImage').change(function (e) {
            var reader = new FileReader();
            reader.onload = function (event) {
              $('#imagePreview').attr('src', event.target.result);
            };
            reader.readAsDataURL(this.files[0]);
          });

          $('#editArticleForm').submit(function (e) {
            e.preventDefault();
            var formData = new FormData(this);
            $.ajax({
              url: '${pageContext.request.contextPath}/editArticle',
              type: 'POST',
              data: formData,
              processData: false,
              contentType: false,
              success: function (response) {
                alert('Article updated successfully!');
                $('#editArticleModal').modal('hide');
              },
              error: function (xhr) {
                alert('Update failed: ' + xhr.responseText);
              }
            });
          });
        },
        error: function (xhr) {
          $('#editArticleModalBody').html('<p class="text-danger">Failed to load form.</p>');
        }
      });
    });
  });
</script>
</body>
</html>
