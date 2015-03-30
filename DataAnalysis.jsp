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

    String patient = (request.getParameter("PATIENT").trim());
    String test_type = (request.getParameter("TESTTYPE").trim());
    String time_period = (request.getParameter("TIMEPERIOD").trim());

    //Create sql statement based on user's choice
    String sqlString = "SELECT ";
    String dataCube = "GROUP BY CUBE (";
    String description = "Displaying number of images for each ";

    if (patient.equals("True")) {
        String nameParam = "first_name, last_name, ";
        sqlString += patient_name;
        dataCube += patient_name;
        description += "patient, "
    }
    if (test_type.equals("True") {
        String testTypeParam = "test_type, ";
        sqlString += testTypeParam;
        dataCube += testTypeParam;
        description += "test type, "
    }
    if (time_period.equals("Yearly") {
        String yearParam = "TRUNC(test_date, 'YEAR'), ";
        sqlString += yearParam;
        dataCube += yearParam;
        description += "year, "
    }
    if (time_period.equals("Monthly") {
             String monthParam = "TRUNC(test_date, 'MONTH'), ";
             sqlString += monthParam;
             dataCube += monthParam;
             description += "month, "
     }
    if (time_period.equals("Weekly") {
             String weekParam = "TRUNC(test_date, 'WW'), ";
             sqlString += weekParam;
             dataCube += weekParam;
             description += "week, "
     }

    sqlString = sqlString.replaceAll(",$", "");
    dataCube = dataCube.replaceAll(",$", "");
    description = description.replaceAll(",$", ":");
    sqlString += " COUNT(image_id) FROM analysis_view ";
    sqlString += dataCube;

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


    if (rset != null && rset.next()) {
        out.println(description);
        out.println("%s",rset.getString("COUNT(image_id)"));
    } else {
        out.println("Error: Could not generate analysis");
    }

    conn.close();
}

else{ %>
  <%@ include file="DataAnalysis.html"%>
<%}%>

</BODY>
</HTML>


