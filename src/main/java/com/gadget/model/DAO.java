package com.gadget.model;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class DAO {
	private Connection c;

	public DAO() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		c = DriverManager.getConnection("jdbc:mysql://localhost:3306/gadgetfix", "root", "Incapp@12");
	}

	public void closeConnection() throws SQLException {
		c.close();
	}

	public String adminLogin(String email, String password) throws SQLException {
		PreparedStatement p = c.prepareStatement("select * from admin where email=? and password=?");
		p.setString(1, email);
		p.setString(2, password);
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			return rs.getString("name");
		} else {
			return null;
		}
	}

	public String repairExpertLogin(String email, String password) throws SQLException {
		PreparedStatement p = c
				.prepareStatement("select * from repair_experts where email=? and password=? and status='Active'");
		p.setString(1, email);
		p.setString(2, password);
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			return rs.getString("name");
		} else {
			return null;
		}
	}

	public String userSignIn(String email, String password) throws SQLException {
		String hashedPassword = hashPassword(password);
		PreparedStatement p = c.prepareStatement("select * from users where email=? and password=?");
		p.setString(1, email);
		p.setString(2, hashedPassword);
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			return rs.getString("name");
		} else {
			return null;
		}
	}

	public boolean checkRepairExpertPassword(String email) throws SQLException {
		PreparedStatement p = c.prepareStatement("select * from repair_experts where email=? and password='password'");
		p.setString(1, email);
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			return true;
		} else {
			return false;
		}
	}

	public void addEnquiry(String name, String phone) throws SQLException {
		PreparedStatement p = c.prepareStatement(
				"insert into enquiries (name,phone,status,enquery_date) values (?,?,'Pending',CURRENT_DATE)");
		p.setString(1, name);
		p.setString(2, phone);
		p.executeUpdate();
	}

	public void addrepairEnquiry(String name, String phone) throws SQLException {
		PreparedStatement p = c.prepareStatement(
				"insert into repairenquiry (name,phone,status,e_date) values (?,?,'Pending',CURRENT_DATE)");
		p.setString(1, name);
		p.setString(2, phone);
		p.executeUpdate();
	}

	public void addRepairAmount(int id, int repair_amount) throws SQLException {
		PreparedStatement p = c.prepareStatement("update gadgets set repair_amount=?  where id=?");
		p.setInt(1, repair_amount);
		p.setInt(2, id);
		p.executeUpdate();
	}

	public String userSignUp(String name, String phone, String email, String password) throws SQLException {
		String hashedPassword = hashPassword(password); 
		PreparedStatement p = c.prepareStatement("insert into users (email,name,phone,password) values (?,?,?,?)");
		p.setString(1, email);
		p.setString(2, name);
		p.setString(3, phone);
		p.setString(4, hashedPassword);
		try {
			p.executeUpdate();
			return "success";
		} catch (SQLIntegrityConstraintViolationException e) {
			return "Email Already Exist !";
		}
	}

	public String addRepairExpert(String name, String phone, String email, String state, String city, String area,
			InputStream photo) throws SQLException {
		PreparedStatement p = c.prepareStatement(
				"insert into repair_experts (email,name,phone,state,city,area,photo,status,password) values (?,?,?,?,?,?,?,'Active','password')");
		p.setString(1, email);
		p.setString(2, name);
		p.setString(3, phone);
		p.setString(4, state);
		p.setString(5, city);
		p.setString(6, area);
		p.setBinaryStream(7, photo);
		try {
			p.executeUpdate();
			return "Registration Success !";
		} catch (SQLIntegrityConstraintViolationException e) {
			return "Email Already Exist !";
		}
	}

	public void addGadget(String name, String brand_name, String problem, InputStream photo1, InputStream photo2,
			String user_email, String repair_expert_email, String address) throws SQLException {
		c.setAutoCommit(false);

		try {
			String gadgetSQL = "INSERT INTO gadgets (name, brand_name, problem, photo1, photo2, repair_amount, user_email, repair_expert_email, address) "
					+ "VALUES (?, ?, ?, ?, ?, 0, ?, ?, ?)";

			PreparedStatement gadgetStmt = c.prepareStatement(gadgetSQL, Statement.RETURN_GENERATED_KEYS);
			gadgetStmt.setString(1, name);
			gadgetStmt.setString(2, brand_name);
			gadgetStmt.setString(3, problem);
			gadgetStmt.setBinaryStream(4, photo1);
			gadgetStmt.setBinaryStream(5, photo2);
			gadgetStmt.setString(6, user_email);
			gadgetStmt.setString(7, repair_expert_email);
			gadgetStmt.setString(8, address);
			gadgetStmt.executeUpdate();

			ResultSet generatedKeys = gadgetStmt.getGeneratedKeys();
			if (generatedKeys.next()) {
				int gadgetId = generatedKeys.getInt(1);

				String statusSQL = "INSERT INTO status (id,status, requested, amount_rec, approved, received, repaired, delivered, confirmed) "
						+ "VALUES (?,?, now(), now(), now(), now(), now(), now(), now())";

				PreparedStatement statusStmt = c.prepareStatement(statusSQL);
				statusStmt.setInt(1, gadgetId);
				statusStmt.setString(2, "Pending");
				statusStmt.executeUpdate();
			} else {
				throw new SQLException("Creating gadget failed, no ID obtained.");
			}
			c.commit();
		} catch (SQLException e) {
			c.rollback();
			throw e;
		} finally {
			c.setAutoCommit(true);
		}
	}

	public void changeEnquiryStatus(int id, String status) throws SQLException {
		PreparedStatement p = c.prepareStatement("update enquiries set status=? where id=?");
		p.setString(1, status);
		p.setInt(2, id);
		p.executeUpdate();
	}

	public void deleteGadget(int id) throws SQLException {
	    PreparedStatement p1 = c.prepareStatement("DELETE FROM status WHERE id = ?");
	    p1.setInt(1, id);
	    p1.executeUpdate();

	    PreparedStatement p2 = c.prepareStatement("DELETE FROM gadgets WHERE id = ?");
	    p2.setInt(1, id);
	    p2.executeUpdate();
	}

	public void changeGadgetStatus(int id, String status) throws SQLException {
		PreparedStatement p = null;
		if (status.equalsIgnoreCase("accept")) {
			p = c.prepareStatement("update status set status=?,approved = now() where id=?");
		} else if (status.equalsIgnoreCase("WaitingApproval")) {
			p = c.prepareStatement("update status set status=?, amount_rec = now() where id=?");
		} else if (status.equalsIgnoreCase("decline")) {
			p = c.prepareStatement("update status set status=?, approved = now() where id=?");
		} else if (status.equalsIgnoreCase("received")) {
			p = c.prepareStatement("update status set status=?, received = now() where id=?");
		} else if (status.equalsIgnoreCase("repaired")) {
			p = c.prepareStatement("update status set status=?, repaired = now() where id=?");
		} else if (status.equalsIgnoreCase("delivered")) {
			p = c.prepareStatement("update status set status=?, delivered = now() where id=?");
		} else if (status.equalsIgnoreCase("confirmed")) {
			p = c.prepareStatement("update status set status=?, confirmed = now() where id=?");
		} else if (status.equalsIgnoreCase("repairing")) {
			p = c.prepareStatement("update status set status=? where id=?");
		}

		p.setString(1, status);
		p.setInt(2, id);
		p.executeUpdate();
	}

	public void changeRepairExpertStatus(String email, String status) throws SQLException {
		PreparedStatement p = c.prepareStatement("update repair_experts set status=? where email=?");
		p.setString(1, status);
		p.setString(2, email);
		p.executeUpdate();
	}

	public boolean changePassword(String old_password, String new_password, String email, String type)
			throws SQLException {
		PreparedStatement p = null;
		if (type.equalsIgnoreCase("repair_expert")) {
			p = c.prepareStatement("update repair_experts set password=? where email=? and password=?");
		}
		p.setString(1, new_password);
		p.setString(2, email);
		p.setString(3, old_password);
		int x = p.executeUpdate();
		if (x == 0) {
			return false;
		} else {
			return true;
		}
	}

	public ArrayList<HashMap> getAllEnquiries() throws SQLException {
		PreparedStatement p = c.prepareStatement("select * from enquiries order by enquery_date DESC");
		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> enquiries = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> enquiry = new HashMap<>();
			enquiry.put("id", rs.getInt("id"));
			enquiry.put("name", rs.getString("name"));
			enquiry.put("phone", rs.getString("phone"));
			enquiry.put("status", rs.getString("status"));
			enquiry.put("enquery_date", rs.getDate("enquery_date"));
			enquiries.add(enquiry);
		}
		return enquiries;
	}

	public ArrayList<HashMap> getusers() throws SQLException {
		PreparedStatement p = c.prepareStatement("select * from users ");
		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> enquiries = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> enquiry = new HashMap<>();

			enquiry.put("name", rs.getString("name"));
			enquiry.put("email", rs.getString("email"));
			enquiry.put("phone", rs.getString("phone"));

			enquiries.add(enquiry);
		}
		return enquiries;
	}

	public ArrayList<HashMap> getAllGadgetRequest() throws SQLException {
		PreparedStatement p = c.prepareStatement("select g.*, s.status FROM gadgets g JOIN status s ON g.id = s.id");
		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> enquiries = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> enquiry = new HashMap<>();
			enquiry.put("id", rs.getInt("id"));
			enquiry.put("name", rs.getString("name"));
			enquiry.put("status", rs.getString("status"));
			enquiries.add(enquiry);
		}
		return enquiries;
	}

	public ArrayList<HashMap> getAllRepairExperts() throws SQLException {
		PreparedStatement p = c.prepareStatement("select * from repair_experts order by name ASC");
		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> repairExperts = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> repairExpert = new HashMap<>();
			repairExpert.put("name", rs.getString("name"));
			repairExpert.put("phone", rs.getString("phone"));
			repairExpert.put("email", rs.getString("email"));
			repairExpert.put("state", rs.getString("state"));
			repairExperts.add(repairExpert);
		}
		return repairExperts;
	}

	public ArrayList<HashMap> getAllRepairRequestsByEmail(String type, String email) throws SQLException {
		PreparedStatement p;
		if (type.equalsIgnoreCase("user")) {
			p = c.prepareStatement(
					"SELECT g.*, s.status FROM gadgets g JOIN status s ON g.id = s.id WHERE g.user_email = ? ORDER BY g.id DESC");
			;
		} else {
			p = c.prepareStatement("select * from gadgets where repair_expert_email=? order by id DESC");
			p = c.prepareStatement(
					"SELECT g.*, s.status FROM gadgets g JOIN status s ON g.id = s.id WHERE g.repair_expert_email = ? ORDER BY g.id DESC");
		}
		p.setString(1, email);
		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> gadgets = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> gadget = new HashMap<>();
			gadget.put("id", rs.getInt("id"));
			gadget.put("name", rs.getString("name"));
			gadget.put("brand_name", rs.getString("brand_name"));
			gadget.put("problem", rs.getString("problem"));
			gadget.put("repair_amount", rs.getString("repair_amount"));
			gadget.put("user_email", rs.getString("user_email"));
			gadget.put("address", rs.getString("address"));
			gadget.put("repair_expert_email", rs.getString("repair_expert_email"));
			gadget.put("status", rs.getString("status"));
			gadgets.add(gadget);
		}
		return gadgets;
	}

	public ArrayList<HashMap> getAllRepairRequestsById(int id) throws SQLException {
		PreparedStatement p = c.prepareStatement("SELECT * FROM gadgets " + "JOIN status ON gadgets.id = status.id "
				+ "WHERE gadgets.id = ? " + "ORDER BY gadgets.id DESC");
		p.setInt(1, id);
		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> gstatus = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> gadget = new HashMap<>();
			gadget.put("id", rs.getInt("id"));
			gadget.put("name", rs.getString("name"));
			gadget.put("brand_name", rs.getString("brand_name"));
			gadget.put("problem", rs.getString("problem"));
			gadget.put("status", rs.getString("status"));
			gadget.put("repair_amount", rs.getString("repair_amount"));
			gadget.put("user_email", rs.getString("user_email"));
			gadget.put("repair_expert_email", rs.getString("repair_expert_email"));
			gadget.put("requested", rs.getString("requested"));
			gadget.put("amount_rec", rs.getString("amount_rec"));
			gadget.put("approved", rs.getString("approved"));
			gadget.put("received", rs.getString("received"));
			gadget.put("repaired", rs.getString("repaired"));
			gadget.put("delivered", rs.getString("delivered"));
			gadget.put("confirmed", rs.getString("confirmed"));
			gstatus.add(gadget);
		}
		return gstatus;
	}

	public ArrayList<HashMap> getAllRepairRequests() throws SQLException {
		PreparedStatement p = c.prepareStatement("select * from gadgets  order by id DESC");

		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> gstatus = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> gadget = new HashMap<>();
			gadget.put("id", rs.getInt("id"));
			gadget.put("name", rs.getString("name"));
			gadget.put("brand_name", rs.getString("brand_name"));
			gadget.put("problem", rs.getString("problem"));
			gadget.put("status", rs.getString("status"));
			gadget.put("repair_amount", rs.getString("repair_amount"));
			gadget.put("user_email", rs.getString("user_email"));
			gadget.put("repair_expert_email", rs.getString("repair_expert_email"));
			gadget.put("requested", rs.getString("requested"));
			gadget.put("amount_rec", rs.getString("amount_rec"));
			gadget.put("approved", rs.getString("approved"));
			gadget.put("received", rs.getString("received"));
			gadget.put("repaired", rs.getString("repaired"));
			gadget.put("delivered", rs.getString("delivered"));
			gstatus.add(gadget);
		}
		return gstatus;
	}

	public ArrayList<HashMap> getAllRepairExpertsByStateCityArea(String state, String city, String area)
			throws SQLException {
		PreparedStatement p = c.prepareStatement(
				"select * from repair_experts where state=? and city=? and area like ? order by name ASC");
		p.setString(1, state);
		p.setString(2, city);
		p.setString(3, "%" + area + "%");
		ResultSet rs = p.executeQuery();
		ArrayList<HashMap> repairExperts = new ArrayList<>();
		while (rs.next()) {
			HashMap<String, Object> repairExpert = new HashMap<>();
			repairExpert.put("name", rs.getString("name"));
			repairExpert.put("phone", rs.getString("phone"));
			repairExpert.put("email", rs.getString("email"));
			repairExpert.put("state", rs.getString("state"));
			repairExpert.put("city", rs.getString("city"));
			repairExpert.put("area", rs.getString("area"));
			repairExpert.put("status", rs.getString("status"));
			repairExperts.add(repairExpert);
		}
		return repairExperts;
	}

	public HashMap getRepairExpertDetails(String email) throws SQLException {
		PreparedStatement p = c.prepareStatement("select * from repair_experts where email=?");
		p.setString(1, email);
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			HashMap<String, Object> repairExpert = new HashMap<>();
			repairExpert.put("name", rs.getString("name"));
			repairExpert.put("phone", rs.getString("phone"));
			repairExpert.put("email", rs.getString("email"));
			repairExpert.put("state", rs.getString("state"));
			repairExpert.put("city", rs.getString("city"));
			repairExpert.put("area", rs.getString("area"));
			repairExpert.put("status", rs.getString("status"));
			return repairExpert;
		} else {
			return null;
		}
	}

	public byte[] getPhoto(String type, String email) throws SQLException {
		PreparedStatement p = null;
		if (type.equalsIgnoreCase("repair_expert")) {
			p = c.prepareStatement("select photo from repair_experts where email=?");
			p.setString(1, email);
		}
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			return rs.getBytes("photo");
		} else {
			return null;
		}
	}

	public byte[] getGadgetPhoto(int photo_no, int id) throws SQLException {
		PreparedStatement p = c.prepareStatement("select photo1,photo2 from gadgets where id=?");
		p.setInt(1, id);
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			if (photo_no == 1)
				return rs.getBytes("photo1");
			else
				return rs.getBytes("photo2");
		} else {
			return null;
		}
	}
	
	// Built-in Java hash function using SHA-256
		private String hashPassword(String password) {
		    try {
		        MessageDigest md = MessageDigest.getInstance("SHA-256");
		        byte[] hashBytes = md.digest(password.getBytes());
		        StringBuilder sb = new StringBuilder();
		        for (byte b : hashBytes) {
		            sb.append(String.format("%02x", b)); 
		        }
		        return sb.toString();
		    } catch (NoSuchAlgorithmException e) {
		        throw new RuntimeException("SHA-256 not supported", e);
		    }
		}

}
