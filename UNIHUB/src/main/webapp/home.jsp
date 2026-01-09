<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:choose>
  <c:when test="${not empty sessionScope.role and sessionScope.role == 'user'}">
    <jsp:include page="loggedUserHeader.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="header.jsp" />
  </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="en">
<head>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UniHub - Sri Lanka's University Information Platform</title>
<style>
/* Modern Reset and Base Styles */
:root {
  --primary-color: #4361ee;
  --secondary-color: #3f37c9;
  --accent-color: #4cc9f0;
  --dark-color: #1a1a2e;
  --light-color: #f8f9fa;
  --success-color: #4caf50;
  --warning-color: #ff9800;
  --danger-color: #f44336;
  --text-color: #333;
  --text-light: #6c757d;
  --white: #ffffff;
  --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
  --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
  --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
  --shadow-xl: 0 20px 25px rgba(0,0,0,0.1);
  --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  --gradient-primary: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
}


/* ===== Header ===== */
	
	        body {
	            margin: 0;
	            font-family: 'Segoe UI', sans-serif;
	            background-color: #f4f6f8;
	        }
	
	       
	        .header {
	            background:white;
	            position: sticky;
	            top: 0;
	            z-index: 1000;
	            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	        }
	
	        .navbar {
	            max-width: 1200px;
	            margin: 0 auto;
	            padding: 18px 20px;
	            display: flex;
	            align-items: center;
	            justify-content: space-between;
	            flex-wrap: wrap;
	        }
		
		    .logo {
				display: flex;
				align-items: center;
				animation: fadeIn 1s ease-out;
			}
			
			.logo h1 {
				font-size: 30px;
				font-weight: 700;
				color: #2c3e50;
			}
			
			.logo span {
				color: #3498db;
				position: relative;
			}
		
		.logo span::after {
			content: '';
			position: absolute;
			bottom: -3px;
			left: 0;
			width: 100%;
			height: 2px;
			background-color: #3498db;
			transform: scaleX(0);
			transition: transform 0.3s ease-out;
			transform-origin: bottom right;
		}
		
		.logo:hover span::after {
			transform: scaleX(1);
			transform-origin: bottom left;
		}

        .menu-toggle {
            display: none;
            font-size: 30px;
            color: black;
            background: none;
            border: none;
            cursor: pointer;
		        }
		.nav-links-container {
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    gap: 20px;
		}
		
		.nav-links ul {
		    list-style: none;
		    display: flex;
		    gap: 18px;
		    margin: 0;
		    padding: 0;
		}
		
		.nav-links ul li a {
		    position: relative;
		    text-decoration: none;
		    color: black;
		    font-weight: 500;
		    padding: 8px 14px;
		    border-radius: 6px;
		    transition: color 0.3s ease;
		}
		
		.nav-links ul li a::after {
		    content: '';
		    position: absolute;
		    left: 0;
		    bottom: 0;
		    width: 100%;
		    height: 2px;
		    background-color: #3498db;
		    transform: scaleX(0);
		    transform-origin: bottom right;
		    transition: transform 0.3s ease;
		}
		
		.nav-links ul li a:hover::after,
		.nav-links ul li a.active::after {
		    transform: scaleX(1);
		    transform-origin: bottom left;
		}
		
		.nav-links ul li a:hover {
		    color: #3498db;
		}
/*login & sign up*/
        .auth-links {
            display: flex;
            gap: 10px;
        }

        .auth-links a {
            padding: 8px 14px;
            border: 2px solid black;
            border-radius: 6px;
            text-decoration: none;
            color: black;
            font-weight: 600;
            transition: 0.3s;
        }

        .auth-links a:hover {
            background-color: #013866 ;
            color: white;
        }

        /* Responsive Styling */
        @media (max-width: 768px) {
            .menu-toggle {
                display: block;
            }

            .nav-links-container {
                display: none;
                width: 100%;
                flex-direction: column;
                background-color: #eceef1 ;
                margin-top: 10px;
                border-radius: 0 0 10px 10px;
            }

            .nav-links-container.active {
                display: flex;
                padding: 10px 0;
            }

            .nav-links ul {
                flex-direction: column;
                width: 100%;
                text-align: center;
            }

            .auth-links {
                flex-direction: column;
                width: 100%;
                align-items: center;
                padding-top: 10px;
            }

            .auth-links a {
                width: 90%;
                text-align: center;
            }
        }

  /* ===== finish Header ===== */    

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Poppins', sans-serif;
  color: var(--text-color);
  line-height: 1.7;
  background-color: var(--light-color);
  overflow-x: hidden;
}

