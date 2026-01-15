package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Contact;
import services.contactService;

@WebServlet("/contactUsManagementDash")
public class contactUsManagementDash extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public contactUsManagementDash() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		contactService cs = new contactService();
		List<Contact> contactUsList = cs.getAllContactRequests();
		
		request.setAttribute("contactUsList", contactUsList);
		request.getRequestDispatcher("viewContactusRequests.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
