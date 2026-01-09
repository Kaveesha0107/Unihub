<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniHub - Frequently Asked Questions</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --light-color: #ecf0f1;
            --dark-color: #34495e;
            --success-color: #2ecc71;
        }
        
        /*header*/
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
        padding: 5px 10px;
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
        
        /* Make sure this z-index is higher than other elements */
        .menu-toggle {
            z-index: 1001;
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
        /* header end */
        

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

       
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .page-title {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--light-color);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-title h2 {
            font-size: 1.8rem;
            color: var(--primary-color);
        }

  		.h4 {
    color: var(--primary-color);
    margin-bottom: 20px; 
}


        .faq-categories {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .category-btn {
            padding: 8px 16px;
            background-color: var(--light-color);
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
        }

        .category-btn:hover, .category-btn.active {
            background-color: var(--secondary-color);
            color: white;
        }

        .faq-container {
            margin-bottom: 3rem;
        }

        .faq-section {
            margin-bottom: 2rem;
        }

        .faq-section h3 {
            font-size: 1.3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #eee;
        }

        .faq-item {
            margin-bottom: 1rem;
            border: 1px solid #eee;
            border-radius: 6px;
            overflow: hidden;
        }

        .faq-question {
            padding: 1rem;
            background-color: #f9f9f9;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .faq-question:hover {
            background-color: #f0f0f0;
        }

       .faq-item .faq-question:after {
    content: '+';
    font-size: 1.2rem;
    color: var(--secondary-color);
}

.faq-item .faq-question.active:after {
    content: '-';
     font-size: 1.2rem;
}

        .faq-answer {
            padding: 0;
            max-height: 0;
            overflow: hidden;
            transition: all 0.3s ease;
            background-color: white;
        }

        .faq-answer.active {
            padding: 1rem;
            max-height: 500px;
        }

        .faq-answer p {
            margin-bottom: 1rem;
        }

        .faq-answer p:last-child {
            margin-bottom: 0;
        }

        .faq-answer ul, .faq-answer ol {
            margin-left: 1.5rem;
            margin-bottom: 1rem;
        }

        .help-footer {
            text-align: center;
            margin-top: 2rem;
            padding: 1.5rem;
            background-color: #f9f9f9;
            border-radius: 6px;
        }

        .help-footer p {
            margin-bottom: 1rem;
        }

        .help-footer .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--secondary-color);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .help-footer .btn:hover {
            background-color: #2980b9;
        }




        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                gap: 1rem;
            }

            nav ul {
                gap: 1rem;
            }

            .container {
                padding: 1.5rem;
                width: 95%;
            }
        }
    </style>
