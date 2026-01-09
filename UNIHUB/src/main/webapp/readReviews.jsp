<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equals("user")) {
	response.sendRedirect("home.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>UniHub | Manage Your Reviews</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet" />
<style>
body {
	background: linear-gradient(to right, #eef2f3, #8e9eab);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
}

.star {
	font-size: 1.2em;
}

.expand-row {
	background-color: #f8f9fa;
}

.review-content {
	white-space: pre-wrap;
}

.btn-group>* {
	margin-right: 0.5rem;
}
</style>
</head>
<body>

	<!-- Navbar -->
	<%@ include file="loggedUserHeader.jsp"%>

	<!-- Main -->
	<main class="container py-5">
		<h2 class="mb-4 text-center fw-bold text-dark">Manage Your
			Reviews</h2>

		<c:choose>
			<c:when test="${empty userReviews}">
				<div class="alert alert-info text-center" role="alert">
					You have not submitted any reviews yet. <a href="newReview"
						class="alert-link">Submit one now!</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="table-responsive">
					<table class="table table-hover align-middle">
						<thead class="table-dark">
							<tr>
								<th>Title</th>
								<th>Type</th>
								<th>Aspect / University</th>
								<th>Rating</th>
								<th>Submitted On</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="review" items="${userReviews}">
								<!-- Main row -->
								<tr>
									<td>${review.title}</td>
									<td><c:choose>
											<c:when test="${review.reviewType == 'website'}">Website</c:when>
											<c:when test="${review.reviewType == 'agent'}">University Agent</c:when>
											<c:otherwise>Unknown</c:otherwise>
										</c:choose></td>
									<td><c:choose>
											<c:when test="${review.reviewType == 'website'}">${review.websiteAspect}</c:when>
											<c:when test="${review.reviewType == 'agent'}">
												<c:forEach var="uni" items="${unis}">
													<c:if test="${uni.universityId == review.uniId}">
                                                    University: ${uni.name}
                                                </c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>-</c:otherwise>
										</c:choose></td>
									<td><c:forEach var="i" begin="1" end="${review.rating}">
											<span class="star text-warning">&#9733;</span>
										</c:forEach> <c:forEach var="i" begin="1" end="${5 - review.rating}">
											<span class="star text-secondary">&#9733;</span>
										</c:forEach></td>
									<td>${review.createdAt}</td>
									<td>
										<div class="btn-group" role="group" aria-label="Actions">
											<button class="btn btn-sm btn-outline-primary" type="button"
												data-bs-toggle="collapse"
												data-bs-target="#expand${review.reviewId}"
												aria-expanded="false"
												aria-controls="expand${review.reviewId}">
												<i class="bi bi-eye"></i> View
											</button>
											<a href="editReview?reviewId=${review.reviewId}"
												class="btn btn-sm btn-warning"> <i
												class="bi bi-pencil-square"></i> Edit
											</a>
											<form action="deleteReview" method="post"
												onsubmit="return confirm('Are you sure you want to delete this review?');"
												class="d-inline">
												<input type="hidden" name="reviewId"
													value="${review.reviewId}" />
												<button type="submit" class="btn btn-sm btn-danger">
													<i class="bi bi-trash"></i> Delete
												</button>
											</form>
										</div>
									</td>
								</tr>

								<!-- Expandable row -->
								<tr class="collapse-row">
									<td colspan="6" class="p-0">
										<div class="collapse" id="expand${review.reviewId}">
											<div class="p-3 bg-light border rounded-bottom">
												<h5>
													<strong>Full Review Details</strong>
												</h5>
												<table class="table table-bordered">
													<tr>
														<th style="width: 25%;">Title</th>
														<td>${review.title}</td>
													</tr>
													<tr>
														<th>Content</th>
														<td class="review-content">${review.content}</td>
													</tr>
													<tr>
														<th>Rating</th>
														<td><c:forEach var="i" begin="1"
																end="${review.rating}">
																<span class="star text-warning">&#9733;</span>
															</c:forEach> <c:forEach var="i" begin="1" end="${5 - review.rating}">
																<span class="star text-secondary">&#9733;</span>
															</c:forEach> <span class="ms-2 text-muted">(${review.rating}
																out of 5)</span></td>
													</tr>
													<tr>
														<th>Review Type</th>
														<td><c:choose>
																<c:when test="${review.reviewType == 'website'}">Website</c:when>
																<c:when test="${review.reviewType == 'agent'}">University Agent</c:when>
																<c:otherwise>Unknown</c:otherwise>
															</c:choose></td>
													</tr>
													<c:if test="${review.reviewType == 'website'}">
														<tr>
															<th>Website Aspect</th>
															<td>${review.websiteAspect}</td>
														</tr>
													</c:if>
													<c:if test="${review.reviewType == 'agent'}">
														<tr>
															<th>University Agent</th>
															<td><c:forEach var="uni" items="${unis}">
																	<c:if test="${uni.universityId == review.uniId}">
                                                                    ${uni.name}
                                                                </c:if>
																</c:forEach></td>
														</tr>
													</c:if>
													<tr>
														<th>Submitted On</th>
														<td>${review.createdAt}</td>
													</tr>
												</table>
											</div>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:otherwise>
		</c:choose>
	</main>

	<!-- Footer -->
	<%@ include file="footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
