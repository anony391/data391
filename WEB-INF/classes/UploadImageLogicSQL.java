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
	private Integer record_id;
	private Integer image_id;

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

				//converting to smaller and smaller thumbnails
				BufferedImage full_size = ImageIO.read(instream);
	   			BufferedImage reg_size = shrink(full_size, 5);
				BufferedImage thumbnail = shrink(reg_size, 5);
	    
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
				pstmt = conn.prepareStatement("INSERT INTO pacs_images (record_id,image_id,thumbnail,regular_size,full_size)"
												+ "values(?,?,empty_blob(), empty_blob(),empty_blob())");
												
				pstmt.setInt(1,record_id);
				pstmt.setInt(2, image_id);
				
				// Retrieving the BLOB_locator 
				pstmt = conn.prepareStatement("SELECT thumbnail,regular_size,full_size FROM pacs_images WHERE record_id = '?' AND image_id = '?' FOR UPDATE");
				Resultset rset = pstmt.executeStatement();
				BLOB thumbnail_blob = ((OracleResultSet)rset).getBLOB(3);
				BLOB regular_blob = ((OracleResultSet)rset).getBLOB(3);
				BLOB full_blob = ((OracleResultSet)rset).getBLOB(3);

				//Write the image to the blob object
				OutputStream thumbnail_out = thumbnail_blob.getBinaryOutputStream();
				ImageIO.write(thumbnail, "jpg", thumbnail_out);
				OutputStream regular_out = regular_blob.getBinaryOutputStream();
				ImageIO.write(reg_size, "jpg", regular_out);
				OutputStream full_out = full_bob.getBinaryOutputStream();
				ImageIO.write(full_size, "jpg", full_out);
				
				thumbnail_out.close();
				regular_out.close();
				full_out.close();
				instream.close();

				response_message = "The Images Have been Uploaded";
			}
			conn.close();
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
	
	//Shrinks image by a factor of n   					
	// *** This was taken from http://webdocs.cs.ualberta.ca/~yuan/servlets/UploadImage.java
	// **** Author:  Fan Deng
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
 
