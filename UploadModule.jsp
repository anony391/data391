<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>


<% if(request.getParameter("Submit") != null){%>
	<%@ include file="ImageUpload.html"%>
<%}

else{%> 
	<%@ include file="new_radiology_record.html"%>
<%}%>
</body>
</html>
