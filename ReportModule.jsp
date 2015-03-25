<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>
<%
Connection conn = null;
	
if(request.getParameter("Submit") != null) {	//extracting updateuser info
	String person_id = session.getAttribute("personID");
	if (!classOfUser(person_id).equals('a')){
		out.println("Only administrators can generate reports.");
%> <%@ include file="UserManageMenu.html"%>
<% 	}

	sqlcontroller sqlContrl = new sqlcontroller();


	/*Get updated user info*/
	String diagnosis = (request.getParameter("DIAGNOSIS").trim());
	String year = (request.getParameter("YEAR").trim());

	try{
	connmaker cn = new connmaker();
	conn = cn.mkconn(); 	//creates a connection with database

	}
	catch(Exception ex){
	out.println("<hr>"+ ex.getMessage() + "<hr>");
	}
	Statement stmt = null;
	ResultSet rset = null;

	
    	String sqlString = "SELECT p.first_name,p.last_name,p.address,p.phone,r.test_date " 
			+ "FROM persons p,radiology_record r WHERE p.person_id=r.patient_id,"
			+ "r.diagnosis='"+diagnosis+"',r.test_date='"+year"';

	try{
		stmt = conn.createStatement();
		rset = stmt.executeQuery(sqlString);

		out.println("First Name\tLastName\tAddress\tPhone Number\tTest Date");
		while(rset != null && rset.next()){

			first_name = rset.getString("first_name");
			last_name = rset.getString("last_name");
			address = rset.getString("address");
			phone = rset.getString("phone");
			test_date = rset.getString("test_date");
			out.format("%20s%20s%20s%20s%20s", first_name, last_name,
			address, phone, test_date);
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

