<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Submit Review - UniHub</title>

<!-- Bootstrap 5 CSS CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
  body {
    background-color: #f8f9fa;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .review-container {
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
  .char-counter {
    font-size: 0.95em;
    color: #888;
    float: right;
  }
  .char-counter.invalid {
    color: #d9534f;
    font-weight: bold;
  }
</style>
</head>
<body class="bg-light">

  <%@ include file="loggedUserHeader.jsp" %>

  <div class="review-container shadow-sm">
    <h2>Submit a Review</h2>
    <form action="newReview" method="post" novalidate>
      <!-- Review Type -->
      <div class="mb-4">
        <label class="form-label d-block fw-semibold mb-2">Review Type</label>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="reviewType" id="reviewWebsite" value="website" checked onchange="toggleReviewOptions()" required>
          <label class="form-check-label" for="reviewWebsite">Website</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="reviewType" id="reviewAgent" value="agent" onchange="toggleReviewOptions()" required>
          <label class="form-check-label" for="reviewAgent">University Agent</label>
        </div>
      </div>

      <!-- Website Aspects Dropdown -->
      <div class="mb-4" id="websiteAspectsDiv">
        <label for="websiteAspect" class="form-label">Select Website Aspect</label>
        <select class="form-select" id="websiteAspect" name="websiteAspect" required>
          <option value="" disabled selected>Choose an aspect</option>
          <option value="UI">UI</option>
          <option value="Performance">Performance</option>
          <option value="Content">Content</option>
          <option value="Support">Support</option>
        </select>
        <div class="invalid-feedback">Please select a website aspect.</div>
      </div>

      <!-- University Agents Dropdown -->
      <div class="mb-4 d-none" id="uniSelectDiv">
        <label for="uniId" class="form-label">Select University Agent</label>
        <select class="form-select" id="uniId" name="uniId">
          <option value="" disabled selected>Choose an agent</option>
          <c:forEach var="uni" items="${unis}">
            <option value="${uni.universityId}">${uni.name}</option>
          </c:forEach>
        </select>
        <div class="invalid-feedback">Please select a university agent.</div>
      </div>

      <!-- Review Title -->
      <div class="mb-4">
        <label for="title" class="form-label">Review Title</label>
        <span id="titleCounter" class="char-counter">0/99</span>
        <input type="text" class="form-control" id="title" name="title" maxlength="99" required placeholder="Enter review title">
        <div class="invalid-feedback" id="titleFeedback">Review title must be 5-99 characters.</div>
      </div>

      <!-- Review Content -->
      <div class="mb-4">
        <label for="content" class="form-label">Review Content</label>
        <span id="contentCounter" class="char-counter">0/1000</span>
        <textarea class="form-control" id="content" name="content" rows="5" maxlength="1000" required placeholder="Write your review here..."></textarea>
        <div class="invalid-feedback" id="contentFeedback">Review content must be 10-1000 characters.</div>
      </div>

      <!-- Rating as Select -->
      <div class="mb-4">
        <label for="rating" class="form-label">Rating</label>
        <select class="form-select" id="rating" name="rating" required>
          <option value="" disabled selected>Select rating</option>
          <option value="1">1 - Poor</option>
          <option value="2">2 - Fair</option>
          <option value="3">3 - Good</option>
          <option value="4">4 - Very Good</option>
          <option value="5">5 - Excellent</option>
        </select>
        <div class="invalid-feedback">Please select a rating.</div>
      </div>

      <button type="submit" class="btn btn-primary btn-lg w-100">Submit Review</button>
    </form>
  </div>

  <%@ include file="footer.jsp" %>

  <!-- Bootstrap 5 JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    // Toggle website aspect/agent selects
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
    window.addEventListener('DOMContentLoaded', function() {
      toggleReviewOptions();

      // Character counter and validation for title
      const title = document.getElementById('title');
      const titleCounter = document.getElementById('titleCounter');
      const titleFeedback = document.getElementById('titleFeedback');
      title.addEventListener('input', function() {
        const len = title.value.length;
        titleCounter.textContent = len + '/99';
        if (len < 5 || len > 99) {
          titleCounter.classList.add('invalid');
          title.classList.add('is-invalid');
          titleFeedback.textContent = 'Review title must be 5-99 characters.';
        } else {
          titleCounter.classList.remove('invalid');
          title.classList.remove('is-invalid');
          titleFeedback.textContent = '';
        }
      });

      // Character counter and validation for content
      const content = document.getElementById('content');
      const contentCounter = document.getElementById('contentCounter');
      const contentFeedback = document.getElementById('contentFeedback');
      content.addEventListener('input', function() {
        const len = content.value.length;
        contentCounter.textContent = len + '/1000';
        if (len < 10 || len > 1000) {
          contentCounter.classList.add('invalid');
          content.classList.add('is-invalid');
          contentFeedback.textContent = 'Review content must be 10-1000 characters.';
        } else {
          contentCounter.classList.remove('invalid');
          content.classList.remove('is-invalid');
          contentFeedback.textContent = '';
        }
      });
    });

    // Bootstrap 5 validation + custom char count check on submit
    (() => {
      'use strict';
      const form = document.querySelector('form');
      form.addEventListener('submit', function(event) {
        // Custom char validation
        const title = document.getElementById('title');
        const content = document.getElementById('content');
        let valid = true;
        if (title.value.length < 5 || title.value.length > 99) {
          title.classList.add('is-invalid');
          valid = false;
        }
        if (content.value.length < 10 || content.value.length > 1000) {
          content.classList.add('is-invalid');
          valid = false;
        }
        if (!form.checkValidity() || !valid) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    })();
  </script>

</body>
</html>
