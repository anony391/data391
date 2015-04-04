<head lang="en">
    <meta charset="UTF-8">
    <title>Create New Radiology Record</title>
    <link rel="stylesheet" type="text/css" href="RadiologyDatabase.css">
</head>

<title>Upload Example</title>
<script language="JavaScript">//This was taken from http://www.javacodegeeks.com/2013/01/spring-mvc-3-upload-multiple-files.html @author: Srinivas Ovn
	var count=0;
	function add(type) {
		//Create an input type dynamically.
		var table = document.getElementById("fileUploadTable");
		var tr = document.createElement("tr");
		var td = document.createElement("td");
		var element = document.createElement("input");
	 
		//Assign different attributes to the element.
		element.setAttribute("type", "file");
		element.setAttribute("value", "");
		element.setAttribute("name", "fileData["+type+"]");
		//Append the element in page (in span).
		td.appendChild(element);
		tr.appendChild(td);
		table.appendChild(tr);
	}
</script>

<body>
<% 	String login_class = (String) session.getAttribute("login_class");	//checks if logged in and can access this page
	if (login_class == null){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");

	}

	else if (!(login_class.equals("r"))){
		out.println("You are not authorized to access this page.");
		out.println("<li><a href=\"Home_Menu.jsp\">Return</li>");
	}

	else{out.println("<table align=left valign=top><li><a href=\"Home_Menu.jsp\">HOME</li></a></table>");

%>
  <%@ include file="ImageUpload.html"%><%}%>
	<TABLE id="fileUploadTable">
	<!--td><form:label for="fileData" path="fileData">File</form:label><br />
	</td>
	<td><input name="fileData[0]" id="image0" type="file" /></td>
	<td><input name="fileData[1]" id="image1" type="file" /></td-->
	</form>
	</table>
	</body>
	</html>
