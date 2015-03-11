<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date*"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>
<%
Connection conn = null;
if(request.getParameter("Submit") != null) {	//extracting updateuser info

    String password = (request.getParameter("PASSWD").trim());
    String password2 = (request.getParameter("PASSWDCNFRM").trim());
    sqlcontroller sqlContrl = new sqlcontroller();

    /*Check if both passwords match, otherwise return to UpdateUserInfo page*/
    if (password != password2) {
        out.println("Passwords do not match. Please try again.");
%> <%@ include file="UserManageMenu.html"%>
<% }
    /*Get updated user info*/
    String username = (request.getParameter("USERID").trim());
    String firstName = (request.getParameter("FIRSTNAME").trim());
    String lastName = (request.getParameter("LASTNAME").trim());
    String address = (request.getParameter("ADDRESS").trim());
    String email = (request.getParameter("EMAIL").trim());
    String phone = (request.getParameter("PHONE").trim());
    String classType = (request.getParameter("CLASS").trim());
    String doctor = (request.getParameter("DOCTOR").trim());


    try{
	connmaker cn = new connmaker();
        conn = cn.mkconn(); 	//creates a connection with database
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() + "<hr>");
    }
    Statement stmt = null;
    ResultSet rset = null;
    /*Executes update statements if from UpdateUser.jsp*/
    if (request.getParameter("Update") == "updateAccount") {
	String person_id = (String) session.getAttribute("personID");
	
        String userUpdateSql = "UPDATE users SET user_name='"+username+"'," +
                        "password='"+password+"', class='"+classType+"'" +
                        "WHERE person_id = '"+person_id+"')";
        String personUpdateSql = "UPDATE persons SET first_name='"+firstName+"'," +
                        "last_name='"+lastName+"',address='"+address+"'," +
                        "email='"+email+"',phone='"+phone+"' WHERE person_id = '"+person_id+"')";
        String doctorUpdateSql = "UPDATE family_doctor SET doctor_id='"+doctor+"'" +
                            "WHERE patient_id='"+person_id+"')";

        try{
            stmt = conn.createStatement();
            stmt.executeUpdate(userUpdateSql);
            stmt.executeUpdate(personUpdateSql);
            stmt.executeUpdate(doctorUpdateSql);
        }
        catch(Exception ex){
            out.println("<hr>"+ ex.getMessage() +"<hr>");
            conn.close();
        }
        conn.close();
        out.println("Update was successful.");
    /*Execute insert statements if from CreateAccount.html*/
    } else if (request.getParameter("Create") == "createAccount") {
        //Create a new person_id
	String person_id = sqlContrl.generateNextID(conn);

        /*Create and format registration date for user table*/
        Date currentDay = new Date();
        SimpleDateFormat ft =
        new SimpleDateFormat("yyyy-mm-dd");
        String regDate = ft.format(currentDay);

        String userInsertSql = "INSERT INTO users" +
            "(user_name, password, class, person_id, date_registered)" +
            "VALUES ('"+username+"','"+password+"','"+classType+"','"+person_id+"','"+regDate+"')";
        String personInsertSql = "INSERT INTO persons" +
            "(person_id, first_name, last_name, address, email, phone)" +
            "VALUES ('"+person_id+"','"+firstName+"','"+lastName+"'," + 
		"'"+address+"','"+email+"','"+phone+"')";
        String doctorInsertSql = "INSERT INTO family_doctor" +
            "(doctor_id, patient_id) VALUES ('"+doctor+"', '"+person_id+"')";

        try{
            stmt = conn.createStatement();
            stmt.executeUpdate(userInsertSql);
            stmt.executeUpdate(personInsertSql);
            stmt.executeUpdate(doctorInsertSql);
        }
        catch(Exception ex){
            out.println("<hr>"+ ex.getMessage() +"<hr>");
            conn.close();
        }
        conn.close();
        out.println("Account was successfully created.");
    }

    //out.println('<a href="./UserManageMenu.html">Return to menu</a>'); //May change this later
} else { %>
<%@ include file="UserManageMenu.html"%>
<%}%>
</BODY>
</HTML>

