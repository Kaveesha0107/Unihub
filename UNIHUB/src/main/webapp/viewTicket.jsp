<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>View Ticket - UniHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
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
    </style>
</head>
<body>

<!-- Header / Navbar -->
<%@ include file="loggedUserHeader.jsp" %>

<!-- Main Content -->
<main class="container mt-5 mb-5">
    <h2 class="mb-4">Ticket Details</h2>

    <c:choose>
        <c:when test="${not empty ticket}">
            <table class="table table-bordered bg-white shadow-sm">
                <tr>
                    <th>Ticket ID</th>
                    <td>${ticket.ticketId}</td>
                </tr>
                <tr>
                    <th>Subject</th>
                    <td>${ticket.subject}</td>
                </tr>
                <tr>
                    <th>Description</th>
                    <td>${ticket.message}</td>
                </tr>
                <tr>
                    <th>Category</th>
                    <td>${ticket.category}</td>
                </tr>
                <tr>
                    <th>Department</th>
                    <td>${ticket.department}</td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td>
                        <span class="badge 
                            <c:choose>
                                <c:when test="${ticket.status == 'Open'}">bg-success</c:when>
                                <c:when test="${ticket.status == 'Resolved'}">bg-primary</c:when>
                                <c:when test="${ticket.status == 'Closed'}">bg-secondary</c:when>
                                <c:otherwise>bg-info</c:otherwise>
                            </c:choose>">
                            ${ticket.status}
                        </span>
                    </td>
                </tr>
            </table>

            <!-- Response Section -->
            <c:choose>
                <c:when test="${response == null}">
                    <div class="text-center">
                        <p class="fs-5 text-muted">No response has been made for this ticket yet.</p>
                        
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mb-4">
                        <h2 class="section-header">Response Details</h2>
                        <div class="card p-4 bg-white">
                            <h4 class="fw-bold">${response.title}</h4>
                            <p>${response.description}</p>
                            <hr />
                            <h6 class="fw-semibold">Next Steps for User:</h6>
                            <p>${response.nextSteps}</p>

                            <c:if test="${not empty response.attachmentPaths}">
                                <div class="mt-3">
                                    <h6>Attachments</h6>
                                    <ul class="list-unstyled attachment-list">
                                        <c:forEach var="file" items="${fn:split(response.attachmentPaths, ';')}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/${file}" download class="text-decoration-none">
                                                    <i class="bi bi-paperclip"></i> 
                                                    ${file.substring(file.lastIndexOf('/') + 1)}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:if>
                            <c:if test="${empty response.attachmentPaths}">
                                <p class="text-muted fst-italic mt-3">No attachments uploaded.</p>
                            </c:if>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="mt-4">
                <a href="userTicketList" class="btn btn-secondary me-2">
                    <i class="bi bi-arrow-left"></i> Back to Tickets
                </a>
                <a href="editTicket?ticketId=${ticket.ticketId}" class="btn btn-warning">
                    <i class="bi bi-pencil-square"></i> Edit Ticket
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-danger">Ticket not found.</div>
            <a href="userTicketList" class="btn btn-secondary mt-3">Back to Tickets</a>
        </c:otherwise>
    </c:choose>
</main>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
