package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Response;
import utils.dbConnect;

public class ResponseService {

	public void saveResponse(Response rsps) {
	    String sql = "INSERT INTO responses(ticket_id, agent_id, title, description, next_steps, attachment_paths) VALUES (?, ?, ?, ?, ?, ?)";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, rsps.getTicketId());
	        pstmt.setInt(2, rsps.getAgentId());
	        pstmt.setString(3, rsps.getTitle());
	        pstmt.setString(4, rsps.getDescription());
	        pstmt.setString(5, rsps.getNextSteps());
	        pstmt.setString(6, rsps.getAttachmentPaths());

	        pstmt.executeUpdate();

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        // Handle exceptions as needed
	    }
	}
	
	public Response getResponseById(int tid) {
	    String sql = "SELECT * FROM responses WHERE ticket_id = ?";
	    Response response = null;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, tid);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                response = new Response();
	                response.setResponseId(rs.getInt("response_id"));
	                response.setTicketId(rs.getInt("ticket_id"));
	                response.setAgentId(rs.getInt("agent_id"));
	                response.setTitle(rs.getString("title"));
	                response.setDescription(rs.getString("description"));
	                response.setNextSteps(rs.getString("next_steps"));
	                response.setAttachmentPaths(rs.getString("attachment_paths"));
	                response.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return response;
	}


	public void updateResponse(Response response) {
	    String sql = "UPDATE responses SET title = ?, description = ?, next_steps = ?, attachment_paths = ? WHERE response_id = ?";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, response.getTitle());
	        pstmt.setString(2, response.getDescription());
	        pstmt.setString(3, response.getNextSteps());
	        pstmt.setString(4, response.getAttachmentPaths());
	        pstmt.setInt(5, response.getResponseId());

	        int rowsUpdated = pstmt.executeUpdate();

	        if (rowsUpdated == 0) {
	            throw new SQLException("Updating response failed, no rows affected.");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        // Handle exception as needed (e.g., throw custom exception)
	    }
	}

	public Response getResponseByRId(int rid) {
	    String sql = "SELECT * FROM responses WHERE response_id = ?";
	    Response response = null;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, rid);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                response = new Response();
	                response.setResponseId(rs.getInt("response_id"));
	                response.setTicketId(rs.getInt("ticket_id"));
	                response.setAgentId(rs.getInt("agent_id"));
	                response.setTitle(rs.getString("title"));
	                response.setDescription(rs.getString("description"));
	                response.setNextSteps(rs.getString("next_steps"));
	                response.setAttachmentPaths(rs.getString("attachment_paths"));
	                response.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return response;
	}
	
	public void deleteResponseByTicketId(int tid) throws SQLException {
	    String sql = "DELETE FROM responses WHERE ticket_id = ?";
	    
	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	         
	        ps.setInt(1, tid);
	        int rowsDeleted = ps.executeUpdate();
	        
	        System.out.println("Deleted " + rowsDeleted + " response(s) for ticket ID: " + tid);
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    } catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
	}
	
	public void deleteResponseByResponseId(int rid) throws SQLException {
	    String sql = "DELETE FROM responses WHERE response_id = ?";
	    
	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	         
	        ps.setInt(1, rid);
	        ps.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    } catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
	}

}
