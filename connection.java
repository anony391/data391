import java.sql.*;

class connection{
  public Connection  mkconnection(){
    Connection conn = null;
    String driverName = "oracle.jdbc.driver.OracleDriver";
    String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try {
      Class drvClass = Class.forName(driverName);
      DriverManager.registerDriver((Driver) drvClass.newInstance());
      conn = DriverManager.getConnection(dbstring, "rdejesus", "pswd123"); //changethispswd
      conn.setAutoCommit(false);
      return conn;
    }
    catch(Exception ex){
      throw IOException("Connection not made.");
    }
}		

