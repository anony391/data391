<%@ page import="java.sql.*" %>
<%@ page import="connectionmaker.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <title>Inverted Index example</title>
  </head>
  <body>   
      <table>
        <tr>
          <td><input type=text name=query></td>
          <td><input type=submit value="Search" name="search"></td>
        </tr>
      </table>

              Query the database to see relevant items
      <table>
        <tr>
          <td>
            <input type=text name=query>
          </td>
          <td>
            <input type=submit value="Search" name="search">
          </td>
        </tr>
      </table>
      <% Connection m_con = null;

	connmaker cn = null;
	try{
	cn = new connmaker();
        m_con = cn.mkconn(); 	//creates a connection with database by using connectionmaker class
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() + "<hr>");
    }
        
          if (request.getParameter("search") != null)
          {
          
          	out.println("<br>");
          	out.println("Query is " + request.getParameter("query"));
          	out.println("<br>");
          
            if(!(request.getParameter("query").equals("")))
            {
              PreparedStatement doSearch = m_con.prepareStatement("SELECT score(1), record_id, description FROM radiology_record WHERE contains(description, ?, 1) > 0");
              doSearch.setString(1, request.getParameter("query"));
              ResultSet rset2 = doSearch.executeQuery();
              out.println("<table border=1>");
              out.println("<tr>");
              out.println("<th>Item Name</th>");
              out.println("<th>Item Description</th>");
              out.println("<th>Score</th>");
              out.println("</tr>");
              while(rset2.next())
              {
                out.println("<tr>");
                out.println("<td>"); 
                out.println(rset2.getInt(2));
                out.println("</td>");
                out.println("<td>"); 
                out.println(rset2.getString(3)); 
                out.println("</td>");
                out.println("<td>");
		ByteArrayOutputStream thumbnail_outstream = new ByteArrayOutputStream();
		ImageIO.write(rset2.getBLOB(1), "png", thumbnail_outstream);
		BufferedImage img = ImageIO.read(new ByteArrayInputStream(data));

                out.println(<img src= img);
                out.println("</td>");
                out.println("</tr>");
              } 
              out.println("</table>");
            }
            else
            {
              out.println("<br><b>Please enter text for quering</b>");
            }            
          }
          m_con.close();
        }
        catch(SQLException e)
        {
          out.println("SQLException: " +
          e.getMessage());
			m_con.rollback();
        }
      %>
    </form>
  </body>
</html>
