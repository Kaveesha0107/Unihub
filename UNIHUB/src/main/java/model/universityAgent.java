package model;

import java.util.Base64;

public class universityAgent {
	
	private int agentId;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private String phone;
	private byte[] profilePhoto;
	private int universityId;
	
	public int getAgentId() {
		return agentId;
	}
	public void setAgentId(int agentId) {
		this.agentId = agentId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firshName) {
		this.firstName = firshName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public byte[] getProfilePhoto() {
		return profilePhoto;
	}
	public void setProfilePhoto(byte[] profilePhoto) {
		this.profilePhoto = profilePhoto;
	}
	public int getUniversityId() {
		return universityId;
	}
	public void setUniversityId(int universityId) {
		this.universityId = universityId;
	}
	public String getBase64Image() {
	    if (this.profilePhoto != null && this.profilePhoto.length > 0) {
	        return Base64.getEncoder().encodeToString(this.profilePhoto);
	    }
	    return null;
	}

}