a {
  text-decoration: none;
  color: inherit;
  transition: var(--transition);
}

/* Animation Keyframes */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slideUp {
  from { 
    transform: translateY(30px);
    opacity: 0;
  }
  to { 
    transform: translateY(0);
    opacity: 1;
  }
}

@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

@keyframes float {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-15px); }
  100% { transform: translateY(0px); }
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-20px); }
}

@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

@keyframes gradientBG {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* Container */
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

/* Hero Section */
.hero {
  background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('./image/st2.jpg') no-repeat center center;
  background-size: cover;
  color: var(--white);
  padding: 150px 0;
  position: relative;
  overflow: hidden;
  justify-content: center;
  animation: pulse 13s infinite ease-in-out;
  
}

.hero-content {
  position: relative;
  z-index: 2;
  max-width: 650px;
  animation: slideUp 1s ease-out;
  
  
}

.hero h2 {
  font-size: 48px;
  font-weight: 700;
  margin-bottom: 20px;
  line-height: 1.2;
  
  
}

.hero p {
  font-size: 18px;
  margin-bottom: 30px;
  opacity: 0.9;
}

.hero-buttons {
  display: flex;
  gap: 20px;
  margin-top: 30px;
}

.hero-btn {
  padding: 15px 30px;
  border-radius: 50px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: var(--transition);
  position: relative;
  overflow: hidden;
  z-index: 1;
}

.hero-btn-primary {
  background: var(--primary-color);
  color: var(--white);
  border: none;
  box-shadow: 0 5px 15px rgba(67, 97, 238, 0.4);
}

.hero-btn-primary:hover {
  background: var(--secondary-color);
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(67, 97, 238, 0.5);
}

.hero-btn-secondary {
  background: transparent;
  color: var(--white);
  border: 2px solid var(--white);
}

.hero-btn-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-5px);
  box-shadow: 0 5px 15px rgba(255, 255, 255, 0.1);
}

.scroll-indicator {
  position: absolute;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  width: 30px;
  height: 50px;
  border: 2px solid var(--white);
  border-radius: 15px;
  opacity: 0.8;
  animation: fadeIn 1s ease-out forwards;
  animation-delay: 1.5s;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding-top: 10px;
  z-index: 10;
}

.scroll-indicator::before {
  content: '';
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background-color: var(--white);
  animation: scrollDown 2s infinite;
}

@keyframes scrollDown {
  0% { transform: translateY(0); opacity: 1; }
  100% { transform: translateY(20px); opacity: 0; }
}

/* Features Section */
.features {
  padding: 100px 0;
  background-color: var(--white);
}

.section-heading {
  text-align: center;
  margin-bottom: 60px;
  animation: fadeIn 1s ease-out;
}

.section-heading h2 {
  font-size: 36px;
  color: var(--dark-color);
  margin-bottom: 15px;
  position: relative;
  display: inline-block;
}
.section-heading h2::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 4px;
  background-color: var(--primary-color);
  border-radius: 2px;
}

