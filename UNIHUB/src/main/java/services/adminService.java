package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.admin;
import utils.dbConnect;

public class adminService {
	
	public admin getAdminByEmail(admin ad) {
	    String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
	    admin admn = null;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setString(1, ad.getEmail());
	        ps.setString(2, ad.getPassword()); // Make sure password is hashed before calling this!

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                admn = new admin();
	                admn.setAdminId(rs.getInt("adminId"));
	                admn.setEmail(rs.getString("email"));
	                admn.setPassword(rs.getString("password"));
	                admn.setFullName(rs.getString("fullName"));
	                admn.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return admn;
	}

	public boolean validate(admin admin) {
	    String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	         
	        ps.setString(1, admin.getEmail());
	        ps.setString(2, admin.getPassword());

	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next();
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

}
