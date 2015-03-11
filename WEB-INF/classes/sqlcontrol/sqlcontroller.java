/*This code is for making the connection to oracle and sending and retrieving information about login data
*/
package sqlcontrol;
import java.sql.*;
import java.io.*;
import java.io.IOException;

public class sqlcontroller{
  public boolean logincheck(String user, String password, Connection conn) throws IOException, SQLException{
    Statement stmt = null;
    ResultSet rset = null;
    String sqlstring = "SELECT password FROM users WHERE user_name = '"+user+"'";
    try{
      stmt = conn.createStatement();
      rset = stmt.executeQuery(sqlstring);
    }
    catch(Exception ex){
      throw new IOException("Cannot retrieve information from database server.");

    }
    String dbpassword = "";     //checking if results includes logininfo
    while(rset != null && rset.next()){
        dbpassword = rset.getString(1).trim();
        if(password.equals(dbpassword)){        //need to change this to going to nextpag
            return true;
        }
        else{
            return false;
        }
    }
    return false;
}}
