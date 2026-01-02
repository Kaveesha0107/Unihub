package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConnect {
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        
        String username = "root";
        String password = "12345678";

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/unihub?useSSL=false&allowPublicKeyRetrieval=true";
        Connection con = DriverManager.getConnection(url, username, password);

        return con;
    }
}
