<%@ page import="java.util.Base64"%>
<%@ page import="model.Article"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Professional Articles</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
body {
	margin: 0;
	background: #f8f9fb;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: #222;
}
.carousel {
	width: 100%;
	max-width: 1200px;
	margin: 40px auto;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
	position: relative;
	background: #000;
}
.carousel-inner {
	height: 500px;
}
.carousel-item img {
	width: 100%;
	height: 500px;
	object-fit: cover;
	filter: brightness(0.7);
	transition: transform 0.5s, filter 0.5s;
}
.carousel-item:hover img {
	transform: scale(1.02);
	filter: brightness(0.85);
}
.carousel-caption {
	position: absolute;
	bottom: 30px;
	left: 50%;
	transform: translateX(-50%);
	background: rgba(0, 0, 0, 0.65);
	padding: 20px 30px;
	border-radius: 12px;
	max-width: 90%;
	text-align: center;
	color: #fff;
}
.carousel-caption h4 {
	font-size: 2rem;
	font-weight: 700;
	margin-bottom: 0.5rem;
}
.carousel-caption p {
	font-size: 1.1rem;
	font-weight: 400;
	color: #ddd;
	margin: 0;
}
.carousel-control-prev-icon, .carousel-control-next-icon {
	width: 45px;
	height: 45px;
	background-size: 100% 100%;
	filter: drop-shadow(0 0 5px rgba(0, 0, 0, 0.5));
}
@media (max-width: 768px) {
	.carousel-inner { height: 300px; }
	.carousel-item img { height: 300px; }
	.carousel-caption { padding: 12px 18px; bottom: 20px; }
	.carousel-caption h4 { font-size: 1.4rem; }
	.carousel-caption p { font-size: 0.9rem; }
}
.vertical-article-list {
	max-width: 1100px;
	margin: 0 auto 60px;
	padding: 0 16px;
}
.vertical-article-card {
	display: flex;
	align-items: stretch;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 8px 24px rgba(30, 42, 80, 0.10);
	overflow: hidden;
	margin-bottom: 32px;
	transition: transform 0.22s cubic-bezier(.4,0,.2,1), box-shadow 0.22s;
	cursor: pointer;
	border: 1px solid #e8eaf0;
	/* Removed fixed height to prevent overflow issues */
}
.vertical-article-card:hover {
	transform: translateY(-6px) scale(1.03);
	box-shadow: 0 16px 36px rgba(30, 42, 80, 0.14);
	background: linear-gradient(135deg, #f8faff 80%, #e7f0fd 100%);
}
.vertical-article-image {
	width: 240px;
	height: 100%;
	object-fit: cover;
	display: block;
}
.vertical-article-content {
	padding: 20px 26px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.vertical-article-date {
	color: #6c757d;
	font-size: 0.97rem;
	margin-bottom: 8px;
	font-style: italic;
}
.vertical-article-title {
	font-size: 1.7rem;
	font-weight: 800;
	color: #1a1a1a;
	margin-bottom: 12px;
	letter-spacing: -0.5px;
}
.vertical-article-snippet {
	font-size: 1rem;
	color: #444;
	margin-bottom: 12px;
	line-height: 1.5;

	/* Clamp snippet to max 4 lines to keep cards tidy */
	display: -webkit-box;
	-webkit-line-clamp: 4;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	max-height: calc(1.5em * 4);
}
.vertical-article-readmore {
	color: #1a73e8;
	font-weight: 600;
	text-decoration: none;
	background: #eef4fd;
	padding: 6px 16px;
	border-radius: 20px;
	display: inline-block; /* Ensure proper button sizing */
	transition: background 0.2s;
	align-self: flex-start; /* Align left inside content */
}
.vertical-article-readmore:hover {
	background: #d8e7fc;
	text-decoration: underline;
}
@media (max-width: 768px) {
	.vertical-article-card { flex-direction: column; }
	.vertical-article-image { width: 100%; height: 200px; }
	.vertical-article-content { padding: 18px; }
}
#articleSearch {
	max-width: 600px;
	margin: 30px auto 20px;
	display: block;
	padding: 10px 15px;
	font-size: 1.1rem;
	border-radius: 8px;
	border: 1px solid #ccc;
	box-shadow: inset 0 1px 3px #ddd;
}
#noResultsMsg {
	text-align: center;
	color: #888;
	font-style: italic;
	margin-top: 20px;
}
</style>
</head>
<body>
	<!-- Header Include (Dynamic based on role) -->
	<div class="pt3">
		<c:choose>
			<c:when test="${not empty sessionScope.role and sessionScope.role == 'user'}">
				<jsp:include page="loggedUserHeader.jsp" />
			</c:when>
			<c:otherwise>
				<jsp:include page="header.jsp" />
			</c:otherwise>
		</c:choose>
	</div>

	<!-- Carousel Section -->
	<div class="container">
		<div class="row">
			<div id="carouselExampleAutoplaying"
				class="carousel slide carousel-fade" data-bs-ride="carousel"
				data-bs-interval="5000" data-bs-pause="hover"
				aria-label="Article Carousel">
				<div class="carousel-inner">
					<c:forEach var="article" items="${latestArticles}" varStatus="status">
						<div class="carousel-item ${status.first ? 'active' : ''}">
							<a href="specificArticle?id=${article.id}" title="${article.title}">
								<img src="data:image/jpeg;base64,${article.base64Image}"
									class="d-block" alt="${article.title}" />
								<div class="carousel-caption d-block">
									<h4>${article.title}</h4>
									<p>
										<c:choose>
											<c:when test="${fn:length(article.content) > 100}">
												${fn:substring(article.content, 0, 100)}...
											</c:when>
											<c:otherwise>
												${article.content}
											</c:otherwise>
										</c:choose>
									</p>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev"
					aria-label="Previous Slide">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next"
					aria-label="Next Slide">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
				</button>
			</div>
		</div>
	</div>

	<!-- Search Bar -->
	<input type="text" id="articleSearch" placeholder="Search articles by title..." />

	<!-- Vertical Article List Section -->
	<div class="vertical-article-list">
		<c:forEach var="article" items="${latestArticles}">
			<div class="vertical-article-card p-4" tabindex="0" role="article" aria-label="${article.title}">
				<img src="data:image/jpeg;base64,${article.base64Image}"
					class="vertical-article-image" alt="${article.title}" />
				<div class="vertical-article-content">
					<div class="vertical-article-date">${article.postedDate}</div>
					<div class="vertical-article-title">${article.title}</div>
					<div class="vertical-article-snippet">
						<c:choose>
							<c:when test="${fn:length(article.content) > 250}">
								${fn:substring(article.content, 0, 250)}...
							</c:when>
							<c:otherwise>
								${article.content}
							</c:otherwise>
						</c:choose>
					</div>
					<a href="specificArticle?id=${article.id}"
						class="vertical-article-readmore" aria-label="Read more about ${article.title}">Read More &rarr;</a>
				</div>
			</div>
		</c:forEach>
	</div>

	<p id="noResultsMsg" style="display:none;">No articles found.</p>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		const searchInput = document.getElementById('articleSearch');
		const articleCards = document.querySelectorAll('.vertical-article-card');
		const noResultsMsg = document.getElementById('noResultsMsg');

		searchInput.addEventListener('input', () => {
			const filter = searchInput.value.toLowerCase();
			let visibleCount = 0;

			articleCards.forEach(card => {
				const titleElem = card.querySelector('.vertical-article-title');
				const titleText = titleElem.textContent.toLowerCase();

				if (titleText.includes(filter)) {
					card.style.display = '';
					visibleCount++;
				} else {
					card.style.display = 'none';
				}
			});

			noResultsMsg.style.display = visibleCount === 0 ? 'block' : 'none';
		});
	</script>

	<%@ include file="footer.jsp" %>
</body>
</html>
