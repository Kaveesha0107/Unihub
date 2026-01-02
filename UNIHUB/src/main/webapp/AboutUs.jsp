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
	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - UniHub</title>
    <style>
    
    /*===== Header ===== */
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
	font-size: 24px;
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
    
    /* ===== Header end ===== */
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

      body {
    background-color: linear-gradient(135deg, #f0f8ff, #e0f7fa); /* light gray background */
    color: #333; /* dark gray text for readability */
    line-height: 1.6;
}

    
        /* Hero Section */
        .hero {
            background-image: url('image/about-us.png');
            background-size: cover;
            background-position: center;
            height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            position: relative;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 800px;
            padding: 0 20px;
        }

        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 50px 20px;
        }

        .section-title {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #1a2a6c;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(to right, #1a2a6c, #b21f1f, #fdbb2d);
        }

        .mission-vision {
            display: flex;
            justify-content: space-between;
            margin: 40px 0;
            gap: 30px;
        }

        .mission, .vision {
            flex: 1;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .mission:hover, .vision:hover {
            transform: translateY(-10px);
        }

        .mission h3, .vision h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: #1a2a6c;
            text-align: center;
        }

        /* Features Section */
        .features {
            margin: 60px 0;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .feature-card {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #1a2a6c;
        }

        .feature-card h3 {
            font-size: 1.3rem;
            margin-bottom: 15px;
            color: #1a2a6c;
        }

        /* User Roles Section */
        .user-roles {
            margin: 60px 0;
        }

        .roles-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .role-card {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .role-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .role-card h3 {
            font-size: 1.3rem;
            margin-bottom: 15px;
            color: #1a2a6c;
            text-align: center;
        }

        .role-card ul {
            padding-left: 20px;
        }

        .role-card ul li {
            margin-bottom: 8px;
        }

        /* Team Section */
        .team-section {
            margin: 60px 0;
            text-align: center;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .team-member {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .member-img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        .member-info {
            padding: 20px;
        }

        .member-info h3 {
            font-size: 1.2rem;
            margin-bottom: 5px;
            color: #1a2a6c;
        }

        .member-info p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

       
        /* Responsive Design */
        @media (max-width: 768px) {
            .mission-vision {
                flex-direction: column;
            }

            .header-container {
                flex-direction: column;
                text-align: center;
            }

            nav ul {
                margin-top: 20px;
            }

            .hero h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body id="body">
  
    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>About UniHub</h1>
            <p>Connecting Students with Universities Across Sri Lanka</p>
        </div>
    </section>

    <!-- Main Content -->
    <div class="main-content">
        <!-- About Us Introduction -->
        <section>
            <h2 class="section-title">Who We Are</h2>
            <p>UniHub is Sri Lanka's premier centralized university customer care system, designed to bridge the communication gap between students and higher education institutions across the country. Founded with a vision to transform student support services, our platform serves as a unified hub where students can easily connect with university representatives and get the information they need, when they need it.</p>
            
            <div class="mission-vision">
                <div class="mission">
                    <h3>Our Mission</h3>
                    <p>To streamline communication between students and universities through an efficient, transparent and user-friendly digital platform that ensures every query is addressed promptly and accurately, enhancing the overall higher education experience in Sri Lanka.</p>
                </div>
                <div class="vision">
                    <h3>Our Vision</h3>
                    <p>To become the definitive digital support infrastructure for Sri Lanka's higher education sector, empowering students with seamless access to information and fostering a more connected, responsive educational ecosystem across the nation.</p>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features">
            <h2 class="section-title">What We Offer</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">📝</div>
                    <h3>Centralized Support System</h3>
                    <p>A single platform connecting students with all universities in Sri Lanka, eliminating the need to navigate multiple channels for information.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🎓</div>
                    <h3>Dedicated University Agents</h3>
                    <p>Each university has dedicated agents who provide accurate, institution-specific guidance and support.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔍</div>
                    <h3>Transparent Communication</h3>
                    <p>Track the status of your inquiries in real-time and maintain a record of all communications for future reference.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📚</div>
                    <h3>Comprehensive Knowledge Base</h3>
                    <p>Access a wealth of information through our regularly updated FAQs and help center articles.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔒</div>
                    <h3>Secure Platform</h3>
                    <p>Your personal information and communications are protected by robust security measures.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Quick Response Times</h3>
                    <p>Our structured ticket system ensures your questions receive timely and accurate responses.</p>
                </div>
            </div>
        </section>

        <!-- User Roles Section -->
        <section class="user-roles">
            <h2 class="section-title">How UniHub Works</h2>
            <p>Our platform serves different users with tailored features and capabilities:</p>
            
            <div class="roles-container">
                <div class="role-card">
                    <h3>For Unregistered Students</h3>
                    <ul>
                        <li>Register on the platform with ease</li>
                        <li>Browse through the Help Center articles</li>
                        <li>Access Frequently Asked Questions</li>
                        <li>Learn about Sri Lankan universities</li>
                    </ul>
                </div>
                <div class="role-card">
                    <h3>For Registered Students</h3>
                    <ul>
                        <li>Select your preferred university</li>
                        <li>Submit support tickets directly to campus agents</li>
                        <li>Track ticket status in real-time</li>
                        <li>Provide additional information when needed</li>
                        <li>Update account details</li>
                        <li>Close tickets once resolved</li>
                    </ul>
                </div>
                <div class="role-card">
                    <h3>For University Agents</h3>
                    <ul>
                        <li>Manage assigned tickets efficiently</li>
                        <li>Update ticket status (Open, In-progress, Resolved)</li>
                        <li>Communicate directly with students</li>
                        <li>Contribute to FAQ sections</li>
                        <li>Provide institution-specific information</li>
                    </ul>
                </div>
                <div class="role-card">
                    <h3>For System Administrators</h3>
                    <ul>
                        <li>Manage university agent accounts</li>
                        <li>Oversee user account management</li>
                        <li>Update system-wide FAQs</li>
                        <li>Perform data backups</li>
                        <li>Monitor system health</li>
                        <li>Troubleshoot technical issues</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Team Section -->
        <section class="team-section">
            <h2 class="section-title">Our Leadership Team</h2>
            <p>The dedicated professionals behind UniHub's success:</p>
            
            <div class="team-grid">
                <div class="team-member">
                    <img src="image/d.jpg" alt="Team Member" class="member-img">
                    <div class="member-info">
                        <h3>Dinusha Sampath</h3>
                        <p>Chief Executive Officer</p>
                        <p>Former university administrator with 15+ years of experience in higher education management.</p>
                    </div>
                </div>
                <div class="team-member">
                    <img src="image/a.jpg" alt="Team Member" class="member-img">
                    <div class="member-info">
                        <h3>Amaya Perera</h3>
                        <p>Chief Technology Officer</p>
                        <p>Technology expert with extensive experience in developing educational platforms.</p>
                    </div>
                </div>
                <div class="team-member">
                    <img src="image/amaya.avif" alt="Team Member" class="member-img">
                    <div class="member-info">
                        <h3>Muthu Gamage</h3>
                        <p>Head of University Relations</p>
                        <p>Building strong partnerships with all universities across Sri Lanka.</p>
                    </div>
                </div>
                <div class="team-member">
                    <img src="image/s.jpg" alt="Team Member" class="member-img">
                    <div class="member-info">
                        <h3>Supun Jayakody</h3>
                        <p>Student Experience Director</p>
                        <p>Focused on optimizing the platform for student needs and satisfaction.</p>
                    </div>
                </div>
            </div>
        </section>
    </div>

   
	<%@ include file="footer.jsp"%>
   
</body>
</html>