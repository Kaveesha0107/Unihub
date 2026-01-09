<%@ page import="model.Article"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
Article article = (Article) request.getAttribute("article");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title><%=article != null ? article.getTitle() : "Article Not Found"%></title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<style>
body {
	background: #f5f7fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: #2c3e50;
}

.article-container {
	max-width: 900px;
	margin: 50px auto;
	background: #fff;
	padding: 30px 40px;
	border-radius: 20px;
	box-shadow: 0 12px 30px rgba(44, 62, 80, 0.12);
}

.article-title {
	font-weight: 700;
	font-size: 2.8rem;
	margin-bottom: 0.25rem;
	color: #1a1a1a;
}

.article-date {
	font-size: 0.95rem;
	color: #7f8c8d;
	margin-bottom: 1.5rem;
	font-style: italic;
}

.article-summary {
	font-size: 1.25rem;
	color: #34495e;
	margin-bottom: 1.8rem;
	line-height: 1.5;
	font-weight: 500;
}

.article-image {
	width: 100%;
	max-height: 420px;
	object-fit: cover;
	border-radius: 15px;
	margin-bottom: 2rem;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.article-content {
	font-size: 1.15rem;
	line-height: 1.75;
	color: #2d3436;
	white-space: pre-wrap; /* Preserves line breaks */
}

.btn-back {
	margin-top: 3rem;
	font-weight: 600;
	padding: 10px 28px;
	border-radius: 50px;
	background: #3498db;
	color: white;
	transition: background-color 0.3s ease;
	box-shadow: 0 6px 18px rgba(52, 152, 219, 0.4);
}

.btn-back:hover {
	background: #217dbb;
	color: white;
}

@media ( max-width : 576px) {
	.article-container {
		padding: 20px 20px;
		margin: 30px 15px;
	}
	.article-title {
		font-size: 2rem;
	}
	.article-summary {
		font-size: 1.1rem;
	}
	.article-content {
		font-size: 1rem;
	}
}
</style>
</head>
<body>
	<c:choose>
		<c:when
			test="${not empty sessionScope.role and sessionScope.role == 'user'}">
			<jsp:include page="loggedUserHeader.jsp" />
		</c:when>
		<c:otherwise>
			<jsp:include page="header.jsp" />
		</c:otherwise>
	</c:choose>
	<div class="article-container shadow-sm">
		<c:choose>
			<c:when test="${not empty article}">
				<h1 class="article-title">${article.title}</h1>
				<p class="article-date">${article.postedDate}</p>
				<img src="data:image/jpeg;base64,${article.base64Image}"
					alt="${article.title}" class="article-image" />
				<div class="article-content">${article.content}</div>
				</br>
				<p class="article-summary">${article.summery}</p>
				<a href="readArticles" class="btn btn-back d-inline-block">Go
					Back to Articles</a>
			</c:when>
			<c:otherwise>
				<h2 class="text-center text-danger">Article Not Found</h2>
				<div class="text-center mt-4">
					<a href="articles.jsp" class="btn btn-secondary">Back to
						Articles</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<%@ include file="footer.jsp"%>
</body>
</html>