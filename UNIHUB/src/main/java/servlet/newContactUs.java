package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Contact;
import services.contactService;

@WebServlet("/newContactUs")
public class newContactUs extends HttpServlet {
	@SuppressWarnings("unused")
	private static final long LONG = 1L;

    public newContactUs() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name == null || email == null || subject == null || message == null ||
            name.isEmpty() || email.isEmpty() || subject.isEmpty() || message.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("contactus.jsp").forward(request, response);
            return;
        }

        Contact contact = new Contact();
        contact.setName(name);
        contact.setEmail(email);
        contact.setSubject(subject);
        contact.setMessage(message);
        
        contactService cs = new contactService();
        cs.addContactUsRequest(contact);
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

}
