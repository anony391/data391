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
				// Connect to the database
				Connection conn = mkconn();
				
				//getting newID for radiology record
				Statement stmt = null;
				stmt = conn.createStatement();
				ResultSet rset1 = stmt.executeQuery("SELECT radiology_id_sequence.nextval from dual");
				rset1.next();
				int new_id = rset1.getInt(1);
				//Insert new information
				PreparedStatement pstmt = null;
				pstmt = conn.prepareStatement("insert into radiology_record (?) values(?, ?)");

				// execute the insert statement
				pstmt.executeUpdate();
				pstmt.executeUpdate("commit");
				conn.close();
				response_message = "The radiology record has been created";
			}


		}


		catch( Exception ex ) {
			response_message = ex.getMessage();
		}


		//Output response to the client if image uploaded properly
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
  

	//this creates a connection to database for insertion of picture
	public Connection mkconn(){
		String USER = ""; //Change these parameters when testing to your oracle password :)
		String PASSWORD = "";
		Connection conn = null;
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		try{
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
 
