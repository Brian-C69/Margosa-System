package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlCon {
    private static Connection connection = null;
    public static Connection getConnection() 
            throws SQLException, ClassNotFoundException {
        if (connection == null){
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Margosa","margosa","margosa");
            System.out.print("Connected to Margosa Database");      
        }
        return connection;
    }
}