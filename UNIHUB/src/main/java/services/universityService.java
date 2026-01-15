package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.university;
import utils.dbConnect;

public class universityService {

	public void addUni(university uni) {
		String sql = "INSERT INTO university(name, location) VALUES (?, ?)";

		try (Connection conn = dbConnect.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, uni.getName());
			pstmt.setString(2, uni.getLocation());

			int rowsInserted = pstmt.executeUpdate();
			if (rowsInserted > 0) {
				System.out.println("A new university was inserted successfully!");
			}

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public university uniByName(String name) {
		String sql = "SELECT * FROM university WHERE name = ?";
		university uni = null;

		try (Connection conn = dbConnect.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, name);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					uni = new university();
					uni.setName(rs.getString("name"));
					uni.setLocation(rs.getString("location"));
					uni.setUniversityId(rs.getInt("university_id"));
				}
			}

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		return uni;
	}

	public List<university> getAllUnis() {
		List<university> uniList = new ArrayList<>();

		String sql = "SELECT * FROM university";

		try (Connection conn = dbConnect.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				university uni = new university();
				uni.setName(rs.getString("name"));
				uni.setUniversityId(rs.getInt("university_id"));
				uni.setLocation(rs.getString("location"));

				uniList.add(uni);
			}

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		return uniList;
	}

	public university getUniById(int id) {
		university uni = new university();

		String sql = "SELECT * FROM university WHERE university_id = ?";

		try (Connection conn = dbConnect.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {
			
			pstmt.setInt(1, id);
			try(ResultSet rs = pstmt.executeQuery()){
				
				if(rs.next()) {
					uni.setName(rs.getString("name"));
					uni.setLocation(rs.getString("location"));
					uni.setUniversityId(rs.getInt("university_id"));
					
					return uni;
				}
				
			}

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public int uniCount() {
	    String sql = "SELECT COUNT(university_id) AS total FROM university";
	    int count = 0;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        if (rs.next()) {
	            count = rs.getInt("total");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        // Handle exception properly (log it or rethrow)
	    }

	    return count;
	}


}
