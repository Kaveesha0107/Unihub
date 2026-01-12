<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("user")) {
        response.sendRedirect("home.jsp"); // or redirect to login
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UniHub | User Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
        	background-color: #222;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .card-hover:hover {
            transform: scale(1.02);
            transition: 0.3s ease;
        }
        main {
            flex: 1;
        }
    </style>
</head>
<body>

<!-- Header -->
	<%@ include file="loggedUserHeader.jsp"%>

<!-- Dashboard Content -->
<main class="container mt-5 mb-5">
    <div class="text-center mb-4">
        <h2 class="fw-bold text-dark">Welcome to Your Dashboard <%= session.getAttribute("username") %></h2>
        <p class="text-muted">Manage your tickets and get support fast and easy.</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card card-hover shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Submit New Ticket</h5>
                    <p class="card-text">Got an issue? Let us know right away.</p>
                    <a href="newTicket" class="btn btn-primary">Submit Ticket</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">View Previous Tickets & Responses</h5>
                    <p class="card-text">Check tickets & replies to your tickets.</p>
						<a href="userTicketList" class="btn btn-success">View Tickets</a>
					</div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Submit Rewiews</h5>
                    <p class="card-text">Give us Rewiews!</p>
                    <a href="newReview" class="btn btn-warning">Submit a rewiew</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card card-hover shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Manage Reviews</h5>
                    <p class="card-text">View , Edit & Delete your previous reviews.</p>
                    <a href="readReviews" class="btn btn-info">Manage Reviews</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card card-hover shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Account Settings</h5>
                    <p class="card-text">Update your profile or change your password.</p>
                    <a href="accountSettings" class="btn btn-secondary">Go to Settings</a>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Footer -->
	<%@ include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
