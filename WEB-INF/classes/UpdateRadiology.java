import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.oreilly.servlet.MultipartRequest;
import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import oracle.sql.*;
import oracle.jdbc.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
/**

Code was based on http://webdocs.cs.ualberta.ca/~yuan/servlets/UploadImage.java
 *  Author:  Fan Deng
and http://luscar.cs.ualberta.ca:8080/yuan/UploadImageLogicSQL.java
@author  Li-Yan Yuan



*/
//** Jar taken from http://www.servlets.com/cos/ **//
public class UpdateRadiology extends HttpServlet {
	SimpleDateFormat format = new SimpleDateFormat("MM-dd-yyyy");
	private int radiology_id;
	String response_message;
	public void doPost(HttpServletRequest req, HttpServletResponse response)
                                throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null) {
	    		response.sendRedirect("Home_Menu.jsp");
		}
		try {
				// Create new Multirequest to write in temp file
			MultipartRequest request = new MultipartRequest(req, "/cshome/rdejesus/catalina/temp", 5 * 1024 * 1024);
				// Grab all parameters from form
			String grab_value = request.getParameter("RECORDID");
			radiology_id = Integer.parseInt(grab_value);
			//create new connection
			Connection conn = mkconn();
			PreparedStatement pstmt = null;
			ResultSet rset1;
			int image_id;
			String sql;

			// Grab Image Files
			Enumeration files = request.getFileNames();
			while (files.hasMoreElements()) {
				String name = (String)files.nextElement();
				String type = request.getContentType(name);
				if(type.equals("null")){
					continue;
				}
				File file =  request.getFile(name); 	
				//Get the image stream
				InputStream fulls_stream = new java.io.FileInputStream(file);

				//converting to smaller and smaller thumbnails
				BufferedImage bf = ImageIO.read(fulls_stream);
				BufferedImage full = shrink(bf,1);
	   			BufferedImage reg_size = shrink(bf, 5);
				BufferedImage thumbnail = shrink(reg_size, 5);
				//Write the image to the outputstream as a picture
				ByteArrayOutputStream full_outstream = new ByteArrayOutputStream();
				ImageIO.write(full, "jpg", full_outstream);
				ByteArrayOutputStream thumbnail_outstream = new ByteArrayOutputStream();
				ImageIO.write(thumbnail, "jpg", thumbnail_outstream);
				ByteArrayOutputStream regular_outstream = new ByteArrayOutputStream();
				ImageIO.write(reg_size, "jpg", regular_outstream);
				// convert back to inputstream to be input
				InputStream full_stream = new ByteArrayInputStream(full_outstream.toByteArray());
				InputStream thumbnail_stream = new ByteArrayInputStream(thumbnail_outstream.toByteArray());
				InputStream regular_stream = new ByteArrayInputStream(regular_outstream.toByteArray());
				//grab new image ID
				pstmt = conn.prepareStatement("LOCK TABLE pacs_images IN EXCLUSIVE MODE");
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement("SELECT COUNT(*) FROM pacs_images");
				rset1 = pstmt.executeQuery();
				rset1.next();
				//insert into the images for radiology 
				image_id = rset1.getInt(1);
				image_id++;
				sql = ("INSERT INTO pacs_images(record_id,image_id,thumbnail,regular_size,full_size)"
						+ " values (?,?,?,?,?)");
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,radiology_id);
				pstmt.setInt(2,image_id);
				pstmt.setBlob(3,thumbnail_stream);
				pstmt.setBlob(4,regular_stream);
				pstmt.setBlob(5,full_stream);
				pstmt.execute();
				pstmt.close();
				thumbnail_outstream.close();
				regular_outstream.close();
				full_stream.close();
				conn.commit();
			}
				//close all streams and statements

				pstmt.close();
				conn.close();
				response_message = "The Images Have been Uploaded";

		}
		catch (Exception ex) {
			response_message = ex.getMessage();
		}

				//Output response to the client if image uploaded properly			response.setContentType("text/html");
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
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");

	}

		//This creates a connection to database for insertion of picture
	public Connection mkconn(){
		String USER = "rdejesus"; 	//Change these parameters when testing to your oracle password :)
		String PASSWORD = "Ihateyou1";
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











