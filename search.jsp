<HTML><BODY>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="connectionmaker.*"%>
<%@ page import="sqlcontrol.*"%>


<%
	String login_class = (String) session.getAttribute("login_class");
	String id_number = (String) session.getAttribute("id_number");
	if (login_class == null){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");

	}
	else{out.println("<table align=left valign=top><li><a href=\"Home_Menu.jsp\">HOME</li></a></table>");
%>
<%@ include file="Search_database.html"%>
<%}%>
<% 		
	if (request.getParameter("search") != null){
		login_class = (String) session.getAttribute("login_class");
		id_number = (String) session.getAttribute("id_number");
		connmaker cn = null;
		Connection conn = null;
		sqlcontroller scontroller = null;
		String query = request.getParameter("query");
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		String rankType = request.getParameter("rankType");
		ResultSet rset = null;
		ResultSet rset2 = null;

		try{
			cn = new connmaker();
			conn = cn.mkconn(); 	//creates a connection with database by using connectionmaker class
 		}
			catch(Exception ex){
			out.println("<hr>"+ ex.getMessage() + "<hr>");
		}

		try{
			scontroller = new sqlcontroller();
			if(query.equals("") && rankType.equals("keywords")){
				out.println("<b>ERROR: No Keywords Entered. Cannot Rank by keywords!! </b><br>");
			}
			rset = scontroller.search_database(conn, query, toDate, fromDate, rankType, id_number, login_class);
			String p_id = null;
			out.println("<table border=1 valign=bottom align=center>");
			out.println("<b>Results for '"+query+"' Ranked by " +rankType+"</b>");
			out.println("dates between "+fromDate+" to "+toDate);
			out.println("<tr>");
			out.println("<th>Record ID</th>");
			out.println("<th>Patient ID</th>");
			out.println("<th>Doctor ID</th>");
			out.println("<th>Radiologist ID</th>");
			out.println("<th>Test Type</th>");
			out.println("<th>Prescribing Date</th>");
			out.println("<th>Test Date</th>");
			out.println("<th>Diagnosis</th>");
			out.println("<th>Description</th>");
			out.println("<th>Images</th>");
			out.println("</tr>");
			while(rset.next()) {
		        	out.println("<tr>");
		        	out.println("<td>"); 
			       	out.println(rset.getInt(2));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getInt(5));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getInt(6));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getInt(7));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getString(8));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getDate(9));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getDate(4));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getString(10));
				out.println("</td>");
		        	out.println("<td>"); 
			       	out.println(rset.getString(11));
				out.println("</td>");
				out.println("<td>");
				out.println("<table>");
				rset2 = scontroller.search_images(conn, Integer.toString(rset.getInt(1)));
				while(rset2.next()) {
					String image_id = Integer.toString(rset2.getInt(1));
					String record_id = Integer.toString(rset2.getInt(2));
					p_id = image_id+","+record_id;
					out.println("<tr>");
					out.println("<td>"); 
					out.println("<a href=\"/data391/servlet/GetBigPic?"+p_id+"\">");
					out.println("<img src=\"/data391/servlet/GetOnePic?"+p_id+"\"></a>");
					out.println("</td>");
					out.println("<td>"); 
					out.println("<a href=\"/data391/servlet/GetFullPic?"+p_id+"\">");
					out.println("FullSize</a>");
					out.println("</td>");
					out.println("</tr>"); 
				}
				out.println("</table>");
				out.println("</td>");
				out.println("</tr>");
		      	} 
			out.println("</table>");
			conn.close();
		}	
		catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
			conn.close();
		}
	}
%>

</HTML></BODY>

