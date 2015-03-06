<%@ page import="connection.java";
import="java.sql.*"%>
<%
Connection conn = null;
if(request.getParameter("Submit") != null) {	//extracting logininfo
    String username = (request.getParameter("USERID").trim();
    String password = (request.getParameter("PASSWD").trim();
    try{
        conn = mkconn(); //creates a connection with database
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

    String dbpassword = "";  	//checking if results includes logininfo
    while(rset != null && rset.next()){
        dbpassword = rset.getString(1).trim();
        if(password.equals(dbpassword)){
            out.println("login successful"); 	//need to change this to going to nextpage
            break;
        }
        else{
            out.println("user/password wrong");
            break;
        }
    }
}
else{ %>
<%@ include file="LoginModule.html"%>
<%}%>