.section-heading p {
  color: var(--text-light);
  font-size: 18px;
  max-width: 700px;
  margin: 0 auto;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

.feature-card {
  background-color: white;
  border-radius: 15px;
  padding: 40px 30px;
  text-align: center;
  transition: var(--transition);
  position: relative;
  overflow: hidden;
  z-index: 1;
  box-shadow: var(--shadow-sm);
  opacity: 0;
  transform: translateY(20px);
  animation: slideUp 0.5s ease-out forwards;
  animation-delay: calc(var(--card-index) * 0.1s);
}

.feature-card:hover {
  transform: translateY(-10px) !important;
  box-shadow: var(--shadow-lg);
}

.feature-icon {
  font-size: 50px;
  margin-bottom: 25px;
  color: var(--primary-color);
  transition: var(--transition);
}

.feature-card:hover .feature-icon {
  animation: bounce 1s ease infinite;
}

.feature-card h3 {
  font-size: 22px;
  margin-bottom: 15px;
  color: var(--dark-color);
}

.feature-card p {
  color: var(--text-light);
}

/* Universities Section */
.universities {
  padding: 100px 0;
  background-color: var(--light-color);
}

.uni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 30px;
  margin-top: 40px;
}

.uni-card {
  background-color: var(--white);
  border-radius: 15px;
  overflow: hidden;
  box-shadow: var(--shadow-sm);
  text-align: center;
  transition: var(--transition);
  opacity: 0;
  transform: translateY(20px);
  animation: slideUp 0.5s ease-out forwards;
  animation-delay: calc(var(--card-index) * 0.1s);
  position: relative;
  z-index: 1;
}

.uni-card:hover {
  transform: translateY(-10px) !important;
  box-shadow: var(--shadow-lg);
}

.uni-img {
  height: 150px;
  background-color: #f1f1f1;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  position: relative;
}

.uni-img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: var(--transition);
}

.uni-card:hover .uni-img img {
  transform: scale(1.1);
}

.uni-name {
  padding: 20px;
  font-weight: 600;
  color: var(--dark-color);
  position: relative;
}

.uni-name::after {
  content: '';
  position: absolute;
  bottom: 10px;
  left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 3px;
  background: var(--primary-color);
  transition: var(--transition);
}

.uni-card:hover .uni-name::after {
  width: 50px;
}

/* How It Works Section */
.how-it-works {
  padding: 100px 0;
  background-color: var(--white);
}

.steps {
  display: flex;
  justify-content: space-between;
  margin-top: 50px;
  flex-wrap: wrap;
}

.step {
  flex: 1;
  min-width: 250px;
  text-align: center;
  padding: 0 20px;
  position: relative;
  margin-bottom: 30px;
  opacity: 0;
  transform: translateY(20px);
  animation: slideUp 0.5s ease-out forwards;
  animation-delay: calc(var(--step-index) * 0.2s);
}

.step:not(:last-child)::after {
  content: '→';
  position: absolute;
  right: -10px;
  top: 30px;
  font-size: 30px;
  color: #bdc3c7;
  animation: fadeIn 1s ease-out forwards;
  animation-delay: 1s;
}

.step-number {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  color: var(--white);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  font-weight: 700;
  margin: 0 auto 20px;
  transition: var(--transition);
  position: relative;
  z-index: 1;
  box-shadow: 0 5px 20px rgba(67, 97, 238, 0.3);
}

.step-number::before {
  content: '';
  position: absolute;
  top: -5px;
  left: -5px;
  right: -5px;
  bottom: -5px;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  border-radius: 50%;
  z-index: -1;
  opacity: 0;
  transform: scale(0.8);
  transition: var(--transition);
}

.step:hover .step-number {
  transform: scale(1.1);
}

.step:hover .step-number::before {
  opacity: 0.5;
  transform: scale(1.2);
}

.step h3 {
  margin-bottom: 15px;
  color: var(--dark-color);
  font-size: 20px;
}

.step p {
  color: var(--text-light);
}
.scroll-down-indicator {
  font-size: 2rem;
  text-align: center;
  animation: bounce 1.5s infinite;
  color: #007bff;
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(10px); }
}

/* Image Showcase Section */
.image-showcase {
  padding: 100px 0;
  background-color: var(--light-color);
}

.image-showcase .section-heading h2 {
  color: var(--dark-color);
}

.image-showcase .section-heading p {
  color: var(--text-light);
}

.showcase-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  margin-top: 40px;
}

.showcase-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
  position: relative;
  height: 250px;
  opacity: 0;
  transform: translateY(20px);
  animation: slideUp 0.5s ease-out forwards;
  animation-delay: calc(var(--card-index) * 0.1s);
}

