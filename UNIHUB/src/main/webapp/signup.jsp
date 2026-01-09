<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>UniHub - Sign Up</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

<!-- Boxicons for icons -->
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />

<style>
    /* Background & Layout */
    body, html {
        height: 100%;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #222;
    }
    .signup-container {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 30px 15px;
    }
    .signup-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        max-width: 900px;
        width: 100%;
        display: flex;
        overflow: hidden;
    }

    /* Left side with image and text */
    .signup-left {
        flex: 1;
        position: relative;
        color: white;
        padding: 40px 30px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    .signup-left::before {
        content: "";
        position: absolute;
        inset: 0;
        background: rgba(41, 128, 185, 0.75);
        z-index: 0;
        border-radius: 16px 0 0 16px;
    }
    .signup-left-content {
        position: relative;
        z-index: 1;
    }
    .signup-left h1 {
        font-size: 2.8rem;
        font-weight: 700;
        margin-bottom: 20px;
        line-height: 1.1;
    }
    .signup-left p {
        font-size: 1.1rem;
        line-height: 1.5;
        max-width: 320px;
    }

    /* Right side form */
    .signup-right {
        flex: 1;
        padding: 40px 35px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    /* Form styles */
    .form-header {
        margin-bottom: 30px;
        font-weight: 700;
        font-size: 2rem;
        color: #2c3e50;
        text-align: center;
    }
    .form-text {
        font-size: 0.9rem;
        margin-bottom: 30px;
        text-align: center;
    }
    .form-text a {
        color: #3498db;
        text-decoration: none;
        font-weight: 600;
    }
    .form-text a:hover {
        text-decoration: underline;
    }

    /* Input group with icon */
    .input-group-icon {
        position: relative;
        margin-bottom: 20px;
    }
    .input-group-icon input {
        padding-left: 45px;
        height: 48px;
        font-size: 1rem;
        border-radius: 8px;
        border: 1px solid #ced4da;
        transition: border-color 0.3s ease;
    }
    .input-group-icon input:focus {
        border-color: #3498db;
        outline: none;
        box-shadow: 0 0 8px rgba(52, 152, 219, 0.4);
    }
    .input-group-icon i {
        position: absolute;
        top: 50%;
        left: 15px;
        transform: translateY(-50%);
        color: #7f8c8d;
        font-size: 1.3rem;
        pointer-events: none;
    }

    /* Checkbox and terms */
    .form-check-label a {
        color: #3498db;
        text-decoration: none;
        font-weight: 600;
    }
    .form-check-label a:hover {
        text-decoration: underline;
    }

    /* Submit button */
    .btn-submit {
        background: #3498db;
        border: none;
        font-weight: 700;
        font-size: 1.1rem;
        padding: 12px;
        border-radius: 8px;
        transition: background 0.3s ease;
        width: 100%;
    }
    .btn-submit:hover {
        background: #2980b9;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .signup-card {
            flex-direction: column;
            border-radius: 16px;
        }
        .signup-left {
            height: 200px;
            border-radius: 16px 16px 0 0;
        }
        .signup-left::before {
            border-radius: 16px 16px 0 0;
        }
        .signup-right {
            padding: 30px 20px;
        }
    }
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="signup-container">
    <div class="signup-card">

        <!-- Left panel with image and captions -->
        <div class="signup-left">
            <div class="signup-left-content">
                <h1>Create Your UniHub Account</h1>
                <p>Access personalized support and stay connected with our university service.</p>
            </div>
        </div>

        <!-- Right panel with form -->
        <div class="signup-right">
            <form method="post" action="AddUser" id="signupForm" novalidate>
                <div class="form-header">Sign Up</div>
                <div class="form-text">
                    Have an account? <a href="login.jsp">Login</a>
                </div>

                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="input-group-icon">
                            <input type="text" class="form-control" name="firstname" placeholder="First Name" required>
                            <i class='bx bx-user'></i>
                            <div class="invalid-feedback">First name is required.</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group-icon">
                            <input type="text" class="form-control" name="lastname" placeholder="Last Name" required>
                            <i class='bx bx-user'></i>
                            <div class="invalid-feedback">Last name is required.</div>
                        </div>
                    </div>
                </div>

                <div class="input-group-icon">
                    <input type="tel" class="form-control" name="phone" placeholder="Phone" pattern="^\+?\d{7,15}$" required>
                    <i class='bx bx-phone'></i>
                    <div class="invalid-feedback">Please enter a valid phone number.</div>
                </div>

                <div class="input-group-icon">
                    <input type="email" class="form-control" name="email" placeholder="Email" required>
                    <i class='bx bx-envelope'></i>
                    <div class="invalid-feedback">Please enter a valid email address.</div>
                </div>

                <div class="input-group-icon">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password"
                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}" 
                        title="Must contain at least one uppercase letter, one lowercase letter, one number, one special character and minimum 8 characters"
                        required>
                    <i class='bx bx-lock-alt'></i>
                    <div class="invalid-feedback">Password does not meet requirements.</div>
                </div>

                <div class="input-group-icon">
                    <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm Password" required>
                    <i class='bx bx-lock-alt'></i>
                    <div class="invalid-feedback" id="confirmPasswordFeedback">Passwords do not match.</div>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="termsCheck" required>
                    <label class="form-check-label" for="termsCheck">
                        I agree to the <a href="#">Terms & Conditions</a>
                    </label>
                    <div class="invalid-feedback">You must agree before submitting.</div>
                </div>

                <button type="submit" class="btn btn-submit">Register</button>
            </form>
        </div>

    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Bootstrap form validation
    (() => {
        'use strict'
        const form = document.getElementById('signupForm');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const confirmPasswordFeedback = document.getElementById('confirmPasswordFeedback');

        form.addEventListener('submit', function (event) {
            // Reset custom validation
            confirmPassword.setCustomValidity('');
            confirmPasswordFeedback.style.display = 'none';

            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match');
                confirmPasswordFeedback.style.display = 'block';
            }

            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        }, false);
    })();
</script>

<%@ include file="footer.jsp" %>

</body>
</html>
