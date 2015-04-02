import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.oreilly.servlet.MultipartRequest;
//** Jar taken from http://www.servlets.com/cos/ **//
public class CreateNewRadiologyTest extends HttpServlet {
private int radiology_id;
  public void doPost(HttpServletRequest req, HttpServletResponse res)
                                throws ServletException, IOException {
    res.setContentType("text/html");
    PrintWriter out = res.getWriter();
Map<Integer,Integer> radiology_IDs = new HashMap<Integer,Integer>();
Map<Integer,String> radiology_strings = new HashMap<Integer,String>();
    try {
     
      MultipartRequest multi =
        new MultipartRequest(req, "/cshome/rdejesus/catalina/temp", 5 * 1024 * 1024);

      // Grab all parameters
	Integer i = 1;

      Enumeration params = multi.getParameterNames();
      while (i<=3) {
        String name = (String)params.nextElement();
        String value = multi.getParameter(name);
	radiology_IDs.put(i, Integer.parseInt(value));
	i++;
      }
	      while (i<=9) {
        String name = (String)params.nextElement();
        String value = (String)multi.getParameter(name);
	radiology_strings.put(i, value);
	i++;
      }
	Connection conn = mkconn();
	PreparedStatement pstmt = null;
	String sql = ("INSERT INTO radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description)"
		+ " values (?,?,?,?,?,to_date(?, 'mm-dd-yyyy'),to_date(?, 'mm-dd-yyyy'),?,?)");
	pstmt = conn.prepareStatement(sql);
	//grabNewID
	//radiology_id = 2;
	//setID
        if(radiology_IDs != null){
            for(Integer key : radiology_IDs.keySet()){
                pstmt.setInt(key, radiology_IDs.get(key));
            }
        }     
	        if(radiology_strings != null){
            for(Integer key : radiology_strings.keySet()){
                pstmt.setString(key, radiology_strings.get(key));
            }
        }           
	pstmt.execute();
	conn.close();
	

      // Show which files we received
  
      Enumeration files = multi.getFileNames();
      while (files.hasMoreElements()) {
        String name = (String)files.nextElement();
        String filename = multi.getFilesystemName(name);
        String type = multi.getContentType(name);
        File f = multi.getFile(name);
        out.println("name: " + name);
        out.println("filename: " + filename);
        out.println("type: " + type);
        if (f != null) {
          out.println("length: " + f.length());
          out.println();
        }
        out.println("</PRE>");
      }
    }
    catch (Exception e) {
      out.println("<PRE>");
      e.printStackTrace(out);
      out.println("</PRE>");
    }
    out.println("</BODY></HTML>");
  }


	//This creates a connection to database for insertion of picture
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
