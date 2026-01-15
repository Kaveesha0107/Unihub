package servlet;

import model.Response;
import model.Ticket;
import services.ResponseService;
import services.TticketService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.util.*;

@WebServlet("/editResponse")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 25,      // 25MB per file
    maxRequestSize = 1024 * 1024 * 100   // 100MB total
)
public class editResponse extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketIdParam = request.getParameter("ticketId");

        if (ticketIdParam == null) {
            response.sendRedirect("agentTickets"); // Redirect if params missing
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdParam);

            TticketService ticketService = new TticketService();
            Ticket ticket = ticketService.getTicketById(ticketId);

            if (ticket == null) {
                request.setAttribute("errorMessage", "Ticket not found.");
                request.getRequestDispatcher("agentTickets").forward(request, response);
                return;
            }

            String status = ticket.getStatus();
            if (status == null || status.equalsIgnoreCase("Resolved") || status.equalsIgnoreCase("Closed")) {
                request.setAttribute("errorMessage", "Cannot edit response because the ticket status is \"" + status + "\".");
                request.getRequestDispatcher("agentTickets").forward(request, response);
                return;
            }

            ResponseService responseService = new ResponseService();
            Response resp = responseService.getResponseById(ticketId);  // Make sure you have this method!

            if (resp == null) {
                request.setAttribute("errorMessage", "Response not found.");
                request.getRequestDispatcher("agentTickets").forward(request, response);
                return;
            }

            String attachmentPaths = resp.getAttachmentPaths();
            List<String> attachments = new ArrayList<>();
            if (attachmentPaths != null && !attachmentPaths.isEmpty()) {
                attachments = Arrays.asList(attachmentPaths.split(";"));
            }

            request.setAttribute("attachments", attachments);
            request.setAttribute("ticket", ticket);
            request.setAttribute("response", resp);

            RequestDispatcher dispatcher = request.getRequestDispatcher("editResponse.jsp");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("agentTickets");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Parse form fields from multipart request
            Map<String, String> formFields = new HashMap<>();
            Collection<Part> parts = request.getParts();

            for (Part part : parts) {
                if (part.getContentType() == null) { // It's a form field
                    String value = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))
                            .lines()
                            .reduce("", (accumulator, actual) -> accumulator + actual);
                    formFields.put(part.getName(), value);
                }
            }

            String responseIdStr = formFields.get("responseId");
            String ticketIdStr = formFields.get("ticketId");
            String title = formFields.get("responseTitle");
            String description = formFields.get("responseDescription");
            String nextSteps = formFields.get("nextSteps");

            if (responseIdStr == null || ticketIdStr == null) {
                request.setAttribute("errorMessage", "Missing response or ticket ID.");
                doGet(request, response);
                return;
            }

            int responseId = Integer.parseInt(responseIdStr);
            int ticketId = Integer.parseInt(ticketIdStr);

            // Basic validation
            if (title == null || title.trim().isEmpty() || description == null || description.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Title and Description are required.");
                doGet(request, response);
                return;
            }

            ResponseService responseService = new ResponseService();
            Response existingResponse = responseService.getResponseByRId(responseId);

            if (existingResponse == null) {
                request.setAttribute("errorMessage", "Response not found.");
                request.getRequestDispatcher("agentTickets").forward(request, response);
                return;
            }

            // Handle file uploads
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadDir = applicationPath + File.separator + "uploads" + File.separator + "responses";

            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            StringBuilder newAttachments = new StringBuilder();
            for (Part part : parts) {
                if ("attachments".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    // Sanitize filename
                    fileName = fileName.replaceAll("[^a-zA-Z0-9\\.\\-_]", "_");

                    // Avoid overwriting existing files
                    File file = new File(uploadFolder, fileName);
                    int count = 1;
                    while (file.exists()) {
                        String name = fileName.contains(".") ? fileName.substring(0, fileName.lastIndexOf('.')) : fileName;
                        String ext = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf('.')) : "";
                        fileName = name + "_" + count + ext;
                        file = new File(uploadFolder, fileName);
                        count++;
                    }

                    part.write(file.getAbsolutePath());

                    if (newAttachments.length() > 0) {
                        newAttachments.append(";");
                    }
                    newAttachments.append("uploads/responses/").append(fileName);
                }
            }

            // Option 3: Replace attachments only if new files uploaded, else keep old
            String combinedAttachments;
            if (newAttachments.length() > 0) {
                combinedAttachments = newAttachments.toString(); // Replace with new files only
            } else {
                combinedAttachments = existingResponse.getAttachmentPaths(); // Keep old files if no new uploads
            }

            // Update response object
            existingResponse.setTitle(title);
            existingResponse.setDescription(description);
            existingResponse.setNextSteps(nextSteps);
            existingResponse.setAttachmentPaths(combinedAttachments);

            // Save update
            responseService.updateResponse(existingResponse);

            // Redirect after success
            response.sendRedirect("agentDash.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating response. Please try again.");
            doGet(request, response);
        }
    }

}
