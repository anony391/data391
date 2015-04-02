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
	private Integer record_id;	//must grab this 
	private Integer image_id;

    public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		try {
			//Parse the HTTP request to get the image stream
			DiskFileUpload fu = new DiskFileUpload();
			//record_id = request.getParameters("record_id")
			record_id = 1;
			List FileItems = fu.parseRequest(request);
	    
			// Process the uploaded items
			Iterator i = FileItems.iterator();
			FileItem item = (FileItem) i.next();
			//while (i.hasNext() && item.isFormField()) {
				long size = item.getSize();

				//Get the image stream
				InputStream instream = item.getInputStream();

				//converting to smaller and smaller thumbnails
				BufferedImage full_size = ImageIO.read(instream);
	   			BufferedImage reg_size = shrink(full_size, 5);
				BufferedImage thumbnail = shrink(reg_size, 5);

				//Write the image to the outputstream as a picture
				ByteArrayOutputStream thumbnail_out = new ByteArrayOutputStream();
				ImageIO.write(thumbnail, "png", thumbnail_out);
				ByteArrayOutputStream regular_out = new ByteArrayOutputStream();
				ImageIO.write(reg_size, "png", regular_out);
				// convert back to inputstream to be input
				InputStream thumbnail_stream = new ByteArrayInputStream(thumbnail_out.toByteArray());
				InputStream regular_stream = new ByteArrayInputStream(regular_out.toByteArray());

				// Connect to the database
				Connection conn = mkconn();
				
				//getting newID for picture for image_id
				//Statement stmt = null;
				//stmt = conn.createStatement();
				//ResultSet rset1 = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
				//rset1.next();
				//int image_id = rset1.getInt(1);
				int image_id = 1;

				//Insert an blob into table with new ID
				PreparedStatement pstmt = null;
				pstmt = conn.prepareStatement("INSERT INTO pacs_images (record_id,image_id,thumbnail,regular_size,full_size)"
												+ "values (?,?,?,?,?)");				
				pstmt.setInt(1,record_id);
				pstmt.setInt(2, image_id);
				pstmt.setBlob(3, thumbnail_stream);
				pstmt.setBlob(4, regular_stream);
				pstmt.setBlob(5, instream);
				pstmt.execute();
				
				thumbnail_out.close();
				regular_out.close();
				instream.close();
				conn.close();
				response_message = "The Images Have been Uploaded";
			//}
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
 
