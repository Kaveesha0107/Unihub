<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UniHub - Home</title>
    <style>
       
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
        display: none; /* Hidden by default */
        font-size: 30px;
        color: black;
        background: none;
        border: none;
        cursor: pointer;
        padding: 5px 10px;
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
            display: block; /* Only visible on mobile */
        }
        
       
        .menu-toggle {
            z-index: 1001;
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

        
    </style>
</head>
<body>

    <!-- ===== Header ===== -->
    <div class="header">
        <div class="navbar">
            <div class="logo">
            
				<h1>
					Uni<span>Hub</span>
				</h1>
			</div>
          <button class="menu-toggle" onclick="toggleMenu()">&#9776;</button>

            <div class="nav-links-container" id="navLinks">
                <div class="nav-links">
                    <ul>
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="faqs.jsp">FAQs</a></li>
                        <li><a href="readArticles">Articles</a></li>
                        <li><a href="AboutUs.jsp">About</a></li>
                        <li><a href="contactus.jsp">Contact Us</a></li>
                    </ul>
                </div>
                <div class="auth-links">
                    <a href="login.jsp">Login</a>
                    <a href="signup.jsp">Sign Up</a>
                </div>
            </div>
        </div>
    </div>
	

   
    <script>
        function toggleMenu() {
            document.getElementById("navLinks").classList.toggle("active");
        }
    </script>
</body>
</html>
