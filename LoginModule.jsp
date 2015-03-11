<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlcontrol.*"%>

<%
Connection conn = null;
if(request.getParameter("Submit") != null) {	//extracting logininfo
    String username = (request.getParameter("USERID").trim());
    String password = (request.getParameter("PASSWD").trim());
    connmaker cn = null;
    sqlcontroller scontroller= null;
    Boolean logbool = null;

    try{
	cn = new connmaker();
        conn = cn.mkconn(); 	//creates a connection with database by using connectionmaker class
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() + "<hr>");
    }

    try{
      scontroller = new sqlcontroller();
      logbool = scontroller.logincheck(username, password, conn);	//this will try to retrieve user data info to see if login is okay
    }
    catch(Exception ex){
       out.println("<hr>" + ex.getMessage() + "<hr>");
    }

    if(logbool == true){		
      out.println("login successful");	//if user exists and password works this will be run.
    }
    else{
      out.println("wrong password");
    }
}

else{ %>
  <%@ include file="LoginModule.html"%>
<%}%>

</HTML>
</BODY>
