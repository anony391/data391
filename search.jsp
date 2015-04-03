<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="connectionmaker.*"%>
<%@ page import="sqlcontrol.*"%>

    <% 		
	Connection m_con = null;
	connmaker cn = null;
	if (request.getParameter("search") != null){
          	out.println("<br>");
          	out.println("Query is " + request.getParameter("query"));
          	out.println("<br>");
        	if(!(request.getParameter("query").equals(""))){
			try {
				cn = new connmaker();
        			m_con = cn.mkconn(); 	//creates a connection with database by using connectionmaker class
    			}
	    		catch(Exception ex){
				out.println("<hr>"+ ex.getMessage() + "<hr>");
	    		}
            PreparedStatement doSearch = m_con.prepareStatement("SELECT p.image_id, r.record_id, r.description, score(1) FROM radiology_record r ,pacs_images p WHERE p.record_id = r.record_id AND contains(description, ?, 1) > 0");
			doSearch.setString(1, request.getParameter("query"));
			ResultSet rset2 = doSearch.executeQuery();
			String image_id = Integer.toString(rset.getInt(1));
			String record_id = Integer.toString(rset.getInt(2));
			String p_id = image_id+","+record_id;
			out.println("<table border=1>");
			out.println("<tr>");
			out.println("<th>Item Name</th>");
			out.println("<th>Item Description</th>");
			out.println("<th>Score</th>");
			out.println("</tr>");
			while(rset2.next()) {
		        	out.println("<tr>");
		        	out.println("<td>"); 
			       	out.println(rset2.getInt(2));
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset2.getString(3)); 
				out.println("</td>");
				out.println("<td>");
					out.println("<img src=\"/servlet/GetOnePic?"+p_id+"\">");
				out.println("</td>");
				out.println("</tr>");
		      	} 
			out.println("</table>");
			m_con.close();
		}
	}
      %>
<%@ include file="Search_database.html"%>

