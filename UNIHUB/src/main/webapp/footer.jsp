<style>
body {
	margin: 0;
	font-family: 'Segoe UI', sans-serif;
	background-color: #f4f6f8;
}

/* ===== Footer ===== */
footer {
	background: linear-gradient(90deg, #002147, #0052cc);
	padding: 40px 0;
	color: white;
}

.footer-container {
	max-width: 1200px;
	margin: 0 auto;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	gap: 20px;
}

.footer-section {
	flex: 1;
	min-width: 220px;
	margin-bottom: 20px;
}

footer h1, footer h2 {
	margin-bottom: 16px;
}

footer p, footer ul, footer address {
	line-height: 1.6;
	margin: 0;
}

footer ul {
	list-style: none;
	padding: 0;
}

footer li {
	margin-bottom: 6px;
}

footer a {
	color: white;
	text-decoration: none;
	position: relative;
	display: inline-block;
	transition: color 0.3s ease;
}

footer a::after {
	content: '';
	position: absolute;
	width: 0%;
	height: 2px;
	bottom: -2px;
	left: 0;
	background-color: #ffdd57;
	transition: width 0.3s ease;
}

footer a:hover {
	color: #ffdd57;
}

footer a:hover::after {
	width: 100%;
}

.bold {
	font-weight: bold;
}

.copyright {
	text-align: center;
	margin-top: 30px;
	padding-top: 20px;
	border-top: 1px solid #ccc;
	font-size: 14px;
}
</style>
<footer>
	<div class="footer-container">
		<div class="footer-section">
			<h1 style="color: white;">UniHub</h1>
			<p style="color: white;">"UniHub connects students with the
				right agents to quickly resolve university-related inquiries."</p>
		</div>

		<div class="footer-section">
			<h2 style="color: white;">Quick Links</h2>
			<ul>
				<li><a href="home.jsp">Home</a></li>
				<li><a href="AboutUs.jsp">About UniHub</a></li>
				<li><a href="faqs.jsp">FAQs</a></li>
				<li><a href="terms.jsp">Terms of Service</a></li>
				<li><a href="privacypolicy.jsp">Privacy Policy</a></li>
			</ul>
		</div>

		<div class="footer-section">
			<h2 style="color: white;">Contact Us</h2>
			<address>
				UniHub Support Center<br> Colombo, Sri Lanka<br> Phone:
				+94 77 123 4567<br> Email: support@unihub.lk
			</address>
		</div>
	</div>

	<div class="copyright">
		© <span class="bold">UniHub</span> - All Rights Reserved.
	</div>
</footer>
