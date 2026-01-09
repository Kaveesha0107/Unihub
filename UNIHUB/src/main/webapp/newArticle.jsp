<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Create New Article - UniHub Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet" />
<link rel="stylesheet" href="./CSS/adminDash.css" />

<style>
    /* Form container styling */
    .form-container {
        max-width: 800px;
        margin: 40px auto;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        padding: 30px;
        border-radius: 10px;
        background: white;
    }

    .form-title {
        color: #3d5a80;
        margin-bottom: 30px;
        font-weight: 600;
    }

    .file-upload {
        position: relative;
        overflow: hidden;
        border: 2px dashed #ced4da;
        border-radius: 8px;
        padding: 30px 20px;
        text-align: center;
        cursor: pointer;
        transition: border-color 0.3s ease;
    }

    .file-upload:hover {
        border-color: #0d6efd;
    }

    .file-upload-input {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
        width: 100%;
        height: 100%;
    }

    .preview-img {
        max-height: 200px;
        object-fit: cover;
        margin-top: 10px;
        display: none;
        border-radius: 8px;
        border: 1px solid #ddd;
    }

    .char-counter {
        font-size: 0.8rem;
        color: #6c757d;
    }

    .char-counter.invalid {
        color: #dc3545 !important; /* Bootstrap danger color */
        font-weight: 600;
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
                <li class="nav-item"><a href="articleDash" class="nav-link active"><i class="fas fa-newspaper"></i> Articles</a></li>
                <li class="nav-item"><a href="userManagementDash" class="nav-link"><i class="fas fa-users"></i> Users</a></li>
                <li class="nav-item"><a href="allReviews" class="nav-link"><i class="fas fa-comments"></i> Reviews</a></li>
                <li class="nav-item"><a href="uniAgentManagementDash" class="nav-link"><i class="fas fa-user-tie"></i> University Agents</a></li>
                <li class="nav-item"><a href="contactUsManagementDash" class="nav-link"><i class="fas fa-headset"></i> Contact - Us Requests</a></li>
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

        <!-- Article Form -->
        <div class="form-container bg-white shadow-sm rounded">
            <h2 class="form-title text-center">
                <i class="bi bi-pencil-square"></i> Create A New Article
            </h2>

            <form method="post" action="createArticle" enctype="multipart/form-data" id="articleForm" novalidate>
                <!-- Title -->
                <div class="mb-4">
                    <label for="articleTitle" class="form-label fw-bold">Article Title</label>
                    <input type="text" class="form-control form-control-lg" id="articleTitle"
                        placeholder="Enter article title" name="title" required >
                    <div class="invalid-feedback">Title must be between 5 and 250 characters.</div>
                </div>

                <!-- Featured Image -->
                <div class="mb-4">
                    <label class="form-label fw-bold">Featured Image</label>
                    <div class="file-upload">
                        <div class="d-flex justify-content-center">
                            <i class="bi bi-cloud-arrow-up fs-1 text-muted"></i>
                        </div>
                        <p class="text-muted">Drag & drop your image here or click to browse</p>
                        <input type="file" class="file-upload-input" id="articleImage" accept="image/*" name="image" required>
                        <div class="invalid-feedback">Please select an image.</div>
                    </div>
                    <img id="imagePreview" class="img-fluid rounded preview-img" alt="Preview">
                </div>

                <!-- Content -->
                <div class="mb-4">
                    <label for="articleContent" class="form-label fw-bold">Content</label>
                    <textarea class="form-control" id="articleContent" rows="10" placeholder="Write your article content here..."
                        required name="content"></textarea>
                    <div class="invalid-feedback">Content is required.</div>
                </div>

                <!-- Summary -->
                <div class="mb-4">
                    <label for="articleSummary" class="form-label fw-bold">Summary</label>
                    <textarea class="form-control" id="articleSummary" rows="3" placeholder="Brief summary of your article..."
                        name="summary" maxlength="250"></textarea>
                    <div class="char-counter text-end" id="summaryCounter">0/250 characters</div>
                    <div class="invalid-feedback" id="summaryFeedback">Summary cannot exceed 250 characters.</div>
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button type="reset" class="btn btn-outline-secondary me-md-2">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save"></i> Publish Article
                    </button>
                </div>
            </form>
        </div>

    </div>

    <!-- Bootstrap JS Bundle -->
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

        // Image preview functionality
        document.getElementById('articleImage').addEventListener('change', function (e) {
            const preview = document.getElementById('imagePreview');
            const files = e.target.files;

            if (files.length > 1) {
                alert("Please select only one image.");
                this.value = ""; // Reset file input
                preview.style.display = 'none';
                return;
            }

            const file = files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function () {
                    preview.src = reader.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
            }
        });

        // Summary character counter
        const summaryTextarea = document.getElementById('articleSummary');
        const summaryCounter = document.getElementById('summaryCounter');
        const summaryFeedback = document.getElementById('summaryFeedback');

        summaryTextarea.addEventListener('input', function () {
            const len = this.value.length;
            summaryCounter.textContent = `${len}/250 characters`;
            if (len > 250) {
                summaryCounter.classList.add('invalid');
                summaryTextarea.classList.add('is-invalid');
                summaryFeedback.style.display = 'block';
            } else {
                summaryCounter.classList.remove('invalid');
                summaryTextarea.classList.remove('is-invalid');
                summaryFeedback.style.display = 'none';
            }
        });

        // Title character validation and form submission validation
        const form = document.getElementById('articleForm');
        const titleInput = document.getElementById('articleTitle');

        titleInput.addEventListener('input', () => {
            const len = titleInput.value.length;
            if (len >= 5 && len <= 250) {
                titleInput.classList.remove('is-invalid');
            }
        });

        form.addEventListener('submit', function (event) {
            let valid = true;

            // Title length check
            const titleLen = titleInput.value.trim().length;
            if (titleLen < 5 || titleLen > 250) {
                titleInput.classList.add('is-invalid');
                valid = false;
            }

            // Summary length check (optional field, max 250)
            const summaryLen = summaryTextarea.value.length;
            if (summaryLen > 250) {
                summaryTextarea.classList.add('is-invalid');
                summaryFeedback.style.display = 'block';
                valid = false;
            }

            // Let Bootstrap handle required fields validation
            if (!form.checkValidity()) {
                valid = false;
            }

            if (!valid) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        });
    </script>
</body>

</html>
