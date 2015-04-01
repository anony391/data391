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
import oracle.sql.*;
import oracle.jdbc.*;
import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
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
				Statement stmt = null;
				stmt = conn.createStatement();
				ResultSet rset1 = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
				rset1.next();
				int pic_id = rset1.getInt(1);

				//Insert an blob into table with new ID
				PreparedStatement pstmt = null;
				pstmt = conn.prepareStatement("INSERT INTO pacs_images (?,?,?,?,?) values(?,?,?,?,?)");
				
				int index1 = 1;
				int index2 = 6;
				for (Map.Entry<String, String> entry : map.entrySet()) {
					System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
					index1 +=1;
					index2 +=1;
				}

				// execute the insert statement
				pstmt.executeUpdate();
				pstmt.executeUpdate("commit");
				conn.close();
				response_message = "The Images Have been Uploaded";
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
	
	try {
	    //Parse the HTTP request to get the image stream
	    DiskFileUpload fu = new DiskFileUpload();
	    List FileItems = fu.parseRequest(request);
	        
	    // Process the uploaded items, assuming only 1 image file uploaded
	    Iterator i = FileItems.iterator();
	    FileItem item = (FileItem) i.next();
	    while (i.hasNext() && item.isFormField()) {
		item = (FileItem) i.next();
	    }

	    //Get the image stream
	    InputStream instream = item.getInputStream();

	    BufferedImage img = ImageIO.read(instream);
	    BufferedImage thumbNail = shrink(img, 10);

            // Connect to the database and create a statement
            Connection conn = getConnected(drivername,dbstring, username,password);
	    Statement stmt = conn.createStatement();
	    
	    /*
	     *  First, to generate a unique pic_id using an SQL sequence
	     */
	    ResultSet rset1 = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
	    rset1.next();
	    pic_id = rset1.getInt(1);

	    //Insert an empty blob into the table first. Note that you have to 
	    //use the Oracle specific function empty_blob() to create an empty blob
	    stmt.execute("INSERT INTO pictures VALUES("+pic_id+",'test',empty_blob())");
 
	    // to retrieve the lob_locator 
	    // Note that you must use "FOR UPDATE" in the select statement
	    String cmd = "SELECT * FROM pictures WHERE pic_id = "+pic_id+" FOR UPDATE";
	    ResultSet rset = stmt.executeQuery(cmd);
	    rset.next();
	    BLOB myblob = ((OracleResultSet)rset).getBLOB(3);


	    //Write the image to the blob object
	    OutputStream outstream = myblob.getBinaryOutputStream();
	    ImageIO.write(thumbNail, "jpg", outstream);
	    
	    /*
	    int size = myblob.getBufferSize();
	    byte[] buffer = new byte[size];
	    int length = -1;
	    while ((length = instream.read(buffer)) != -1)
		outstream.write(buffer, 0, length);
	    */
	    instream.close();
	    outstream.close();

            stmt.executeUpdate("commit");
	    response_message = " Upload OK!  ";
            conn.close();


    //shrink image by a factor of n, and return the shrinked image
    public static BufferedImage shrink(BufferedImage image, int n) {

        int w = image.getWidth() / n;
        int h = image.getHeight() / n;

        BufferedImage shrunkImage =
            new BufferedImage(w, h, image.getType());

        for (int y=0; y < h; ++y)
            for (int x=0; x < w; ++x)
                shrunkImage.setRGB(x, y, image.getRGB(x*n, y*n));

        return shrunkImage;
    }


}
 
