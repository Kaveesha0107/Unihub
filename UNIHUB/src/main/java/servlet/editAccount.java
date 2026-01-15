package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.user;
import services.UserService;

@WebServlet("/editAccount")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max file size
public class editAccount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public editAccount() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userID");

        UserService us = new UserService();
        user user = us.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("editAccount.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int sessionUserId = (int) session.getAttribute("userID");

        int userId;
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
        } catch (NumberFormatException e) {
            response.sendRedirect("editAccount?error=Invalid user ID");
            return;
        }

        if (userId != sessionUserId) {
            response.sendRedirect("editAccount?error=Unauthorized access");
            return;
        }

        String firstname = Optional.ofNullable(request.getParameter("firstname")).orElse("").trim();
        String lastname = Optional.ofNullable(request.getParameter("lastname")).orElse("").trim();
        String email = Optional.ofNullable(request.getParameter("email")).orElse("").trim();
        String phone = Optional.ofNullable(request.getParameter("phone")).orElse("").trim();
        String bio = Optional.ofNullable(request.getParameter("bio")).orElse("").trim();
        String newPassword = Optional.ofNullable(request.getParameter("newPassword")).orElse("");
        String confirmPassword = Optional.ofNullable(request.getParameter("confirmPassword")).orElse("");

        if (firstname.isEmpty() || lastname.isEmpty() || email.isEmpty()) {
            request.setAttribute("errorMessage", "First name, last name, and email are required.");
            forwardBack(request, response, userId);
            return;
        }
        if (!newPassword.isEmpty() || !confirmPassword.isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "New password and confirm password do not match.");
                forwardBack(request, response, userId);
                return;
            }
            if (newPassword.length() < 6) {
                request.setAttribute("errorMessage", "New password must be at least 6 characters.");
                forwardBack(request, response, userId);
                return;
            }
        }

        Part profileImagePart = request.getPart("profileImage");
        byte[] profileImageBytes = null;
        if (profileImagePart != null && profileImagePart.getSize() > 0) {
            try (InputStream is = profileImagePart.getInputStream()) {
                profileImageBytes = is.readAllBytes();
            } catch (IOException e) {
                request.setAttribute("errorMessage", "Failed to read uploaded image.");
                forwardBack(request, response, userId);
                return;
            }
        }

        UserService userService = new UserService();
        user user = userService.getUserById(userId);
        if (user == null) {
            response.sendRedirect("editAccount?error=User not found");
            return;
        }

        user.setFirstname(firstname);
        user.setLastname(lastname);
        user.setEmail(email);
        user.setPhone(phone);
        user.setBio(bio);

        if (profileImageBytes != null) {
            user.setProfileImage(profileImageBytes);
        }

        if (!newPassword.isEmpty()) {
            // Directly store password as plain text (not recommended)
            user.setPassword(newPassword);
        }

        boolean updated = userService.updateUser(user);

        if (updated) {
            session.setAttribute("user", user);
            response.sendRedirect("accountSettings?message=Profile updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            forwardBack(request, response, userId);
        }
    }

    private void forwardBack(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        UserService userService = new UserService();
        user user = userService.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("editAccount.jsp").forward(request, response);
    }
}
