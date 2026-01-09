<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when
		test="${not empty sessionScope.role and sessionScope.role == 'user'}">
		<jsp:include page="loggedUserHeader.jsp" />
	</c:when>
	<c:otherwise>
		<jsp:include page="header.jsp" />
	</c:otherwise>
</c:choose>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>unihub</title>
<link rel="icon" type="image/png" href="logo.png">
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
}

.container {
	width: 80%;
	margin: auto;
	max-width: 1000px;
	padding: 20px;
	margin-top: 140px;
	margin-bottom: 50px;
}

h1 {
	text-align: center;
	margin-bottom: 30px;
	font-size: 2.5em;
	color: #023e8a;
}

p {
	font-size: 1em;
	color: #000000;
}

.terms-section {
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
	margin-top: 50px;
}

.term-item {
	margin-bottom: 20px;
}

.term-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
	border: 1px solid #a796e9;
	background-color: #fafafa;
	border-radius: 5px;
}

.term-header h2 {
	font-size: 1.5em;
	color: #023e8a;
	margin: 0;
}

.term-content {
	display: none;
	margin-top: 10px;
	padding-left: 10px;
	color: #000000;
}

.toggle-btn {
	font-size: 1.5em;
	cursor: pointer;
	background: none;
	border: none;
	color: #001c32;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="container">
		<h1>Terms and Conditions</h1>

		<div class="terms-section">
			<div class="term-item">
				<div class="term-header">
					<h2>1. Introduction</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">Welcome to UniHub! These Terms and
					Conditions govern your access to and use of our platform. UniHub is
					an online customer care system designed to facilitate communication
					between students and university agents across Sri Lanka. By using
					this service, you agree to adhere to these terms, which help ensure
					a safe, respectful, and efficient support environment for all
					users.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>2. Acceptance of Terms</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">By accessing or using UniHub, you
					acknowledge that you have read, understood, and agree to comply
					with these Terms and Conditions. This agreement is legally binding.
					If you do not agree with any part of these terms, you must
					discontinue use of the platform.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>3. Service Description</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">UniHub enables students to register,
					select their university, and submit support tickets for assistance.
					University agents manage and respond to these tickets. The system
					also offers access to FAQs, helpful articles, and an administrative
					panel for system oversight. This ensures transparent, efficient
					support across all participating universities.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>4. User Responsibilities</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">Users are responsible for providing
					accurate and up-to-date information when registering, submitting
					tickets, or responding to communications. Students and agents must
					communicate respectfully and use the system only for legitimate
					academic and support-related purposes. Any misuse of the platform
					may result in account suspension or termination.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>5. Prohibited Activities</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">Users must not engage in abusive
					behavior, submit false or misleading information, attempt to
					exploit the system, or disrupt operations. UniHub reserves the
					right to suspend or ban users who violate these rules or compromise
					the safety and integrity of the platform.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>6. Intellectual Property Rights</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">All content and software related to
					UniHub, including logos, text, design, and code, are the
					intellectual property of UniHub or its licensors. You may not copy,
					reuse, or redistribute any part of the platform without written
					permission.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>7. Disclaimers</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">While UniHub strives to provide accurate
					information and reliable services, we do not guarantee error-free
					operation or uninterrupted access. Information shared through
					support tickets or articles is meant for general guidance and may
					not replace official university decisions or policies.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>8. Limitation of Liability</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">UniHub is not liable for any direct or
					indirect damages arising from the use or inability to use the
					platform. Users assume full responsibility for decisions made based
					on support responses or content provided within the system.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>9. Privacy Policy</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">UniHub is committed to protecting your
					personal information. We collect only necessary data to operate the
					platform and will not share it with third parties without consent,
					except as required by law. Refer to our full Privacy Policy for
					details.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>10. Governing Law</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">These Terms and Conditions are governed
					by the laws of the Democratic Socialist Republic of Sri Lanka. Any
					legal disputes shall be resolved within the jurisdiction of Sri
					Lankan courts.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>11. Amendments</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">UniHub reserves the right to update or
					revise these terms at any time. Users will be notified of major
					changes. Continued use of the platform after such changes signifies
					your acceptance of the updated Terms and Conditions.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>12. Termination</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">UniHub may suspend or terminate user
					access for violations of these terms or misuse of the platform.
					Affected users will be informed of the reason, and they may contact
					support to appeal the decision.</p>
			</div>

			<div class="term-item">
				<div class="term-header">
					<h2>13. Contact Information</h2>
					<button class="toggle-btn">+</button>
				</div>
				<p class="term-content">
					For any questions, feedback, or support, please contact us at:<br>
					Email: support@unihub.lk<br> Phone: +94 77 123 4567<br>
					Your feedback is important in helping us improve and maintain the
					quality of our service.
				</p>
			</div>
		</div>
		<p>Last updated: May 10, 2025</p>
	</div>
	<script>
    document.querySelectorAll('.toggle-btn').forEach(button => {
        button.addEventListener('click', function() {
            const content = this.parentElement.nextElementSibling;
            if (content.style.display === "none" || content.style.display === "") {
                content.style.display = "block";
                this.textContent = "−"; // Change to minus
            } else {
                content.style.display = "none";
                this.textContent = "+"; // Change to plus
            }
        });
    });
</script>

	<%@ include file="footer.jsp"%>
</body>
</html>