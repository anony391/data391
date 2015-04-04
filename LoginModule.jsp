<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlcontrol.*"%>

<%
Connection conn = null;
	try{
		if(request.getParameter("Submit") != null) {	//extracting logininfo
			String username = (request.getParameter("USERID").trim());
			String password = (request.getParameter("PASSWD").trim());
			connmaker cn = null;
			sqlcontroller scontroller= null;
			Boolean logbool = false;
			cn = new connmaker();
			conn = cn.mkconn(); 	//creates a connection with database by using connectionmaker class
	     		scontroller = new sqlcontroller();
	      		logbool = scontroller.logincheck(username, password, conn);	//this will try to retrieve user data info to see if login is okay

			if(logbool == true) {	
				session.setAttribute( "userID", username );%> 
				<%@ include file="Home_Menu.jsp"%>
				<%      
		      		conn.close();
		    	}
	   		else {
	      			out.println("Wrong Password");
	    		}
		}
		else{ %>
  			<%@ include file="LoginModule.html"%>
		<%}
	}
	catch(Exception ex){
		out.println("<hr>"+ ex.getMessage() + " Cannot Access Database.<hr>");
	}
%>
</HTML>
</BODY>
