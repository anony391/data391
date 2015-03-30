<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>
<%
Connection conn = null;
sqlcontroller sqlContrl = new sqlcontroller();
if(request.getParameter("Submit") != null) {	//extracting updateuser info

	try{
		connmaker cn = new connmaker();
		conn = cn.mkconn(); 	//creates a connection with database

		String person_id = (String) session.getAttribute("personID");

		if (!sqlContrl.classOfUser(conn,person_id).equals("a")){
			out.println("Only administrators can generate reports.");
%> <%@ include file="UserManageMenu.html"%>
<% 		}	

	}
	catch(Exception ex){
	out.println("<hr>"+ ex.getMessage() + "<hr>");
	}
	Statement stmt = null;
	ResultSet rset = null;

	/*Get updated user info*/
	String diagnosis = (request.getParameter("DIAGNOSIS").trim());
	String year = (request.getParameter("YEAR").trim());
	
    	String sqlString = "SELECT p.first_name,p.last_name,p.address,p.phone,FIRST(r.test_date) AS first_date " 
			+ "FROM persons p,radiology_record r WHERE p.person_id=r.patient_id,"
			+ "r.diagnosis='"+diagnosis+"',EXTRACT(YEAR FROM TO_DATE(r.test_date,'yyyy-mm-dd')='"+year+"' GROUP BY p.first_name,p.last_name,p.addresses,p.phone";

	try{
		stmt = conn.createStatement();
		rset = stmt.executeQuery(sqlString);

		out.println("First Name\tLastName\tAddress\tPhone Number\tFirst Test Date");
		while(rset != null && rset.next()){

			String first_name = rset.getString("first_name");
			String last_name = rset.getString("last_name");
			String address = rset.getString("address");
			String phone = rset.getString("phone");
			String test_date = rset.getString("first_date");
			String rowStr = String.format("%20s%20s%20s%20s%20s", 
				first_name, last_name, address, phone, test_date);
			out.println(rowStr);
		}

	

	}
	catch(Exception ex){
	    out.println("No patients found with specifed diagnosis at that time.");
	    out.println("<hr>"+ ex.getMessage() +"<hr>");
	    conn.close();
	}
	conn.close();

	
	out.println("<a href='./UserManageMenu.html'>Return to menu</a>"); //May change this later
	
	
} else { %>
<%@ include file="ReportModule.html"%>
<%}%>
</BODY>
</HTML>

