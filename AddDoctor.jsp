<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>
<%
Connection conn = null;

if(request.getParameter("Submit") != null) {

	try {
		connmaker cn = new connmaker();
		conn = cn.mkconn(); 

		String person_id = (request.getParameter("PERSONID").trim());
		String doctor = (request.getParameter("DOCTOR").trim());

		String doctorInsertSql = "INSERT INTO family_doctor" +
			    "(doctor_id, patient_id) VALUES ('"+doctor+"', '"+person_id+"')";
	
		Statement stmt = null;
	    	ResultSet rset = null;
	
		stmt = conn.createStatement();
		stmt.executeUpdate(doctorInsertSql);
	} catch (Exception ex){

		out.println("<hr>"+ ex.getMessage() +"<hr>");
	}

	out.println("Doctor was added.");

        out.println("<br><a href='./Home_Menu.jsp'>Return to menu</a>");
} else {%>
<%@ include file="AddDoctor.html"%>
<%}%>
