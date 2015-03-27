
/***
 *  Based this code on http://luscar.cs.ualberta.ca:8080/yuan/UploadImageLogicSQL.java
 * author: Li-Yuan
 ***/

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

/**
 *  The package commons-fileupload-1.0.jar are downloaded from 
 *     http://jakarta.apache.org/commons/fileupload/ 
 *  and it has to be put under WEB-INF/lib/ directory. 
 *  Remember to add the jar file to your CLASSPATH.
*/

public class UploadImageLogicSQL extends HttpServlet {
    public String response_message;

    public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

	try {
	    //Parse the HTTP request to get the image stream
	    DiskFileUpload fu = new DiskFileUpload();
	    List FileItems = fu.parseRequest(request);
	    
	    // Process the uploaded items
	    Iterator i = FileItems.iterator();
	    FileItem item = (FileItem) i.next();
	    while (i.hasNext() && item.isFormField()) {
		item = (FileItem) i.next();
		long size = item.getSize();

	    	//Get the image stream
	    	InputStream instream = item.getInputStream();
	    
            	// Connect to the database
            	Connection conn = mkconn();
		//getting newID for picture
		PreparedStatement stmt = null;
		ResultSet rset1 = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
		rset1.next();
		int pic_id = rset1.getInt(1);

	    	//Insert an empty blob into the table first. Note that you have to 
		stmt = conn.prepareStatement("insert into photos values(?, ?)");
		stmt.setInt(1,pic_id);
	    	stmt.setBinaryStream(2,instream,(int)size);

           	// execute the insert statement
            	stmt.executeUpdate();
            	stmt.executeUpdate("commit");
            	conn.close();
	    	response_message = "the file has been uploaded";
	    }


       }


	 catch( Exception ex ) {
	    response_message = ex.getMessage();
	}


	//Output response to the client
	response.setContentType("text/html");
	PrintWriter out = response.getWriter();
	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
		"Transitional//EN\">\n" +
		"<HTML>\n" +
		"<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
		"<BODY>\n" +
		"<H1>" +
	        response_message +
		"</H1>\n" +
		"</BODY></HTML>");
	}
  


  public Connection mkconn(){
    String USER = ""; //Change these parameters when testing to your oracle password :)
    String PASSWORD = "";
    Connection conn = null;
    String driverName = "oracle.jdbc.driver.OracleDriver";
    String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try {
      Class drvClass = Class.forName(driverName);
      DriverManager.registerDriver((Driver) drvClass.newInstance());
      conn = DriverManager.getConnection(dbstring, USER, PASSWORD); 
      conn.setAutoCommit(false);
      return conn;
    }
    catch(Exception ex){
      return null;
    }
  }


}
 
