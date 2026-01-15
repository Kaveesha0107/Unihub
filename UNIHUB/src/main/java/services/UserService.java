package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.user;
import utils.dbConnect;

public class UserService {
	 public void regUser(user users) {
	        try {
	            String query = "INSERT INTO user (first_name, last_name, email, password, contact_number) VALUES (?, ?, ?, ?, ?)";
	            PreparedStatement pstmt = dbConnect.getConnection().prepareStatement(query);
	            pstmt.setString(1, users.getFirstname());
	            pstmt.setString(2, users.getLastname());
	            pstmt.setString(3, users.getEmail());
	            pstmt.setString(4, users.getPassword());
	            pstmt.setString(5, users.getPhone());

	            pstmt.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    public List<user> getAllUsers() {
	        List<user> list = new ArrayList<user>();
	        try {
	            Connection con = dbConnect.getConnection();
	            Statement stmt = con.createStatement();
	            ResultSet rs = stmt.executeQuery("SELECT * FROM user");

	            while (rs.next()) {
	                user u = new user();
	                u.setUserId(rs.getInt("user_id"));
	                u.setFirstname(rs.getString("first_name"));
	                u.setLastname(rs.getString("last_name"));
	                u.setBio(rs.getString("user_bio"));
	                u.setPhone(rs.getString("contact_number"));
	                u.setEmail(rs.getString("email"));
	                u.setPassword(rs.getString("password"));
	                list.add(u);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    }

	    public void deleteUserByEmail(String email) {
	        try {
	            Connection con = dbConnect.getConnection();
	            String query = "DELETE FROM user WHERE email = ?";
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setString(1, email);
	            pstmt.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public boolean validate(user cus) {
			
			try {
				
				String query ="select * from user where email='"+cus.getEmail()+"'and password='"+cus.getPassword()+"'";

				Statement statement=dbConnect.getConnection().createStatement();
				
				ResultSet rs = statement.executeQuery(query);
				
				if(rs.next()) {
					
					return true;
				}
				
				
			}
			catch(Exception e) {
				
				e.printStackTrace();
				
			}
			
			return false;
			
			
		}
		

	    public user getOne(user user) {
	        String query = "SELECT * FROM user WHERE email = ? AND password = ?";

	        try (Connection conn = dbConnect.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(query)) {

	            pstmt.setString(1, user.getEmail());
	            pstmt.setString(2, user.getPassword()); // Ideally, password should be hashed

	            try (ResultSet rs = pstmt.executeQuery()) {
	                if (rs.next()) {
	                	user.setUserId(rs.getInt("user_id"));
	                    user.setFirstname(rs.getString("first_name"));
	                    user.setLastname(rs.getString("last_name"));
	                    user.setEmail(rs.getString("email"));
	                    user.setPassword(rs.getString("password"));
	                    user.setPhone(rs.getString("contact_number"));
	                    user.setBio(rs.getString("user_bio"));
	                    user.setProfileImage(rs.getBytes("image"));

	                    return user;
	                }
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return null;
	    }
	    
	    public user getUserById(int id) {
	    	user user = new user();
	    	
	    	String sql = "SELECT * FROM user WHERE user_id = ?";
	    	
	    	try (Connection conn = dbConnect.getConnection();
		             PreparedStatement pstmt = conn.prepareStatement(sql)) {

		            pstmt.setInt(1, id);

		            try (ResultSet rs = pstmt.executeQuery()) {
		                if (rs.next()) {
		                	user.setUserId(rs.getInt("user_id"));
		                    user.setFirstname(rs.getString("first_name"));
		                    user.setLastname(rs.getString("last_name"));
		                    user.setEmail(rs.getString("email"));
		                    user.setPassword(rs.getString("password"));
		                    user.setPhone(rs.getString("contact_number"));
		                    user.setBio(rs.getString("user_bio"));
		                    user.setProfileImage(rs.getBytes("image"));

		                    return user;
		                }
		            }

		        } catch (Exception e) {
		            e.printStackTrace();
		        }

		        return null;
	    }
	    
	    public boolean updateUser(user user) {
	        String sql = "UPDATE user SET first_name = ?, last_name = ?, email = ?, contact_number = ?, user_bio = ?, password = ?, image = ? WHERE user_id = ?";

	        try (Connection con = dbConnect.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setString(1, user.getFirstname());
	            ps.setString(2, user.getLastname());
	            ps.setString(3, user.getEmail());
	            ps.setString(4, user.getPhone());
	            ps.setString(5, user.getBio());
	            ps.setString(6, user.getPassword()); // plain text password (not recommended)
	            if (user.getProfileImage() != null) {
	                ps.setBytes(7, user.getProfileImage());
	            } else {
	                ps.setNull(7, java.sql.Types.BLOB);
	            }
	            ps.setInt(8, user.getUserId());

	            int rowsUpdated = ps.executeUpdate();
	            return rowsUpdated > 0;

	        } catch (SQLException | ClassNotFoundException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    
	    public int userCount() {
	        String sql = "SELECT COUNT(user_id) AS total FROM user";
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
	    
	    public void deleteUserById(int id) {
	        String sql = "DELETE FROM user WHERE user_id = ?";

	        try (Connection conn = dbConnect.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ps.setInt(1, id);
	            int affectedRows = ps.executeUpdate();

	            if (affectedRows == 0) {
	                System.out.println("No user found with id: " + id);
	            } else {
	                System.out.println("User deleted successfully with id: " + id);
	            }

	        } catch (SQLException | ClassNotFoundException e) {
	            e.printStackTrace();
	            // Handle exception properly (log or rethrow)
	        }
	    }



}
