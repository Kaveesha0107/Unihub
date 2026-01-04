<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Admin Login - UniHub</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

<style>
body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f7fa;
}

.login-card {
    background: #fff;
    padding: 2.5rem 3rem;
    border-radius: 0.75rem;
    box-shadow: 0 6px 15px rgb(0 0 0 / 0.1);
    width: 100%;
    max-width: 420px;
}

.login-card h2 {
    color: #0d6efd;
    font-weight: 700;
    margin-bottom: 1.5rem;
    text-align: center;
    letter-spacing: 1.5px;
}

.form-label {
    font-weight: 600;
}

.btn-login {
    background-color: #0d6efd;
    border: none;
    font-weight: 700;
    font-size: 1.1rem;
    padding: 0.75rem;
    border-radius: 0.5rem;
    width: 100%;
    transition: background-color 0.3s ease;
    color: white;
}

.btn-login:hover {
    background-color: #0b5ed7;
}

.form-text {
    font-size: 0.9rem;
    color: #6c757d;
    margin-top: 0.5rem;
    text-align: center;
}

.error-message {
    color: #dc3545;
    font-weight: 600;
    margin-bottom: 1rem;
    text-align: center;
}

.links-container {
    margin-top: 1.75rem;
    text-align: center;
    font-size: 0.95rem;
    color: #555;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.links-container a {
    color: #0d6efd;
    text-decoration: none;
    font-weight: 600;
    transition: color 0.3s ease;
}

.links-container a:hover {
    color: #0b5ed7;
    text-decoration: underline;
}
</style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <!-- Center login card between header and footer -->
    <div style="flex: 1; display: flex; justify-content: center; align-items: center; padding: 2rem;">
        <div class="login-card shadow-sm">
            <h2>
                <i class="bi bi-shield-lock-fill me-2"></i>Admin Login
            </h2>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <form action="adminLogin" method="post" novalidate>
                <div class="mb-3">
                    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                    <input type="email" id="email" name="email" class="form-control" required autofocus autocomplete="username" />
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                    <input type="password" id="password" name="password" class="form-control" required autocomplete="current-password" />
                </div>

                <button type="submit" class="btn btn-login">
                    <i class="bi bi-box-arrow-in-right me-2"></i> Login
                </button>
            </form>

            <div class="links-container">
                <a href="agentlogin.jsp">Agent Login</a>
                <a href="login.jsp">User Login</a>
            </div>

            <div class="form-text mt-3">Please enter your admin credentials to access the dashboard.</div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Bootstrap form validation
        (() => {
            'use strict';
            const forms = document.querySelectorAll('form');
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
