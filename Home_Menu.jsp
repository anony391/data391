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
		String classType = sqlContrl.classOfUser(conn,person_id);	

	}
	catch(Exception ex){
	out.println("<hr>"+ ex.getMessage() + "<hr>");
	}


	if (classType.equals("a")){		
%> <%@ include file="Home_SystemAdminstrator.html"%>
<% 	} else if (classType.equals("r")){
%> <%@ include file="Home_Radiology.html"%>
<% 	} else if (classType.equals("d")){
%> <%@ include file="Home_Doctor.html"%>
<% 	} else if (classType.equals("u")){
%> <%@ include file="Home_User.html"%>
<%
	conn.close();	
	
} else { %>
<%@ include file="LoginModule.html"%>
<%}%>
</BODY>
</HTML>

