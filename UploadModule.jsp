<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="sqlcontrol.*"%>

<%@ include file="new_radiology_record.html"%>
<FORM id= "Upload-form" NAME="UPLOADFORM" enctype="multipart/form-data" ACTION="UploadModule.jsp" METHOD="post" autocomplete="off">
    <TABLE>
        <TR ALIGN=LEFT>
            <TD><B><I>Image Source:</I></B></TD>
            <TD><INPUT TYPE="file" SIZE="30" NAME="IMAGESRC"></TD>
        </TR>
</FORM>
</TABLE>
<TABLE>
    <TR><TD><INPUT TYPE="submit" NAME="Upload" VALUE="UPLOAD FILE"><INPUT TYPE="submit" NAME="UploadMore" VALUE="UPLOAD MORE FILES"></TR></TD>
    <TR ALIGN=CENTER><TD><INPUT TYPE="hidden" NAME="Create" VALUE="CREATE_RADIOLOGY_RECORD">
    <INPUT TYPE="submit" NAME="Submit" VALUE="SUBMIT"></TR></TD>
</FORM>
</TABLE>
</body>
</html>
