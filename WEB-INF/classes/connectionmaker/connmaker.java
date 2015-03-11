/*This code is for making the connection to oracle and sending and retrieving information about login data
*/
package connectionmaker;
import java.sql.*;
import java.io.*;
import java.io.IOException;

/*This method creates a connection to connect to oracle*/
public class connmaker{
  String USER = ""; //Change these parameters when testing to your oracle password :)
  String PASSWORD = "";
  public Connection mkconn(){
    Connection conn = null;
    String driverName = "oracle.jdbc.driver.OracleDriver";
    String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try {
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

/*This method takes the parameters and sends statements to SQL to retrieve any login info to see if user can log in.
*/
  public boolean logincheck(String user, String password, Connection conn) throws IOException, SQLException{
    Statement stmt = null;
    ResultSet rset = null;
    String sqlstring = "SELECT password FROM users WHERE user_name = '"+user+"'";
    try{
      stmt = conn.createStatement();
      rset = stmt.executeQuery(sqlstring);
    }
    catch(Exception ex){
      conn.close();
      throw new IOException("Cannot retrieve information from database server.");

    }
    String dbpassword = "";  	//checking if results includes logininfo
    while(rset != null && rset.next()){
        dbpassword = rset.getString(1).trim();
        if(password.equals(dbpassword)){ 	//need to change this to going to nextpage
	    conn.close();
	    return true;
        }
        else{
	    conn.close();
            return false;
        }
    }
    return false;
}}