.showcase-card:hover {
  transform: translateY(-10px) !important;
  box-shadow: var(--shadow-lg);
}

.showcase-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: var(--transition);
}

.showcase-card:hover .showcase-img {
  transform: scale(1.1);
}

.showcase-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
  padding: 20px;
  color: var(--white);
  opacity: 0;
  transition: var(--transition);
}

.showcase-card:hover .showcase-overlay {
  opacity: 1;
}

/* CTA Section */
.cta {
  padding: 100px 0;
  background:#8fc1ec; 
  color: var(--white);
  text-align: center;
  position: relative;
  overflow: hidden;
}

.cta::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: url('image/stu1.jpg') no-repeat center center;
  background-size: cover;
  opacity: 0.1;
  animation: pulse 15s infinite ease-in-out;
}

.cta h2 {
color:#053862;
  font-size: 42px;
  margin-bottom: 20px;
  position: relative;
  animation: fadeIn 1s ease-out;
}

.cta p {
color: #053862;
  font-size: 18px;
  margin-bottom: 30px;
  max-width: 700px;
  margin-left: auto;
  margin-right: auto;
  position: relative;
  animation: fadeIn 1s ease-out;
  animation-delay: 0.2s;
}

.cta-buttons {
  display: flex;
  justify-content: center;
  gap: 20px;
  flex-wrap: wrap;
  position: relative;
  animation: fadeIn 1s ease-out;
  animation-delay: 0.4s;
}
.site-info {
  position: relative;
  background-image: url('image/custom.jpg');
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
  min-height: 500px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.info-overlay {
  background-color: rgba(0, 0, 0, 0.6); /* dark overlay for text readability */
  padding: 60px 20px;
  width: 100%;
  text-align: center;
}

.info-text {
  color: #fff;
  max-width: 800px;
  margin: 0 auto;
}

.info-text h2 {
  font-size: 32px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;
}

.info-text p {
  font-size: 18px;
  line-height: 1.8;
}

/* Floating Elements */
.floating {
  animation: float 6s ease-in-out infinite;
}

/* Responsive Styles */
@media (max-width: 992px) {
  .hero h2 {
    font-size: 36px;
  }
  
  .steps {
    flex-direction: column;
    align-items: center;
  }
  
  .step:not(:last-child)::after {
    content: '↓';
    right: auto;
    top: auto;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
  }
}

@media (max-width: 768px) {
 
  .hero {
    padding: 100px 0;
    text-align: center;
  }
  
  .hero-content {
    margin: 0 auto;
  }
  
  .hero-buttons {
    justify-content: center;
  }
  
  .section-heading h2 {
    font-size: 30px;
  }
  

}

@media (max-width: 576px) {
  .hero h2 {
    font-size: 28px;
  }
  
  .hero p {
    font-size: 16px;
  }
  
  .hero-buttons {
    flex-direction: column;
    gap: 15px;
  }
  
  .btn, .hero-btn {
    width: 100%;
  }

}

/* Custom Scrollbar */
::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: var(--light-color);
}

::-webkit-scrollbar-thumb {
  background: var(--primary-color);
  border-radius: 5px;
}

::-webkit-scrollbar-thumb:hover {
  background: var(--secondary-color);
}
</style>
</head>
<body>

	<!-- Hero section -->
	<section class="hero" >
		<div class="container">
			<div class="hero-content">
				<h2>Welcome to UniHub</h2>
				<h2>Your Gateway to Sri Lankan Higher Education</h2>
				<p>UniHub connects students with universities across Sri Lanka, providing accurate information, direct communication with representatives, and all the resources you need to make informed decisions about your academic future.</p>
				<div class="hero-buttons">
					<a href="signup.jsp" class="hero-btn hero-btn-primary">Get Started</a>
					<a href="#how-it-works" class="hero-btn hero-btn-secondary">Learn More</a>
				</div>
			</div>
			<div class="scroll-down-indicator">&#x21E9;</div>

		</div>
	</section>
	<section class="site-info">
  <div class="info-overlay">
    <div class="info-text">
      <h2>
        <img src="image/cap.png" style="width: 60px; vertical-align: middle; margin-right: 10px;">
        Your Gateway to University Support
      </h2>
      <p>
		Welcome to UniHub – Your Trusted University Support Partner
		UniHub is a smart and student-friendly platform designed to bridge the gap 
		between students and universities. Whether you're exploring study options, 
		need help with admissions, or have questions about campus life, UniHub connects you
		with the right campus agents instantly. With real-time ticketing, fast responses, and personalized 
		assistance, we make university guidance simple, efficient, and stress-free.
	 </p>
    </div>
  </div>
