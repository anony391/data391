<HTML><BODY>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="connectionmaker.*"%>
<%@ page import="sqlcontrol.*"%>


<%											//Checks if logged in. rejects if not logged in.
	String login_class = (String) session.getAttribute("login_class");	
	String id_number = (String) session.getAttribute("id_number");
	if (login_class == null){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");

	}
	else{out.println("<table align=left valign=top><li><a href=\"Home_Menu.jsp\">HOME</li></a></table>");}	//homelink
											//if entered key word to search do this
	
		String p_id = (String) request.getQueryString();
		out.println("<center>");	
		out.println("<a href=\"/data391/servlet/GetFullPic?"+p_id+"\">");			//to access images
		out.println("<img src=\"/data391/servlet/GetBigPic?"+p_id+"\"></a>");
		out.println("</a>");
		out.println("</center>");	

%>

</HTML></BODY>