</head>
<body>
<!-- header  -->
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
                       <li><a href="articles.jsp">Articles</a></li>
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
    <!-- header end  -->

    <div class="container">
        <div class="page-title">
            <h2>Frequently Asked Questions</h2>
        </div>

       <div>
            <h4>Choose a Topic to Get Help Fast<br></h4>
        </div>

        <div class="faq-categories">
            <button class="category-btn active">All</button>
            <button class="category-btn">Registration</button>
            <button class="category-btn">Student Support</button>
            <button class="category-btn">University Selection</button>
            <button class="category-btn">Tickets</button>
            <button class="category-btn">Account Management</button>
            <button class="category-btn">Technical Issues</button>
        </div>

        <div class="faq-container">
            <!-- Registration Section -->
            <div class="faq-section">
                <h3>Registration & Login</h3>
                
                <div class="faq-item">
                    <div class="faq-question">How do I register for a UniHub account?</div>
                    <div class="faq-answer">
                        <p>To register for a UniHub account:</p>
                        <ol>
                            <li>Visit the UniHub homepage</li>
                            <li>Click on the "Register" or "Sign Up" button</li>
                            <li>Fill in the required information (name, email, password, etc.)</li>
                            <li>Verify your email address through the confirmation link sent to your inbox</li>
                            <li>Complete your profile by adding additional information as prompted</li>
                        </ol>
                        <p>Once these steps are completed, you can log in and start using UniHub services.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">What information do I need to provide during registration?</div>
                    <div class="faq-answer">
                        <p>During registration, you'll need to provide:</p>
                        <ul>
                            <li>Full name</li>
                            <li>Valid email address (preferably your university email if you have one)</li>
                            <li>Password (must meet our security requirements)</li>
                            <li>Contact number (optional but recommended)</li>
                        </ul>
                        <p>After initial registration, you can complete your profile by adding:</p>
                        <ul>
                            <li>Student ID number (if applicable)</li>
                            <li>Your university of interest</li>
                            <li>Faculty/Department (optional)</li>
                            <li>Year of study (optional)</li>
                        </ul>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">I forgot my password. How can I reset it?</div>
                    <div class="faq-answer">
                        <p>To reset your password:</p>
                        <ol>
                            <li>Go to the login page</li>
                            <li>Click "Forgot Password" or "Reset Password" link</li>
                            <li>Enter your registered email address</li>
                            <li>Check your email for a password reset link</li>
                            <li>Click the link and follow instructions to create a new password</li>
                        </ol>
                        <p>The reset link is valid for 24 hours. If you don't receive the email, check your spam folder or request another reset link.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">Can I use UniHub without creating an account?</div>
                    <div class="faq-answer">
                        <p>Yes, you can access some features of UniHub without registration:</p>
                        <ul>
                            <li>Browse the public FAQ section</li>
                            <li>Read articles in the Help Center</li>
                            <li>View general information about universities</li>
                        </ul>
                        <p>However, to submit support tickets, communicate with university agents, or receive personalized assistance, you need to create an account and log in.</p>
                    </div>
                </div>
            </div>

            <!-- Student Support Section -->
            <div class="faq-section">
                <h3>Student Support</h3>
                
                <div class="faq-item">
                    <div class="faq-question">How do I submit a support ticket?</div>
                    <div class="faq-answer">
                        <p>To submit a support ticket:</p>
                        <ol>
                            <li>Log in to your UniHub account</li>
                            <li>Select your university from the dropdown menu</li>
                            <li>Click on "Create New Ticket" or "Ask a Question"</li>
                            <li>Choose the relevant category for your inquiry</li>
                            <li>Provide a clear subject line and detailed description of your question or issue</li>
                            <li>Attach any relevant documents if needed</li>
                            <li>Submit the ticket</li>
                        </ol>
                        <p>You'll receive a confirmation email with your ticket number, which you can use to track the status of your inquiry.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">How long does it take to get a response to my ticket?</div>
                    <div class="faq-answer">
                        <p>Our standard response time is within 24-48 hours for most inquiries. However, response times may vary depending on:</p>
                        <ul>
                            <li>The complexity of your question</li>
                            <li>The current volume of tickets being processed</li>
                            <li>University operating hours and holidays</li>
                        </ul>
                        <p>During peak periods (such as registration or exam seasons), response times might be slightly longer. You can always check the status of your ticket through your UniHub dashboard.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">Can I update my ticket after submission?</div>
                    <div class="faq-answer">
                        <p>Yes, you can update your ticket after submission. To do this:</p>
                        <ol>
                            <li>Log in to your UniHub account</li>
                            <li>Go to "My Tickets" or "Support History"</li>
                            <li>Find and select the ticket you want to update</li>
                            <li>Click "Add Reply" or "Add Information"</li>
                            <li>Enter your additional information or attach new documents</li>
                            <li>Submit the update</li>
                        </ol>
                        <p>Note that you cannot edit the original subject or category once a ticket is submitted, but you can provide clarifications or additional information through updates.</p>
                    </div>
                </div>
            </div>

            <!-- University Selection Section -->
            <div class="faq-section">
                <h3>University Selection</h3>
                
                <div class="faq-item">
                    <div class="faq-question">Which universities are available on UniHub?</div>
                    <div class="faq-answer">
                        <p>UniHub supports all state universities in Sri Lanka, including:</p>
                        <ul>
                            <li>SLIIT (Sri Lanka Institute of Information Technology)</li>
                            <li>NSBM Green Universitya</li>
                            <li>IIT (Informatics Institute of Technology)</li>
                            <li>CINEC Campus</li>
                            <li>APIIT (Asia Pacific Institute of IT)</li>
                            <li>ICBT Campus</li>
                            <li>ESOFT Metro Campus</li>
                            <li>Horizon Campus</li>
                            <li>Lincoln University College (Sri Lanka Campus)</li>
                            <li>American National College (ANC)</li>
                           
                        </ul>
                        <p>We also support several other higher education institutions including affiliated institutes and campuses.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">Can I change my selected university after registration?</div>
                    <div class="faq-answer">
                        <p>Yes, you can change your selected university at any time. Your university selection doesn't permanently link your account to that institution. Each time you create a new ticket, you'll be asked to select which university your inquiry is related to.</p>
                        <p>If you frequently interact with a particular university, it will be saved in your recent selections for quick access, but you're always free to select any university from the full list when submitting tickets.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">Can I submit tickets to multiple universities?</div>
                    <div class="faq-answer">
                        <p>Yes, you can submit tickets to different universities using the same UniHub account. When creating a new ticket, simply select the relevant university for that specific inquiry.</p>
                        <p>This is particularly useful if:</p>
                        <ul>
                            <li>You're considering applying to multiple universities</li>
                            <li>You're transferring between institutions</li>
                            <li>You need information about different universities for comparison</li>
                            <li>You're a parent or guardian inquiring on behalf of multiple students</li>
                        </ul>
                        <p>Your ticket history will organize your inquiries by university for easy reference.</p>
                    </div>
                </div>
            </div>

            <!-- Tickets Management Section -->
            <div class="faq-section">
                <h3>Ticket Management</h3>
                
                <div class="faq-item">
                    <div class="faq-question">What are the different ticket statuses and what do they mean?</div>
                    <div class="faq-answer">
                        <p>UniHub tickets can have the following statuses:</p>
                        <ul>
                            <li><strong>Open</strong>: Your ticket has been submitted but not yet assigned to or viewed by an agent.</li>
                            <li><strong>In Progress</strong>: An agent has been assigned to your ticket and is working on a response.</li>
                            <li><strong>Waiting for Information</strong>: The agent needs additional information from you to proceed.</li>
                            <li><strong>Resolved</strong>: Your issue has been addressed or your question has been answered.</li>
                            <li><strong>Closed</strong>: The ticket has been closed, either because the issue was resolved or due to inactivity.</li>
                            <li><strong>Reopened</strong>: A previously closed ticket has been reopened for further discussion.</li>
                        </ul>
                        <p>You can view the status of all your tickets in your UniHub dashboard.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">How do I close a resolved ticket?</div>
                    <div class="faq-answer">
                        <p>To close a ticket that has been resolved:</p>
                        <ol>
                            <li>Log in to your UniHub account</li>
                            <li>Go to "My Tickets" or "Support History"</li>
                            <li>Find and select the ticket you want to close</li>
                            <li>Click the "Close Ticket" button</li>
                            <li>Optionally, provide feedback about the resolution</li>
                            <li>Confirm the closure</li>
                        </ol>
                        <p>Note: If you don't manually close a resolved ticket, the system will automatically close it after 7 days of inactivity.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">Can I reopen a closed ticket?</div>
                    <div class="faq-answer">
                        <p>Yes, you can reopen a closed ticket within 30 days of closure. To reopen a ticket:</p>
                        <ol>
                            <li>Log in to your UniHub account</li>
                            <li>Go to "My Tickets" or "Support History"</li>
                            <li>Find the closed ticket you want to reopen</li>
                            <li>Click "Reopen Ticket"</li>
                            <li>Provide a reason for reopening</li>
                            <li>Submit the request</li>
                        </ol>
                        <p>For tickets closed for more than 30 days, we recommend creating a new ticket and referencing the previous ticket number if it's related to the same issue.</p>
                    </div>
                </div>
            </div>

            <!-- Technical Issues Section -->
            <div class="faq-section">
                <h3>Technical Issues</h3>
                
                <div class="faq-item">
                    <div class="faq-question">What browsers are supported by UniHub?</div>
                    <div class="faq-answer">
                        <p>UniHub is optimized for and fully compatible with the following browsers:</p>
                        <ul>
                            <li>Google Chrome (latest version and two previous versions)</li>
                            <li>Mozilla Firefox (latest version and two previous versions)</li>
                            <li>Microsoft Edge (latest version)</li>
                            <li>Safari (latest version)</li>
                            <li>Opera (latest version)</li>
                        </ul>
                        <p>For the best experience, we recommend using the latest version of Google Chrome or Mozilla Firefox.</p>
                        <p>Note: Internet Explorer is not supported.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">The website is loading slowly. What should I do?</div>
                    <div class="faq-answer">
                        <p>If you're experiencing slow loading times, try these troubleshooting steps:</p>
                        <ol>
                            <li>Check your internet connection</li>
                            <li>Clear your browser cache and cookies</li>
                            <li>Try using a different browser</li>
                            <li>Disable browser extensions that might be interfering</li>
                            <li>Try accessing the site during off-peak hours</li>
                        </ol>
                        <p>If the problem persists after trying these steps, please submit a technical support ticket with details about your device, browser, and the specific issues you're encountering.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">I can't upload files to my ticket. What's wrong?</div>
                    <div class="faq-answer">
                        <p>If you're having trouble uploading files, check the following:</p>
                        <ul>
                            <li><strong>File Size</strong>: Ensure your file doesn't exceed the 10MB limit per file</li>
                            <li><strong>File Format</strong>: Check that you're uploading an allowed file type (PDF, DOC, DOCX, JPG, PNG, TXT)</li>
                            <li><strong>Browser Issues</strong>: Try using a different browser or clear your cache</li>
                            <li><strong>Connection</strong>: Ensure you have a stable internet connection</li>
                        </ul>
                        <p>If you still can't upload files after checking these points, try compressing your file or splitting it into smaller parts. If the problem persists, please create a technical support ticket describing the issue in detail.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="help-footer">
            <p>Can't find what you're looking for? We're here to help!</p>
            <a href="contactus.jsp" class="btn">Contact Support</a>
        </div>
    </div>

  

    <script>
        // FAQ Accordion Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const questions = document.querySelectorAll('.faq-question');
            
            questions.forEach(question => {
                question.addEventListener('click', function() {
                    this.classList.toggle('active');
                    const answer = this.nextElementSibling;
                    answer.classList.toggle('active');
                });
            });

         

            // Category filter functionality
            const categoryBtns = document.querySelectorAll('.category-btn');
            
            categoryBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    // Remove active class from all buttons
                    categoryBtns.forEach(b => b.classList.remove('active'));
                    
                    // Add active class to clicked button
                    this.classList.add('active');
                    
                    // Get category name
                    const category = this.textContent.toLowerCase();
                    
                    // Show/hide relevant sections
                    const sections = document.querySelectorAll('.faq-section');
                    
                    if (category === 'all') {
                        sections.forEach(section => {
                            section.style.display = 'block';
                        });
                    } else {
                        sections.forEach(section => {
                            const sectionTitle = section.querySelector('h3').textContent.toLowerCase();
                            
                            if (sectionTitle.includes(category) || 
                                (category === 'registration' && sectionTitle.includes('login')) ||
                                (category === 'tickets' && sectionTitle.includes('ticket'))) {
                                section.style.display = 'block';
                            } else {
                                section.style.display = 'none';
                            }
                        });
                    }
                });
            });
        });
    </script>
    
    <%@ include file="footer.jsp"%>
</body>
</html>