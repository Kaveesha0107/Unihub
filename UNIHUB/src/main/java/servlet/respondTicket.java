package servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.Response;
import model.Ticket;
import services.ResponseService;
import services.TticketService;

@WebServlet("/respondTicket")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  
    maxFileSize = 1024 * 1024 * 25,      
    maxRequestSize = 1024 * 1024 * 100 
)
public class respondTicket extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads/responses";

    public respondTicket() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String idParam = request.getParameter("ticketId");
       
       if(idParam != null) {
    	   try {
			int id = Integer.parseInt(idParam);
			
			TticketService ts = new TticketService();
			Ticket ticket = ts.getTicketById(id);
			
			if(ticket == null) {
				request.setAttribute("errorMessage", "Ticket Not Found");
				request.getRequestDispatcher("agentDash.jsp").forward(request, response);
				return;
			}
			
			request.setAttribute("ticket", ticket);
			RequestDispatcher dispatcher = request.getRequestDispatcher("ticketRespond.jsp");
			dispatcher.forward(request, response);
			
		} catch (Exception e) {
			 e.printStackTrace();
             response.sendRedirect("agentDash.jsp");
             return;
		}
       }else {
           response.sendRedirect("agentDash.jsp");
           return;
       }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("agentId") == null) {
            response.sendRedirect("agentlogin.jsp");
            return;
        }

        int agentId = (int) session.getAttribute("agentId");

        request.setCharacterEncoding("UTF-8");

        try {
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));
            String responseTitle = request.getParameter("responseTitle");
            String responseDescription = request.getParameter("responseDescription");
            String nextSteps = request.getParameter("nextSteps");
            
            if (responseTitle == null || responseTitle.trim().isEmpty() ||
                responseDescription == null || responseDescription.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Response title and description are required.");
                request.getRequestDispatcher("ticketRespond.jsp").forward(request, response);
                return;
            }

            Response resp = new Response();
            resp.setTicketId(ticketId);
            resp.setAgentId(agentId);
            resp.setTitle(responseTitle);
            resp.setDescription(responseDescription);
            resp.setNextSteps(nextSteps);

            // Handle file uploads
            Collection<Part> parts = request.getParts();
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            StringBuilder uploadedFiles = new StringBuilder();

            for (Part part : parts) {
                if ("attachments".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

                    fileName = fileName.replaceAll("[^a-zA-Z0-9\\.\\-_]", "_");

                    String filePath = uploadPath + File.separator + fileName;

                    File file = new File(filePath);
                    int count = 1;
                    while (file.exists()) {
                        String name = fileName.substring(0, fileName.lastIndexOf('.'));
                        String ext = fileName.substring(fileName.lastIndexOf('.'));
                        fileName = name + "_" + count + ext;
                        filePath = uploadPath + File.separator + fileName;
                        file = new File(filePath);
                        count++;
                    }

                    part.write(filePath);

                    if (uploadedFiles.length() > 0) {
                        uploadedFiles.append(";");
                    }
                    uploadedFiles.append(UPLOAD_DIR).append("/").append(fileName);
                }
            }

            resp.setAttachmentPaths(uploadedFiles.toString());

            ResponseService responseService = new ResponseService();
            responseService.saveResponse(resp);
            TticketService ts = new TticketService();
            ts.changeTicketStatusToInProgress(ticketId);

            response.sendRedirect("agentDash.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid ticket ID.");
            request.getRequestDispatcher("ticketRespond.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error processing your response. Please try again.");
            request.getRequestDispatcher("ticketRespond.jsp").forward(request, response);
        }
    }
}
