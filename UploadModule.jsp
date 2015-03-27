<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>


<% if(request.getParameter("Submit") != null) {
	//Connection conn = null;
	//connmaker cn = null;
	UploadImage imageUploader = null;
	try{
		//cn = new connmaker();
    		//conn = cn.mkconn(); 	//creates a connection with database by using connectionmaker class
  	}
   	catch(Exception ex){
        	//out.println("<hr>"+ ex.getMessage() + "<hr>");
	}
	try{
      		imageUploader = new UploadImage();
		imageUploader.doPost(request,response);
		
    	}
	catch(Exception ex){
        	out.println("<hr>"+ ex.getMessage() + "<hr>");
		//conn.close();
	}
}

else{%> 
	<%@ include file="new_radiology_record.html"%>
<%}%>
</body>
</html>
