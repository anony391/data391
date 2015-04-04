<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>
<%
Connection conn = null;

if(request.getParameter("Submit") != null) {	//extracting updateuser info
	String password = (request.getParameter("PASSWD").trim());
	String password2 = (request.getParameter("PASSWDCNFRM").trim());
	sqlcontroller sqlContrl = new sqlcontroller();
	/*Check if both passwords match, otherwise return to UpdateUserInfo page*/
	if (!(password.equals(password2))) {
		response.sendRedirect("Home_Menu.jsp");
	} 



		    /*Get updated user info*/
	String username = (request.getParameter("USERID").trim());
	String firstName = (request.getParameter("FIRSTNAME").trim());
	String lastName = (request.getParameter("LASTNAME").trim());
	String address = (request.getParameter("ADDRESS").trim());
	String email = (request.getParameter("EMAIL").trim());
	String phone = (request.getParameter("PHONE").trim());
	String classString = (request.getParameter("CLASS").trim()).toLowerCase();
	String doctor = (request.getParameter("DOCTOR").trim());
	char classType = classString.charAt(0);
	connmaker cn = new connmaker();
	conn = cn.mkconn(); 	//creates a connection with database
    	String doctor_class = sqlContrl.classOfUserID(conn,doctor);

	if (!(doctor_class.equals("d"))){
		out.println("Doctor ID Entered is not associated with a doctor in the system.");

	}
	else{

	    Statement stmt = null;
	    ResultSet rset = null;

	    String check = request.getParameter("Update");

	    /*Executes update statements if from UpdateUser.jsp*/
	    if ((check != null) && check.equals("updateAccount")) {

		String person_id = (String) session.getAttribute("personID");
	
		String userUpdateSql = "UPDATE users SET user_name='"+username+"'," +
		                "password='"+password+"', class='"+classType+"'" +
		                " WHERE person_id='"+person_id+"'";
		String personUpdateSql = "UPDATE persons SET first_name='"+firstName+"'," +
		                "last_name='"+lastName+"',address='"+address+"'," +
		                "email='"+email+"',phone='"+phone+"'" + 
				"WHERE person_id='"+person_id+"'";
		String doctorUpdateSql = "UPDATE family_doctor SET doctor_id='"+doctor+"'" +
		                    " WHERE patient_id='"+person_id+"'";

		    stmt = conn.createStatement();
		    stmt.executeUpdate(doctorUpdateSql);
		    stmt.executeUpdate(userUpdateSql);
		    stmt.executeUpdate(personUpdateSql);

		conn.close();
		out.println("Update was successful.");
	

    /*Execute insert statements if from CreateAccount.html*/
		} 
		else if (request.getParameter("Create").equals("createAccount")) {

			//Create a new person_id
			String person_id = sqlContrl.generateNextID(conn);
			if (person_id.equals("error")) {
				out.println("Could not generate new id.");
			}

		/*Create and format registration date for user table*/
		Date currentDay = new Date();
		SimpleDateFormat ft =
		new SimpleDateFormat("yyyy-MM-dd");
		String regDate = ft.format(currentDay);

		String userInsertSql = "INSERT INTO users" +
		    "(user_name, password, class, person_id, date_registered)" +
		    "VALUES ('"+username+"','"+password+"','"+classType+"'," +
			"'"+person_id+"',to_date('"+regDate+"','yyyy-mm-dd'))";
		String personInsertSql = "INSERT INTO persons" +
		    "(person_id, first_name, last_name, address, email, phone)" +
		    "VALUES ('"+person_id+"','"+firstName+"','"+lastName+"'," + 
			"'"+address+"','"+email+"','"+phone+"')";
		String doctorInsertSql = "INSERT INTO family_doctor" +
		    "(doctor_id, patient_id) VALUES ('"+doctor+"', '"+person_id+"')";
	
		    stmt = conn.createStatement();
		    stmt.executeUpdate(personInsertSql);
		    stmt.executeUpdate(userInsertSql);
		    stmt.executeUpdate(doctorInsertSql);

		conn.close();
		out.println("Account was successfully created.");
    }
}

    out.println("<a href='./Home_Menu.jsp'>Return to menu</a>");
} else { %>
<%@ include file="UserManageMenu.html"%>
<%}%>
</BODY>
</HTML>

