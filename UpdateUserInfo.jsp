<head lang="en">
    <meta charset="UTF-8">
    <title>Update User Information</title>
    <link rel="stylesheet" type="text/css" href="RadiologyDatabase.css">
</head>

<body>
<% 	String login_class = (String) session.getAttribute("login_class");
	if (login_class == null){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");

	}

	else if (!(login_class.equals("a"))){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");
	}

	else{out.println("<table align=left valign=top><li><a href=\"Home_Menu.jsp\">HOME</li></a></table>");

%>
  <%@ include file="UpdateUserInfo.html"%><%}%>
	

</body>
</html>
