package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.universityAgent;
import model.user;
import utils.dbConnect;

public class agentService {
	
	public void addAgent(universityAgent agent) {
	    String sql = "INSERT INTO agent(first_name, last_name, agent_email, password, contact_number, university_id) VALUES (?, ?, ?, ?, ?, ?)";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, agent.getFirstName());
	        pstmt.setString(2, agent.getLastName());
	        pstmt.setString(3, agent.getEmail());
	        pstmt.setString(4, agent.getPassword());
	        pstmt.setString(5, agent.getPhone());
	        pstmt.setInt(6, agent.getUniversityId());

	        int rowsInserted = pstmt.executeUpdate();
	        if (rowsInserted > 0) {
	            System.out.println("A new agent was inserted successfully!");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	
	public boolean validate(universityAgent agent) {
	    String query = "SELECT * FROM agent WHERE agent_email = ? AND password = ?";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        pstmt.setString(1, agent.getEmail());
	        pstmt.setString(2, agent.getPassword());

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                return true;
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;
	}

	public universityAgent getOne(universityAgent agent) {
		String sql = "Select * FROM agent WHERE agent_email = ? AND password = ?";
		
		try (Connection conn = dbConnect.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)){
			
			pstmt.setString(1, agent.getEmail());
			pstmt.setString(2, agent.getPassword());
			
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					agent.setFirstName(rs.getString("first_name"));
					agent.setLastName(rs.getString("last_name"));
					agent.setEmail(rs.getString("agent_email"));
					agent.setPhone(rs.getString("contact_number"));
					agent.setUniversityId(rs.getInt("university_id"));
					agent.setAgentId(rs.getInt("agent_id"));
					agent.setProfilePhoto(rs.getBytes("image"));
					
					return agent;
				}
			} 
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	public universityAgent getAgentById(int aid) {
        String sql = "SELECT * FROM agent WHERE agent_id = ?";
        universityAgent agent = null;

        try (Connection con = dbConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, aid);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    agent = new universityAgent();
                    agent.setAgentId(rs.getInt("agent_id"));
                    agent.setFirstName(rs.getString("first_name"));
                    agent.setLastName(rs.getString("last_name"));
                    agent.setEmail(rs.getString("agent_email"));
                    agent.setPassword(rs.getString("password"));
                    agent.setPhone(rs.getString("contact_number"));
                    agent.setProfilePhoto(rs.getBytes("image"));
                    agent.setUniversityId(rs.getInt("university_id"));

                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return agent;
    }
	
	public boolean updateAgent(universityAgent agent) {
        String sql = "UPDATE agent SET first_name = ?, last_name = ?, agent_email = ?, contact_number = ?, password = ?, image = ? WHERE agent_id = ?";

        try (Connection con = dbConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, agent.getFirstName());
            ps.setString(2, agent.getLastName());
            ps.setString(3, agent.getEmail());
            ps.setString(4, agent.getPhone());
            ps.setString(5, agent.getPassword()); // plain text password (not recommended)
            if (agent.getProfilePhoto() != null) {
                ps.setBytes(6, agent.getProfilePhoto());
            } else {
                ps.setNull(6, java.sql.Types.BLOB);
            }
            ps.setInt(7, agent.getAgentId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
	
	public List<universityAgent> getAllAgents() {
	    List<universityAgent> agents = new ArrayList<universityAgent>();
	    String sql = "SELECT * FROM agent";

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            universityAgent agent = new universityAgent();
                agent.setAgentId(rs.getInt("agent_id"));
                agent.setFirstName(rs.getString("first_name"));
                agent.setLastName(rs.getString("last_name"));
                agent.setEmail(rs.getString("agent_email"));
                agent.setPassword(rs.getString("password"));
                agent.setPhone(rs.getString("contact_number"));
                agent.setProfilePhoto(rs.getBytes("image"));
                agent.setUniversityId(rs.getInt("university_id"));

	            agents.add(agent);
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return agents;
	}


}
