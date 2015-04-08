<HTML>
<BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlcontrol.*"%>
<%@ page import="java.io.*"%>
<%
Connection conn = null;
if(request.getParameter("Submit") != null) {	//extracting logininfo
    connmaker cn = null;
    sqlcontroller scontroller= null;

    String patient = (request.getParameter("PATIENT"));
    String test_type = (request.getParameter("TESTTYPE"));
    String time_period = (request.getParameter("TIMEPERIOD"));

    //Create sql statement based on user's choice
    String sqlString = "SELECT";
    String dataCube = "GROUP BY CUBE (";
    String description = "Displaying number of images for each ";

    //This will add the attributes according to what the user has selected
    if ((patient != null) && (patient.equals("True"))) {
        String nameParam = " first_name, last_name,";
        sqlString += nameParam;
        dataCube += nameParam;
        description += " patient,";
    }
    if ((test_type != null) && (test_type.equals("True"))) {
        String testTypeParam = " test_type,";
        sqlString += testTypeParam;
        dataCube += testTypeParam;
        description += " test type,";
    }
    if (!(time_period.equals("None")) && (time_period.equals("Yearly"))) {
        String yearParam = " TRUNC(test_date, 'YEAR') AS time,";
        sqlString += yearParam;
        dataCube += " TRUNC(test_date, 'YEAR'),";
        description += " year,";
    }
    if (!(time_period.equals("None")) && (time_period.equals("Monthly"))) {
             String monthParam = " TRUNC(test_date, 'MONTH') AS time,";
             sqlString += monthParam;
             dataCube +=  " TRUNC(test_date, 'MONTH'),";
             description += " month,";
     }
    if (!(time_period.equals("None")) && (time_period.equals("Weekly"))) {
             String weekParam = " TRUNC(test_date, 'WW') AS time,";
             sqlString += weekParam;
             dataCube += " TRUNC(test_date, 'WW'),";
             description += " week,";
     }

    dataCube = dataCube.replaceAll(",$", ""); //Delete the last comma
    dataCube += ")";
    description = description.replaceAll(",$", ":");
    sqlString += " COUNT(image_id) FROM analysis_view ";
    sqlString += dataCube; //Add data cube to create final sql statement

    try{
	cn = new connmaker();
        conn = cn.mkconn(); 	//creates a connection with database by using connectionmaker class
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() + "<hr>");
    }

    Statement stmt = null;
    ResultSet rset = null;

    try{
        stmt = conn.createStatement();
        rset = stmt.executeQuery(sqlString);

    }
    catch(Exception ex){
       out.println("<hr>" + ex.getMessage() + "<hr>");
       conn.close();
    }

    out.println(description);
    //Print out each result set
    while (rset != null && rset.next()) { 
	String first = "";
	String last = "";
	String testType = ""; 
	String time = "";
	
	//Does not print out anything that has a null value
	if (patient != null) {
		first = rset.getString("first_name");
		last = rset.getString("last_name");
	
		if ((first == null) || (last == null)) {
			continue;
		}
	}
	if (test_type != null) {
		testType = rset.getString("test_type");
		if (testType == null) {
			continue;
		}
	}
	if (!time_period.equals("None")) {
		time = rset.getString("time");
		
		if (time == null) {
			continue;
		}
		
	}
	String count = rset.getString("COUNT(image_id)");

	//Print table to display result
	out.println("<br>");
	out.println("<table border='1'>");
	out.println("<col width='100px'><col width='100px'><col width='100px'><col width='100px'>");
	out.println("<tr><td>Patient: </td><td>Test type: </td><td>Time period: </td><td>Count: </td></tr>");
	out.println("<td>"+first+""+last+"</td><td>"+testType+"</td><td>"+time+"</td><td>"+count+"</td></tr>");
        out.println("</table>");
    } 

    conn.close();
	out.println("<br><a href='./Home_Menu.jsp'>Return to menu</a>");
}

else{ %>
<% 	
	//Check authorization
	String login_class = (String) session.getAttribute("login_class");
	if (login_class == null){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");

	}

	else if (!(login_class.equals("a"))){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");
	}

	else{out.println("<table align=left valign=top><li><a href=\"Home_Menu.jsp\">HOME</li></a></table>");

%>
  <%@ include file="DataAnalysis.html"%>
<%}}%>

</BODY>
</HTML>


