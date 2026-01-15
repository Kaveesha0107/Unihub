package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.universityAgent;
import services.agentService;

@WebServlet("/editAgentProfile")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max upload size
public class editAgentProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public editAgentProfile() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("agentId") == null) {
            response.sendRedirect("agentlogin.jsp");
            return;
        }

        int agentId = (int) session.getAttribute("agentId");

        agentService agentService = new agentService();
        universityAgent agent = agentService.getAgentById(agentId);

        if (agent == null) {
            response.sendRedirect("agentProfile?error=Agent not found");
            return;
        }

        request.setAttribute("agent", agent);
        request.getRequestDispatcher("editAgentProfile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("agentId") == null) {
            response.sendRedirect("agentlogin.jsp");
            return;
        }

        int sessionAgentId = (int) session.getAttribute("agentId");

        int agentId;
        try {
            agentId = Integer.parseInt(request.getParameter("agentId"));
        } catch (NumberFormatException e) {
            response.sendRedirect("editAgentProfile?error=Invalid agent ID");
            return;
        }

        if (agentId != sessionAgentId) {
            response.sendRedirect("editAgentProfile?error=Unauthorized access");
            return;
        }

        String firstName = Optional.ofNullable(request.getParameter("firstName")).orElse("").trim();
        String lastName = Optional.ofNullable(request.getParameter("lastName")).orElse("").trim();
        String email = Optional.ofNullable(request.getParameter("email")).orElse("").trim();
        String phone = Optional.ofNullable(request.getParameter("phone")).orElse("").trim();
        String newPassword = Optional.ofNullable(request.getParameter("newPassword")).orElse("");
        String confirmPassword = Optional.ofNullable(request.getParameter("confirmPassword")).orElse("");

        if (firstName.isEmpty() || lastName.isEmpty() || email.isEmpty()) {
            request.setAttribute("errorMessage", "First name, last name, and email are required.");
            forwardBack(request, response, agentId);
            return;
        }

        if (!newPassword.isEmpty() || !confirmPassword.isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "New password and confirm password do not match.");
                forwardBack(request, response, agentId);
                return;
            }
            if (newPassword.length() < 6) {
                request.setAttribute("errorMessage", "New password must be at least 6 characters.");
                forwardBack(request, response, agentId);
                return;
            }
        }

        Part profilePhotoPart = request.getPart("profilePhoto");
        byte[] profilePhotoBytes = null;
        if (profilePhotoPart != null && profilePhotoPart.getSize() > 0) {
            try (InputStream is = profilePhotoPart.getInputStream()) {
                profilePhotoBytes = is.readAllBytes();
            } catch (IOException e) {
                request.setAttribute("errorMessage", "Failed to read uploaded image.");
                forwardBack(request, response, agentId);
                return;
            }
        }

        agentService agentService = new agentService();
        universityAgent agent = agentService.getAgentById(agentId);
        if (agent == null) {
            response.sendRedirect("editAgentProfile?error=Agent not found");
            return;
        }

        agent.setFirstName(firstName);
        agent.setLastName(lastName);
        agent.setEmail(email);
        agent.setPhone(phone);

        if (profilePhotoBytes != null) {
            agent.setProfilePhoto(profilePhotoBytes);
        }

        if (!newPassword.isEmpty()) {
            // Directly store password as plain text (not recommended)
            agent.setPassword(newPassword);
        }

        boolean updated = agentService.updateAgent(agent);

        if (updated) {
            session.setAttribute("agent", agent);
            response.sendRedirect("agentProfile?message=Profile updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            forwardBack(request, response, agentId);
        }
    }

    private void forwardBack(HttpServletRequest request, HttpServletResponse response, int agentId) throws ServletException, IOException {
        agentService agentService = new agentService();
        universityAgent agent = agentService.getAgentById(agentId);
        request.setAttribute("agent", agent);
        request.getRequestDispatcher("editAgentProfile.jsp").forward(request, response);
    }
}
