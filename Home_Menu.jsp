<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>
<%
Connection connec = null;
sqlcontroller sqlContrl = new sqlcontroller();
try {	//extracting updateuser info

	String classType;
	connmaker cnmake = new connmaker();
	connec = cnmake.mkconn(); //creates a connection with database
	String user_name = (String) session.getAttribute("userID");
	
	classType = sqlContrl.classOfUser(connec,user_name);

	if (classType != null) {

		if (classType.equals("a")){		
%> <%@ include file="Home_SystemAdminstrator.html"%>
<% 		} else if (classType.equals("r")){
%> <%@ include file="Home_Radiology.html"%>
<% 		} else if (classType.equals("d")){
%> <%@ include file="Home_Doctor.html"%>
<% 		} else if (classType.equals("p")){
%> <%@ include file="Home_User.html"%>
<%		}

	} else { %>
<%@ include file="LoginModule.html"%>
<%	}

}
catch(Exception ex){
out.println("<hr>"+ ex.getMessage() + "<hr>");
}

	connec.close();	
%>
</BODY>
</HTML>