</section>

	<!-- Features section -->
	<section class="features" id="features">
		<div class="container">
			<div class="section-heading">
				<h2>Why Choose UniHub?</h2>
				<p>Our platform revolutionizes the way students connect with universities in Sri Lanka</p>
			</div>
			<div class="features-grid">
				<div class="feature-card" style="--card-index: 1">
					<div class="feature-icon">
						<i class="fas fa-university"></i>
					</div>
					<h3>Direct University Access</h3>
					<p>Connect directly with official representatives from all major Sri Lankan universities through a single platform.</p>
				</div>
				<div class="feature-card" style="--card-index: 2">
					<div class="feature-icon">
						<i class="fas fa-check-circle"></i>
					</div>
					<h3>Verified Information</h3>
					<p>Get accurate, up-to-date answers to your questions directly from university officials.</p>
				</div>
				<div class="feature-card" style="--card-index: 3">
					<div class="feature-icon">
						<i class="fas fa-tasks"></i>
					</div>
					<h3>Application Tracking</h3>
					<p>Monitor the status of your inquiries and applications in real-time with our tracking system.</p>
				</div>
				<div class="feature-card" style="--card-index: 4">
					<div class="feature-icon">
						<i class="fas fa-book-open"></i>
					</div>
					<h3>Comprehensive Resources</h3>
					<p>Access our extensive library of guides, articles, and FAQs about Sri Lankan higher education.</p>
				</div>
				<div class="feature-card" style="--card-index: 5">
					<div class="feature-icon">
						<i class="fas fa-shield-alt"></i>
					</div>
					<h3>Secure Platform</h3>
					<p>Your personal information and communications are protected with enterprise-grade security.</p>
				</div>
				<div class="feature-card" style="--card-index: 6">
					<div class="feature-icon">
						<i class="fas fa-mobile-alt"></i>
					</div>
					<h3>Mobile Friendly</h3>
					<p>Access UniHub anytime, anywhere with our fully responsive design that works on all devices.</p>
				</div>
			</div>
		</div>
	</section>

	<!-- Universities section -->
	<section class="universities" id="universities">
		<div class="container">
			<div class="section-heading">
				<h2>Partner Universities</h2>
				<p>Connect with representatives from leading universities across Sri Lanka</p>
			</div>
			<div class="uni-grid">
				<div class="uni-card" style="--card-index: 1">
					<div class="uni-img">
						<img src="image/SLIIT.jpg" alt="SLIIT">
					</div>
					<div class="uni-name">Sri Lanka Institute of Information Technology</div>
				</div>
				<div class="uni-card" style="--card-index: 2">
					<div class="uni-img">
						<img src="image/4-NSBM.jpg" alt="NSBM">
					</div>
					<div class="uni-name">NSBM Green University</div>
				</div>
				<div class="uni-card" style="--card-index: 3">
					<div class="uni-img">
						<img src="image/iit.jpg" alt="IIT">
					</div>
					<div class="uni-name">Informatics Institute of Technology</div>
				</div>
				<div class="uni-card" style="--card-index: 4">
					<div class="uni-img">
						<img src="image/cinec.jpg" alt="CINEC">
					</div>
					<div class="uni-name">CINEC Campus</div>
				</div>
				<div class="uni-card" style="--card-index: 5">
					<div class="uni-img">
						<img src="image/apiit.jpeg" alt="APIIT">
					</div>
					<div class="uni-name">Asia Pacific Institute of Technology</div>
				</div>
				<div class="uni-card" style="--card-index: 6">
					<div class="uni-img">
						<img src="image/icbt.jpeg" alt="ICBT">
					</div>
					<div class="uni-name">ICBT Campus</div>
				</div>
				<div class="uni-card" style="--card-index: 7">
					<div class="uni-img">
						<img src="image/NIBM.jpg" alt="NIBM">
					</div>
					<div class="uni-name">National Institute of Business Management</div>
				</div>
				<div class="uni-card" style="--card-index: 8">
					<div class="uni-img">
						<img src="image/esof.jpg" alt="esof">
					</div>
					<div class="uni-name">ESOFT Metro Campus</div>
				</div>
				<div class="uni-card" style="--card-index: 9">
					<div class="uni-img">
						<img src="image/ANC.jpg" alt="anc">
					</div>
					<div class="uni-name">American National College (ANC)</div>
				</div>
				<div class="uni-card" style="--card-index: 10">
					<div class="uni-img">
						<img src="image/linc.jpg" alt="linc">
					</div>
					<div class="uni-name">Lincoln University College </div>
				</div>
			
			</div>
		</div>
	</section>

	<!-- How it works section -->
	<section class="how-it-works" id="how-it-works">
		<div class="container">
			<div class="section-heading">
				<h2>How UniHub Works</h2>
				<p>Getting the information you need is simple with our streamlined process</p>
			</div>
			<div class="steps">
				<div class="step" style="--step-index: 1">
					<div class="step-number">1</div>
					<h3><i class="fas fa-user-plus"></i> Create Account</h3>
					<p>Sign up for your free UniHub account in just a few minutes.</p>
				</div>
				<div class="step" style="--step-index: 2">
					<div class="step-number">2</div>
					<h3><i class="fas fa-search"></i> Find Your University</h3>
					<p>Browse our comprehensive directory of Sri Lankan universities.</p>
				</div>
				<div class="step" style="--step-index: 3">
					<div class="step-number">3</div>
					<h3><i class="fas fa-question-circle"></i> Ask Questions</h3>
					<p>Submit your inquiries directly to university representatives.</p>
				</div>
				<div class="step" style="--step-index: 4">
					<div class="step-number">4</div>
					<h3><i class="fas fa-comments"></i> Get Responses</h3>
					<p>Receive official answers from university staff in your dashboard.</p>
				</div>
			</div>
		</div>
	</section>



	<!-- CTA section -->
	<section class="cta">
		<div class="container">
			<h2>Ready to Start Your University Journey?</h2>
			<p>Join thousands of students who are making informed decisions about their education through UniHub. Create your free account today and take the first step toward your academic future.</p>
			<div class="cta-buttons">
				<a href="signup.jsp" class="hero-btn hero-btn-primary">Get Started Now</a>
				
			</div>
		</div>
	</section>



	<!-- JavaScript for animations -->
	<script>
        // Initialize animations when elements come into view
        document.addEventListener('DOMContentLoaded', function() {
            // Set up feature card animations
            const featureCards = document.querySelectorAll('.feature-card');
            for(let i = 0; i < featureCards.length; i++) {
                featureCards[i].style.setProperty('--card-index', i + 1);
            }
            
            // Set up university card animations
            const uniCards = document.querySelectorAll('.uni-card');
            for(let i = 0; i < uniCards.length; i++) {
                uniCards[i].style.setProperty('--card-index', i + 1);
            }
            
            // Set up step animations
            const steps = document.querySelectorAll('.step');
            for(let i = 0; i < steps.length; i++) {
                steps[i].style.setProperty('--step-index', i + 1);
            }
           
            // Intersection Observer for scroll-based animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = 1;
                        entry.target.style.transform = 'translateY(0)';
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.1 });
            
            
            // Observe all animated elements
            document.querySelectorAll('.feature-card, .uni-card, .step, .animated-image').forEach(el => {
                observer.observe(el);
            });
        });
        //navbar
        function toggleMenu() {
            document.getElementById("navLinks").classList.toggle("active");
        }
    </script>
  
    <%@ include file="footer.jsp" %>
</body>
</html>