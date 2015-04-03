<%@ page import="java.sql.*, java.util.*" %>
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
      <%
        
          if (request.getParameter("search") != null)
          {
          
          	out.println("<br>");
          	out.println("Query is " + request.getParameter("query"));
          	out.println("<br>");
          
            if(!(request.getParameter("query").equals("")))
            {
              PreparedStatement doSearch = m_con.prepareStatement("SELECT score(1), itemName, description FROM item WHERE contains(description, ?, 1) > 0 order by score(1) desc");
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
                out.println(rset2.getString(2));
                out.println("</td>");
                out.println("<td>"); 
                out.println(rset2.getString(3)); 
                out.println("</td>");
                out.println("<td>");
                out.println(rset2.getObject(1));
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