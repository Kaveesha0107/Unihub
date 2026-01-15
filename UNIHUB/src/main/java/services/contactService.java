package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Contact;
import utils.dbConnect;

public class contactService {
	public void addContactUsRequest(Contact contact){
	    String sql = "INSERT INTO contact_queries (name, email, subject, message, status) VALUES (?, ?, ?, ?, ?)";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, contact.getName());
	        pstmt.setString(2, contact.getEmail());
	        pstmt.setString(3, contact.getSubject());
	        pstmt.setString(4, contact.getMessage());
	        pstmt.setString(5, contact.getStatus() != null ? contact.getStatus() : "New");

	        pstmt.executeUpdate();
	    } catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void changeStatusToResolvedById(int id) {
	    String sql = "UPDATE contact_queries SET status = 'Resolved' WHERE id = ?";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();

	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public List<Contact> getAllContactRequests() {
	    List<Contact> contactList = new ArrayList<Contact>();
	    String sql = "SELECT id, name, email, subject, message, status, created_at FROM contact_queries ORDER BY created_at DESC";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            Contact contact = new Contact();
	            contact.setId(rs.getInt("id"));
	            contact.setName(rs.getString("name"));
	            contact.setEmail(rs.getString("email"));
	            contact.setSubject(rs.getString("subject"));
	            contact.setMessage(rs.getString("message"));
	            contact.setStatus(rs.getString("status"));
	            contact.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());

	            contactList.add(contact);
	        }

	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }

	    return contactList;
	}

	public void deleteContactById(int id) {
	    String sql = "DELETE FROM contact_queries WHERE id = ?";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();

	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }
	}

}
