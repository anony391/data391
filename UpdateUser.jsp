<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%
Connection conn = null;
if(request.getParameter("Submit") != null) {	//extracting logininfo
    String person_id = (request.getParameter("PERSONID").trim());
    try{
	connmaker cn = new connmaker();
        conn = cn.mkconn(); 	//creates a connection with database
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() + "<hr>");
    }

    Statement stmt = null;
    ResultSet rset = null;
    String sqlstring = "SELECT * FROM users u,persons p,family_doctor d WHERE p.person_id = u.person_id AND p.person_id = d.patient_id";
    try{

        stmt = conn.createStatement();
        rset = stmt.executeQuery(sqlstring);
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() +"<hr>");
	out.println(sqlstring);
	conn.close();
    }

    if (rset != null){
	/*Get user info*/
        String username = rset.getString("user_name").trim();
	String password = rset.getString("password").trim();
	String firstName = rset.getString("first_name").trim();
	String lastname = rset.getString("last_name").trim();
	String address = rset.getString("address").trim();
	String email = rset.getString("email").trim();
	String phone = rset.getString("phone").trim();
	char class = rset.getString("class").trim();
	String doctor = rset.getString("doctor_id").trim();

    }
}
else{ %>
<%@ include file="UpdateUserInfo.html"%>
<%}%>

</BODY>
</HTML>

