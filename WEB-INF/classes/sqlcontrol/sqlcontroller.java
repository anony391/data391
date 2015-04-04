/*This code is for making the connection to oracle and sending and retrieving information about login data
*/
package sqlcontrol;
import java.sql.*;
import java.io.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class sqlcontroller {
	public boolean logincheck(String user, String password, Connection conn) throws IOException, SQLException{
	    PreparedStatement pstmt = null;
	    ResultSet rset = null;
		pstmt = conn.prepareStatement("SELECT password FROM users WHERE user_name = ?");
	    pstmt.setString(1, user);
	    try{
			rset = pstmt.executeQuery();
	    }
	    catch(Exception ex){
    		throw new IOException("Cannot retrieve information from database server.");
	    }
	    String dbpassword = "";     //checking if results includes logininfo
	    while(rset != null && rset.next()){
	        dbpassword = rset.getString(1).trim();
	        if(password.equals(dbpassword)){        //need to change this to going to nextpag
	            return true;
	        }
	        else{
	            return false;
	        }
	    }
	    return false;
	}
	
	/*
	 * Generates a new person_id following the personID_sequence.
	 */
	public String generateNextID(Connection conn) throws IOException, SQLException {
		Statement stmt = null;
		ResultSet rset = null;
		String sqlString = "SELECT personID_sequence.nextval FROM DUAL";
		try{
		    stmt = conn.createStatement();
		    rset = stmt.executeQuery(sqlString);
		} catch(Exception ex) {
		    throw new IOException("Could not get next value in sequence.");
		
		}
		if ((rset != null) && rset.next()){
			return rset.getString("NEXTVAL");
		} else {
			return "error";
		}
		
	}
	
	public String classOfUser(Connection conn,String username) throws IOException, SQLException { 
		Statement stmt = null;
	    ResultSet rset = null;
		String sqlString = "SELECT class FROM users WHERE user_name = '"+username+"'";
		try{
		    stmt = conn.createStatement();
		    rset = stmt.executeQuery(sqlString);
		} catch(Exception ex) {
		    throw new IOException("Could not find class with specified username.");
		
		}
		if ((rset != null) && rset.next()){
			String classString = rset.getString("class");
			return classString;
		} else {
			return "error";
		}
	}


	public ResultSet search_database(Connection conn, String query, String dateTo, String dateFrom, String rankType) throws IOException, SQLException{
		if(!(query.equals(""))){
		//check class of user 
		//"Select From users where person_id = ?"//
		//if class == patient:
			String date = "";
			String sql;
			String rank_by;
			if(rankType.equals("recentfirst")){
				rank_by = "r.test_date desc";
			}
			else if(rankType.equals("recentlast")){
				rank_by = "r.test_date";
			}
			else{
				rank_by = "rank desc";
			}
			int person_id = 1;
			List<String> keywords = Arrays.asList(query.split("\\s*,\\s*"));
			String keyword = keywords.get(0);
			String name_score = "score(1) + score(2)";
			String diagnosis_score = "score(3)";
			String description_score = "score(4)";
			String contains_all = String.format("contains(first_name, '%s', 1) > 0 OR contains(last_name, '%s', 2) > 0 OR contains(diagnosis, '%s', 3) > 0 OR contains(description, '%s', 4) > 0", keyword,keyword,keyword,keyword);
			int count = 5;
			for (int i = 1; i < keywords.size(); i++) {
				int first_name_index_score = count++;
				int last_name_index_score = count++;
				int diagnosis_index_score = count++;
				int description_index_score = count++;
				keyword = keywords.get(i).trim();
				name_score = name_score+String.format("+score(%d)+score(%d)",first_name_index_score,last_name_index_score);
				diagnosis_score = diagnosis_score+String.format("+score(%d)",diagnosis_index_score);
				description_score = description_score+String.format("+score(%d)",description_index_score);
				contains_all = contains_all+String.format("OR contains(first_name, '%s', %d)>0 OR contains(last_name, '%s', %d)>0 OR contains(diagnosis, '%s', %d)>0 OR contains(description, '%s', %d)>0",keyword,first_name_index_score,keyword,last_name_index_score,keyword,diagnosis_index_score,keyword,description_index_score);	
			}
			
			if( !(dateTo.equals("")) && !(dateFrom.equals("")) ){
				date = String.format("AND r.test_date >=TO_DATE(%s, 'mm-dd-yyyy') AND r.test_date <=TO_DATE(%s, 'mm-dd-yyyy')", dateFrom, dateTo);
				sql = String.format("SELECT r.record_id, r.record_id, 6*(%s)+3*(%s)+(%s) as rank, r.test_date, r.patient_id, r.doctor_id, r.radiologist_id, r.test_type, r.prescribing_date, r.diagnosis, r.description FROM radiology_record r, persons p, pacs_images m WHERE p.person_id = r.patient_id AND p.person_id = 1 AND %s AND (%s) ORDER BY %s",name_score,diagnosis_score,description_score,date,contains_all, rank_by);
			}
			else{
				sql = String.format("SELECT r.record_id, r.record_id, 6*(%s)+3*(%s)+(%s) as rank, r.test_date, r.patient_id, r.doctor_id, r.radiologist_id, r.test_type, r.prescribing_date, r.diagnosis, r.description FROM radiology_record r, persons p WHERE p.person_id = r.patient_id AND p.person_id = 1 AND (%s) ORDER BY %s",name_score,diagnosis_score,description_score,contains_all, rank_by);
			}
		    	PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset2 = pstmt.executeQuery();
			return rset2;			
        	}
		else{			
			String date = "";
			String sql;
			String rank_by;
			if(rankType.equals("recentfirst")){
				rank_by = "r.test_date desc";
			}
			else if(rankType.equals("recentlast")){

				rank_by = "r.test_date";
			}
			else{
			
				return null;
			}
			if( !(dateTo.equals("")) && !(dateFrom.equals("")) ){
				date = String.format("r.test_date >=TO_DATE('%s', 'MM-DD-YYYY') AND r.test_date <=TO_DATE('%s', 'MM-DD-YYYY')", dateFrom, dateTo);
				sql = String.format("SELECT r.record_id, r.record_id, r.patient_id, r.test_date, r.patient_id, r.doctor_id, r.radiologist_id, r.test_type, r.prescribing_date, r.diagnosis, r.description FROM radiology_record r, persons p WHERE p.person_id = r.patient_id AND p.person_id = 1 AND %s ORDER BY %s", date, rank_by);
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rset2 = pstmt.executeQuery();
				return rset2;
			}					
		}
		return null;
	}


	public ResultSet search_images(Connection conn, String record_id) throws IOException, SQLException{
		try{
			String sql = "SELECT m.image_id, r.record_id FROM radiology_record r, pacs_images m WHERE r.record_id = m.record_id AND r.record_id ="+record_id;
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset2 = pstmt.executeQuery();
			return rset2;
		}
		catch(Exception ex){
			return null;
		}
	}

}
