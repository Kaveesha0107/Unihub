<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Edit Review - UniHub</title>

<!-- Bootstrap 5 CSS CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
  body {
    background-color: #f8f9fa;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .edit-review-container {
    max-width: 700px;
    margin: 3rem auto 5rem;
    background: #fff;
    padding: 2.5rem 2rem;
    border-radius: 0.75rem;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
  }
  h2 {
    color: #0d6efd;
    margin-bottom: 2rem;
    font-weight: 700;
    text-align: center;
  }
  label.form-label {
    font-weight: 600;
  }
  #starRating {
    font-size: 2.2rem;
  }
  #starRating .star {
    cursor: pointer;
    transition: color 0.2s ease-in-out;
  }
</style>

<script>
  function toggleReviewOptions() {
    const reviewType = document.querySelector('input[name="reviewType"]:checked').value;
    const websiteDiv = document.getElementById('websiteAspectsDiv');
    const uniDiv = document.getElementById('uniSelectDiv');
    const websiteAspect = document.getElementById('websiteAspect');
    const uniId = document.getElementById('uniId');

    if (reviewType === 'website') {
      websiteDiv.classList.remove('d-none');
      uniDiv.classList.add('d-none');
      websiteAspect.required = true;
      uniId.required = false;
      uniId.value = "";
    } else {
      websiteDiv.classList.add('d-none');
      uniDiv.classList.remove('d-none');
      websiteAspect.required = false;
      uniId.required = true;
      websiteAspect.value = "";
    }
  }

  document.addEventListener('DOMContentLoaded', () => {
    toggleReviewOptions();
  });
</script>
</head>
<body class="bg-light">

  <%@ include file="loggedUserHeader.jsp" %>

  <div class="edit-review-container shadow-sm">
    <h2>Edit Your Review</h2>

    <form action="editReview" method="post" novalidate>
      <!-- Hidden input to send review ID -->
      <input type="hidden" name="reviewId" value="${review.reviewId}" />

      <!-- Review Type -->
      <div class="mb-4">
        <label class="form-label d-block fw-semibold mb-2">Review Type</label>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="reviewType" id="reviewWebsite" value="website"
            onchange="toggleReviewOptions()" required
            <c:if test="${review.reviewType == 'website'}">checked</c:if> />
          <label class="form-check-label" for="reviewWebsite">Website</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="reviewType" id="reviewAgent" value="agent"
            onchange="toggleReviewOptions()" required
            <c:if test="${review.reviewType == 'agent'}">checked</c:if> />
          <label class="form-check-label" for="reviewAgent">University Agent</label>
        </div>
      </div>

      <!-- Website Aspects Dropdown -->
      <div class="mb-4" id="websiteAspectsDiv" <c:if test="${review.reviewType != 'website'}">class="d-none"</c:if>>
        <label for="websiteAspect" class="form-label">Select Website Aspect</label>
        <select class="form-select" id="websiteAspect" name="websiteAspect" required>
          <option value="" disabled>Choose an aspect</option>
          <option value="UI" <c:if test="${review.websiteAspect == 'UI'}">selected</c:if>>UI</option>
          <option value="Performance" <c:if test="${review.websiteAspect == 'Performance'}">selected</c:if>>Performance</option>
          <option value="Content" <c:if test="${review.websiteAspect == 'Content'}">selected</c:if>>Content</option>
          <option value="Support" <c:if test="${review.websiteAspect == 'Support'}">selected</c:if>>Support</option>
        </select>
      </div>

      <!-- University Agents Dropdown -->
      <div class="mb-4 <c:if test='${review.reviewType != "agent"}'>d-none</c:if>" id="uniSelectDiv">
        <label for="uniId" class="form-label">Select University Agent</label>
        <select class="form-select" id="uniId" name="uniId" required>
          <option value="" disabled>Choose an agent</option>
          <c:forEach var="uni" items="${unis}">
            <option value="${uni.universityId}" <c:if test="${review.uniId == uni.universityId}">selected</c:if>>${uni.name}</option>
          </c:forEach>
        </select>
      </div>

      <!-- Review Title -->
      <div class="mb-4">
        <label for="title" class="form-label">Review Title</label>
        <input type="text" class="form-control" id="title" name="title" maxlength="100" required value="${review.title}" placeholder="Enter review title" />
      </div>

      <!-- Review Content -->
      <div class="mb-4">
        <label for="content" class="form-label">Review Content</label>
        <textarea class="form-control" id="content" name="content" rows="5" required placeholder="Write your review here...">${review.content}</textarea>
      </div>

      <!-- Star Rating -->
      <div class="mb-4">
        <label class="form-label d-block mb-2">Rating</label>
        <div id="starRating" class="d-flex gap-2" aria-label="Star rating" role="radiogroup" tabindex="0">
          <span class="star text-secondary" data-value="1" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
          <span class="star text-secondary" data-value="2" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
          <span class="star text-secondary" data-value="3" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
          <span class="star text-secondary" data-value="4" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
          <span class="star text-secondary" data-value="5" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
        </div>
        <input type="hidden" id="rating" name="rating" required />
      </div>

      <button type="submit" class="btn btn-primary btn-lg w-100">Update Review</button>
    </form>
  </div>

  <%@ include file="footer.jsp" %>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    // Star rating UI logic
    const stars = document.querySelectorAll('#starRating .star');
    const ratingInput = document.getElementById('rating');

    function setRating(rating) {
      ratingInput.value = rating;
      stars.forEach(star => {
        const starVal = parseInt(star.dataset.value);
        if (starVal <= rating) {
          star.classList.add('text-warning');
          star.classList.remove('text-secondary');
          star.setAttribute('aria-checked', 'true');
          star.tabIndex = 0;
        } else {
          star.classList.remove('text-warning');
          star.classList.add('text-secondary');
          star.setAttribute('aria-checked', 'false');
          star.tabIndex = -1;
        }
      });
    }

    stars.forEach(star => {
      star.addEventListener('click', () => {
        setRating(parseInt(star.dataset.value));
      });

      star.addEventListener('mouseover', () => {
        const hoverVal = parseInt(star.dataset.value);
        stars.forEach(s => {
          if (parseInt(s.dataset.value) <= hoverVal) {
            s.classList.add('text-warning');
            s.classList.remove('text-secondary');
          } else {
            s.classList.remove('text-warning');
            s.classList.add('text-secondary');
          }
        });
      });

      star.addEventListener('mouseout', () => {
        setRating(ratingInput.value || 0);
      });

      // Keyboard accessibility
      star.addEventListener('keydown', e => {
        let currentVal = parseInt(ratingInput.value) || 0;
        if (e.key === 'ArrowRight' || e.key === 'ArrowUp') {
          e.preventDefault();
          if (currentVal < 5) setRating(currentVal + 1);
          stars[Math.min(currentVal, 4)].focus();
        } else if (e.key === 'ArrowLeft' || e.key === 'ArrowDown') {
          e.preventDefault();
          if (currentVal > 1) setRating(currentVal - 1);
          stars[Math.max(currentVal - 2, 0)].focus();
        } else if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          setRating(parseInt(star.dataset.value));
        }
      });
    });

    // Initialize with existing rating on page load
    document.addEventListener('DOMContentLoaded', () => {
      setRating(${review.rating});
      toggleReviewOptions();
    });
  </script>
</body>
</html>
