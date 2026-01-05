<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Response - UniHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container py-5">
    <h2 class="mb-4">Edit Response for Ticket #${ticket.ticketId}</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <!-- Ticket Info -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <strong>Ticket Details</strong>
        </div>
        <div class="card-body">
            <p><strong>Subject:</strong> ${ticket.subject}</p>
            <p><strong>Description:</strong> ${ticket.message}</p>
            <p><strong>Status:</strong> ${ticket.status}</p>
            <p><strong>Category:</strong> ${ticket.category}</p>
        </div>
    </div>

    <c:set var="editable" value="${ticket.status == 'In Progress'}" />

    <!-- Edit Response Form -->
    <form action="editResponse" method="post" enctype="multipart/form-data">
        <input type="hidden" name="responseId" value="${response.responseId}" />
        <input type="hidden" name="ticketId" value="${ticket.ticketId}" />

        <div class="mb-3">
            <label for="responseTitle" class="form-label">Response Title <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="responseTitle" name="responseTitle" required
                   value="${response.title}" <c:if test="${!editable}">readonly</c:if> />
        </div>

        <div class="mb-3">
            <label for="responseDescription" class="form-label">Response Details <span class="text-danger">*</span></label>
            <textarea class="form-control" id="responseDescription" name="responseDescription" rows="5" required
                      <c:if test="${!editable}">readonly</c:if>>${response.description}</textarea>
        </div>

        <div class="mb-3">
            <label for="nextSteps" class="form-label">Next Steps for User</label>
            <textarea class="form-control" id="nextSteps" name="nextSteps" rows="3"
                      <c:if test="${!editable}">readonly</c:if>>${response.nextSteps}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Uploaded Attachments</label>
            <ul>
                <c:choose>
                    <c:when test="${not empty attachments}">
                        <c:forEach var="file" items="${attachments}">
                            <li>
                                <a href="${pageContext.request.contextPath}/${file}" target="_blank" rel="noopener noreferrer">
                                    <i class="bi bi-file-earmark-text"></i> ${file.substring(file.lastIndexOf('/') + 1)}
                                </a>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li><em>No attachments uploaded.</em></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

        <div class="mb-4">
            <label for="attachments" class="form-label">Add More Attachments (optional)</label>
            <input class="form-control" type="file" id="attachments" name="attachments" multiple
                   accept=".pdf,.doc,.docx,.jpg,.jpeg,.png,.gif,.mp4,.mov,.avi" <c:if test="${!editable}">disabled</c:if> />
            <div class="form-text">Max file size: 25MB per file</div>
        </div>

        <div class="d-flex justify-content-between">
            <a href="agentTickets" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Back to Tickets
            </a>

            <c:if test="${editable}">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-save"></i> Save Changes
                </button>
            </c:if>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
