<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%
Connection conn = null;
if(request.getParameter("Submit") != null) {	//extracting person id
    String person_id = (request.getParameter("PERSONID").trim());
    session.setAttribute( "personID", person_id );
    try{
	connmaker cn = new connmaker();
        conn = cn.mkconn(); 	//creates a connection with database
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() + "<hr>");
    }

    Statement stmt = null;
    ResultSet rset = null;
    String sqlstring = "SELECT * FROM users u,persons p,family_doctor d WHERE p.person_id = u.person_id AND p.person_id = d.patient_id AND p.person_id='"+person_id+"'";
    try{

        stmt = conn.createStatement();
        rset = stmt.executeQuery(sqlstring);
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() +"<hr>");
	out.println(sqlstring);
	conn.close();
    }

    if (rset != null && rset.next()){
	/*Get user info*/
        String username = rset.getString("user_name").trim();
        String firstName = rset.getString("first_name").trim();
        String lastName = rset.getString("last_name").trim();
        String address = rset.getString("address").trim();
        String email = rset.getString("email").trim();
        String phone = rset.getString("phone").trim();
        String classType = rset.getString("class").trim();
        String doctor = rset.getString("doctor_id").trim();

        /*Print out update form with filled in fields*/
        out.println("<form method=post action=UserManagement.jsp>");
        out.println("UserName: <input type=text name=USERID value='"+username+"'><br>");
        out.println("Password: <input type=password name=PASSWD><br>");
        out.println("Confirm Password: <input type=password name=PASSWDCNFRM><br>");
        out.println("First Name: <input type=text name=FIRSTNAME value='"+firstName+"'><br>");
        out.println("Last Name: <input type=text name=LASTNAME value='"+lastName+"'><br>");
        out.println("Address: <input type=text name=ADDRESS value='"+address+"'><br>");
        out.println("Email: <input type=text name=EMAIL value='"+email+"'><br>");
        out.println("Phone: <input type=text name=PHONE value='"+phone+"'><br>");
        out.println("Class(a,p,r,d): <input type=text name=CLASS value='"+classType+"'><br>");
        out.println("Family Doctor ID: <input type=text name=DOCTOR value='"+doctor+"'><br>");
        out.println("<input type=hidden name=Create value=createAccount>");
        out.println("<input type=submit name=Submit value=Submit>");
        out.println("</form>");

    }
} else { %>
<%@ include file="UpdateUserInfo.html"%>
<%}%>
</BODY>
</HTML>

