<%@ page import="connection.java";
import="java.sql.*"%>
<%@ include file="LoginModule.html"%>
<%
Connection conn = null;

if(request.getParameter("Submit") != null) {
    String username = (request.getParameter("USERID").trim();
    String password = (request.getParameter("PASSWD").trim();
}
try{
    conn = mkconn();
}
catch(Exception ex){
    out.println("<hr>"+ ex.getMessage() + "<hr>");
}

Statement stmt = null;
ResultSet rset = null;
String sqlstring = "'select password from users where user_name = "+username+"'";
try{

    stmt = conn.createStatement();
    reset = stmt.executeQuery(sqlstring);
}
catch(Exception ex){
    out.println("<hr>"+ ex.getMessage() +"<hr>");
}

String dbpassword = "";
while(rset != null && rset.next())
    dbpassword = rset.getString(1).trim();
if(password.equals(dbpassword))
    out.println("login successful"); //need to change this to going to nextpage
else
    out.println("user/password wrong");

%>
