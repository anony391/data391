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
	

	}
	catch(Exception ex){
	out.println("<hr>"+ ex.getMessage() + "<hr>");
	}
	Statement stmt = null;
	ResultSet rset = null;

	/*Get updated user info*/
	String diagnosis = (request.getParameter("DIAGNOSIS").trim());
	String fromDate = (request.getParameter("FROM").trim());
	String toDate = (request.getParameter("TO").trim());

	//Create sql string
    	String sqlString = "SELECT *"
			+ " FROM (SELECT p.first_name,p.last_name,p.address,p.phone,r.test_date,ROW_NUMBER()"
			+ " OVER (PARTITION BY p.person_id ORDER BY r.test_date) AS rownumber" 
			+ " FROM persons p,radiology_record r WHERE p.person_id=r.patient_id"
			+ " AND r.diagnosis='"+diagnosis+"'" 
			+ " AND r.test_date BETWEEN TO_DATE('"+fromDate+"','yyyy-mm-dd')"
			+ " AND TO_DATE('"+toDate+"','yyyy-mm-dd'))"
			+ " WHERE rownumber=1";

	try {
		stmt = conn.createStatement();
		rset = stmt.executeQuery(sqlString);

		//Print title row of table
		out.println("<table style='width:50%'>");
		out.println("<tr><th>First Name</th><th>Last Name</th><th>Address</th>");
		out.println("<th>Phone</th><th>Test Date</th></tr>");

		//Print the values for each column
		while(rset != null && rset.next()){

			String first_name = rset.getString("first_name");
			String last_name = rset.getString("last_name");
			String address = rset.getString("address");
			String phone = rset.getString("phone");
			String test_date = rset.getString("test_date");

			out.println("<tr><td>"+first_name+"</td><td>"+last_name+"</td><td>"+address+"</td>");
			out.println("<td>"+phone+"</td><td>"+test_date+"</td>");

		}
		out.println("</table>");
	

	}
	catch(Exception ex){
	    out.println("No patients found with specifed diagnosis at that time.");
	    out.println("<hr>"+ ex.getMessage() +"<hr>");
	    conn.close();
	}
	conn.close();

	
	out.println("<a href='./Home_Menu.jsp'>Return to menu</a>");
	
	
} else { %>
<% 	
	//Class authorization
	String login_class = (String) session.getAttribute("login_class");
	if (login_class == null){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");

	}

	else if (!(login_class.equals("a"))){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");
	}

	else{out.println("<table align=left valign=top><li><a href=\"Home_Menu.jsp\">HOME</li></a></table>");

%>
<%@ include file="ReportModule.html"%>
<%}}%>
</BODY>
</HTML>

