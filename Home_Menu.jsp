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
	String id_number;
	String classType;

	connmaker cnmake = new connmaker();
	connec = cnmake.mkconn(); //creates a connection with database
	String user_name = (String) session.getAttribute("userID");
	
	if (user_name != null){
		classType = sqlContrl.classOfUser(connec,user_name);
		id_number = sqlContrl.IdOfUser(connec,user_name);
		//Redirect user to the home pages of their corresponding class
		if (classType != null) {
			session.setAttribute("id_number",id_number);

			if (classType.equals("a")){
				session.setAttribute( "login_class", "a" );		
	%> 			<%@ include file="Home_SystemAdminstrator.html"%>
	<% 		} else if (classType.equals("r")){
				session.setAttribute( "login_class", "r" );
	%> 			<%@ include file="Home_Radiology.html"%>
	<% 		} else if (classType.equals("d")){
				session.setAttribute( "login_class", "d" );
	%> 			<%@ include file="Home_Doctor.html"%>
	<% 		} else if (classType.equals("p")){
				session.setAttribute( "login_class", "p" );
	%> 			<%@ include file="Home_User.html"%>
	<%		}

		}
	} 

	else { %>
		<%@ include file="LoginModule.html"%>
<%	}

}
catch(Exception ex){
out.println("<hr>"+ ex.getMessage() + "<hr>");
}

%>
</BODY>
</HTML>

