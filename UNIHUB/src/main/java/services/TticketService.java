package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.fabric.xmlrpc.base.Array;

import model.Ticket;
import utils.dbConnect;

public class TticketService {
	public void addTicket(Ticket ticket) {
	    String sql = "INSERT INTO ticket (user_id, university_id, subject, message, department, category) "
	               + "VALUES (?, ?, ?, ?, ?, ?)";
	    
	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        // Set parameters from Ticket object
	        pstmt.setInt(1, ticket.getUserId());
	        pstmt.setInt(2, ticket.getUniversityId());
	        pstmt.setString(3, ticket.getSubject());
	        pstmt.setString(4, ticket.getMessage());
	        pstmt.setString(5, ticket.getDepartment());
	        pstmt.setString(6, ticket.getCategory());

	        // Execute update
	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected > 0) {
	            System.out.println("Ticket inserted successfully!");
	        }
	        
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        // Consider throwing a custom exception here
	    }
	}
	
	public List<Ticket> getAllTicketsByUserId(int id) {
	    List<Ticket> ticketList = new ArrayList<>();

	    String sql = "SELECT * FROM ticket WHERE user_id = ? ORDER BY created_at DESC";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, id);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Ticket ticket = new Ticket();
	                ticket.setTicketId(rs.getInt("ticket_id"));
	                ticket.setUserId(rs.getInt("user_id"));
	                ticket.setUniversityId(rs.getInt("university_id"));
	                ticket.setSubject(rs.getString("subject"));
	                ticket.setMessage(rs.getString("message"));
	                ticket.setDepartment(rs.getString("department"));
	                ticket.setCategory(rs.getString("category"));
	                ticket.setStatus(rs.getString("status"));
	                
	                ticketList.add(ticket);
	            }
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return ticketList;
	}
	
	public Ticket getTicketById(int id) {
	    Ticket ticket = null;
	    String sql = "SELECT * FROM ticket WHERE ticket_id = ?";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, id);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                ticket = new Ticket();
	                ticket.setTicketId(rs.getInt("ticket_id"));
	                ticket.setUserId(rs.getInt("user_id"));
	                ticket.setUniversityId(rs.getInt("university_id"));
	                ticket.setSubject(rs.getString("subject"));
	                ticket.setMessage(rs.getString("message"));
	                ticket.setDepartment(rs.getString("department"));
	                ticket.setCategory(rs.getString("category"));
	                ticket.setStatus(rs.getString("status"));
	            }
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return ticket;
	}

	public void deleteTicketById(int id) {
	    String sql = "DELETE FROM ticket WHERE ticket_id = ?";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, id);

	        int rowsDeleted = pstmt.executeUpdate();

	        if (rowsDeleted > 0) {
	            System.out.println("Ticket with ID " + id + " deleted successfully.");
	        } else {
	            System.out.println("No ticket found with ID " + id + ".");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	
	public void updateTicket(Ticket ticket) {
	    String sql = "UPDATE ticket SET user_id = ?, university_id = ?, subject = ?, message = ?, department = ?, category = ?WHERE ticket_id = ?";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, ticket.getUserId());
	        pstmt.setInt(2, ticket.getUniversityId()); // Make sure getter name matches your model
	        pstmt.setString(3, ticket.getSubject());
	        pstmt.setString(4, ticket.getMessage());
	        pstmt.setString(5, ticket.getDepartment());
	        pstmt.setString(6, ticket.getCategory());
	        pstmt.setInt(7, ticket.getTicketId());

	        int rowsUpdated = pstmt.executeUpdate();

	        if (rowsUpdated > 0) {
	            System.out.println("Ticket updated successfully!");
	        } else {
	            System.out.println("No ticket found with ID: " + ticket.getTicketId());
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}

	public List<Ticket> getTicketsForAgent(int id){
		List<Ticket> tl = new ArrayList<Ticket>();
		
		String sql = "SELECT * FROM ticket WHERE university_id = ? ORDER BY created_at DESC";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, id);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Ticket ticket = new Ticket();
	                ticket.setTicketId(rs.getInt("ticket_id"));
	                ticket.setUserId(rs.getInt("user_id"));
	                ticket.setUniversityId(rs.getInt("university_id"));
	                ticket.setSubject(rs.getString("subject"));
	                ticket.setMessage(rs.getString("message"));
	                ticket.setDepartment(rs.getString("department"));
	                ticket.setCategory(rs.getString("category"));
	                ticket.setStatus(rs.getString("status"));
	                
	                tl.add(ticket);
	            }
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

		
		return tl;
	}
	
	public void changeTicketStatusToResolved(int tid) {
	    String sql = "UPDATE ticket SET status = 'Resolved' WHERE ticket_id = ?";
	    
	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, tid);
	        int rowsUpdated = pstmt.executeUpdate();
	        
	        if (rowsUpdated > 0) {
	            System.out.println("Ticket status updated to Resolved successfully.");
	        } else {
	            System.out.println("No ticket found with ID: " + tid);
	        }
	        
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	
	public void changeTicketStatusToInProgress(int tid) {
	    String sql = "UPDATE ticket SET status = 'In Progress' WHERE ticket_id = ?";
	    
	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, tid);
	        int rowsUpdated = pstmt.executeUpdate();
	        
	        if (rowsUpdated > 0) {
	            System.out.println("Ticket status updated to In Progress successfully.");
	        } else {
	            System.out.println("No ticket found with ID: " + tid);
	        }
	        
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	
	public void changeTicketStatusToOpens(int tid) {
	    String sql = "UPDATE ticket SET status = 'Open' WHERE ticket_id = ?";
	    
	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, tid);
	        int rowsUpdated = pstmt.executeUpdate();
	        
	        if (rowsUpdated > 0) {
	            System.out.println("Ticket status updated to Open successfully.");
	        } else {
	            System.out.println("No ticket found with ID: " + tid);
	        }
	        
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	
	public int countOpenTickets() {
	    String sql = "SELECT COUNT(ticket_id) AS total FROM ticket WHERE status = 'Open'";
	    int count = 0;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        if (rs.next()) {
	            count = rs.getInt("total");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return count;
	}
	
	public int countInProgressTickets() {
	    String sql = "SELECT COUNT(ticket_id) AS total FROM ticket WHERE status = 'In Progress'";
	    int count = 0;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        if (rs.next()) {
	            count = rs.getInt("total");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return count;
	}

	public int countResolvedTickets() {
	    String sql = "SELECT COUNT(ticket_id) AS total FROM ticket WHERE status = 'Resolved'";
	    int count = 0;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        if (rs.next()) {
	            count = rs.getInt("total");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return count;
	}


}
